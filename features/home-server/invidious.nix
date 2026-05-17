{
  flake.modules.nixos.home-server =
    { pkgs, ... }:

    let
      invidious-companion = pkgs.stdenv.mkDerivation {
        name = "invidious-companion";
        src = pkgs.fetchurl {
          url = "https://github.com/iv-org/invidious-companion/releases/download/release-master/invidious_companion-x86_64-unknown-linux-gnu.tar.gz";
          hash = "sha256-n50zH2Z7HeYvAaIQKx19XvmfBqdIhntP0bGlOP/hgRc=";
        };
        nativeBuildInputs = [ pkgs.autoPatchelfHook ];
        buildInputs = [ pkgs.stdenv.cc.cc.lib ];
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/bin
          tar -xzf $src -C $out/bin
          chmod +x $out/bin/invidious_companion
        '';
      };
    in
    {
      networking.firewall.allowedTCPPorts = [
        3000 # For Invidious
      ];

      services.invidious = {
        enable = true;
        nginx.enable = false;
        port = 3000;
        hmacKeyFile = null;
        settings = {
          invidious_companion_key = "changemechangeme";
          invidious_companion = [
            { private_url = "http://localhost:8282/companion"; }
          ];
        };
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
          SERVER_SECRET_KEY = "changemechangeme";
          CACHE_DIRECTORY = "/var/tmp/youtubei.js";
        };
        serviceConfig = {
          User = "invidious";
          Group = "invidious";

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
