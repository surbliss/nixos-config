{ moduleWithSystem, ... }:
{
  flake.modules.nixos.home-server = moduleWithSystem (
    { self', ... }:
    { ... }:
    {

      # Backend
      systemd.services.hexa-game = {
        description = "Hexa game backend";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${self'.packages.hexa-game-backend}/bin/hexa-game-backend";
          Restart = "on-failure";
          User = "hexa-game";
          DynamicUser = true;
        };
      };

      networking.firewall.allowedTCPPorts = [
        8080 # For hexa-game site
        9000 # For websocket
      ];

      # Frontend
      services.caddy = {
        enable = true;
        virtualHosts."http://:8080" = {
          extraConfig = ''
            root * ${self'.packages.hexa-game-frontend}
            file_server
          '';
        };
      };
    }
  );

  perSystem =
    { inputs', ... }:
    {
      packages.hexa-game-backend = inputs'.hexa-game.packages.backend;
      packages.hexa-game-frontend = inputs'.hexa-game.packages.frontend;
    };
}
