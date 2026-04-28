{
  flake.modules.nixos.home-server =
    { pkgs, ... }:

    let

      invidious-companion = pkgs.runCommand "invidious-companion" { } ''
          mkdir -p $out/bin
          tar -xzf ${
            pkgs.fetchurl {
              url = "https://github.com/iv-org/invidious-companion/releases/download/release-master/invidious_companion-x86_64-unknown-linux-gnu.tar.gz";
              hash = "sha256-zWYcwXFy6Sna65guhzI9Z5PeQZiNSGp1TsQJ/zISMe4=";
            }
          } -C $out/bin
        chmod +x $out/bin/invidious_companion
      '';
    in
    {

      networking.firewall.allowedTCPPorts = [
        80 # For Grocy
        3000 # For Invidious
        8080 # For hexa-game site
        9000 # For websocket
      ];

      ## Grocy: Go to https://localhost:80 (80 default port)
      services.grocy.enable = true;
      services.grocy.hostName = "localhost";
      services.grocy.nginx.enableSSL = false;
      services.grocy.settings = {
        currency = "DKK";
        calendar.showWeekNumber = true;

        calendar.firstDayOfWeek = 1;
      };

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
          ProtectHostname = "true";
          ProtectSystem = "strict";
          RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX";

          # WorkingDirectory = "/home/invidious/invidious-companion";

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
