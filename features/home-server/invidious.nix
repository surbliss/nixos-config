{
  flake.modules.nixos.home-server =
    { pkgs, config, ... }:

    let
      inherit (config.age) secrets;
      invidious-src = pkgs.fetchurl {
        url = "https://github.com/iv-org/invidious-companion/releases/download/release-master/invidious_companion-x86_64-unknown-linux-gnu.tar.gz";
        hash = "sha256-n50zH2Z7HeYvAaIQKx19XvmfBqdIhntP0bGlOP/hgRc=";

      };
      invidious-companion = pkgs.runCommand "invidious-companion" { } ''
        mkdir -p $out/bin
        tar -xzf ${invidious-src} -C $out/bin
        chmod +x $out/bin/invidious_companion
      '';
    in
    {
      # Add the essential storage-folders for invidious to the persistent storage:
      preservation.preserveAt."/persistent" = {
        directories = [
          # Stores subscriptions
          {
            directory = "/var/lib/postgresql";
            user = "postgres";
            group = "postgres";
          }
        ];
      };
      # Make these secrets readable
      age.secrets = {
        ### NOTE: This is more permission than should be given, but interacting with the invidious-service is finicky. 444 should be fine for a personal server, but reconsider if connecting to the public
        INVIDIOUS_SETTINGS.mode = "444";
        INVIDIOUS_COMPANION_ENV.mode = "444";
      };

      programs.nix-ld.enable = true; # Needed for invidious-companion
      networking.firewall.allowedTCPPorts = [
        3000 # For Invidious
      ];

      services.invidious = {
        enable = true;
        nginx.enable = false;
        port = 3000;
        # Just let invidious generate this key automatically, not super important
        hmacKeyFile = null;
        settings = {
          invidious_companion = [
            { private_url = "http://localhost:8282/companion"; }
          ];
        };
        # Sets the invidious_companion_key
        extraSettingsFile = secrets.INVIDIOUS_SETTINGS.path;
      };

      # See https://raw.githubusercontent.com/iv-org/invidious-companion/refs/heads/master/invidious-companion.service
      systemd.services.invidious-companion = {
        description = "invidious-companion (companion for Invidious which handles all the video stream retrieval from YouTube servers)";
        wantedBy = [ "multi-user.target" ];
        after = [
          "network.target"
          "syslog.target"
        ];
        wants = [ "network-online.target" ];
        environment = {
          CACHE_DIRECTORY = "/var/tmp/youtubei.js";
        };
        serviceConfig = {
          # Sets SERVER_SECRET_KEY
          EnvironmentFile = secrets.INVIDIOUS_COMPANION_ENV.path;

          # Security hardening - balanced approach for Deno applications;
          ProtectHostname = true;
          ProtectSystem = "strict";
          RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX";

          ExecStart = "${invidious-companion}/bin/invidious_companion";
          Restart = "always";
          RestartSec = "2s";
          Type = "simple";
          DynamicUser = true;
          NoNewPrivileges = true;
          PrivateDevices = true;
          PrivateTmp = true;
          ProtectControlGroups = true;
          ProtectKernelLogs = true;
          ProtectKernelModules = true;
          ProtectKernelTunables = true;
          RestrictNamespaces = true;
          RestrictSUIDSGID = true;
          RestrictRealtime = true;
        };
      };
    };
}
