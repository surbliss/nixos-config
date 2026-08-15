let
  koffan-port = 1500;
  caddy-port = koffan-port + 1;
  db-path = "/var/lib/koffan/shopping.db";
in
{
  flake.modules.nixos.home-server = { pkgs, ... }: {
    systemd.services.koffan = {
      description = "Koffan grocery list";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.koffan ];
      environment = {
        DISABLE_AUTH = "true";
        PORT = toString koffan-port;
        DB_PATH = db-path;
      };

      serviceConfig = {
        Type = "simple";
        DynamicUser = true;
        StateDirectory = "koffan";
        ExecStart = "${pkgs.koffan}/bin/shopping-list";
        Restart = "on-failure";
        # Koffan doesn't create the db on its own, so make sure it exists.
        ExecStartPre = "${pkgs.coreutils}/bin/touch ${db-path}";
      };
    };

    services.caddy.enable = true;
    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:${toString caddy-port}".extraConfig =
      ''
        reverse_proxy localhost:${toString koffan-port}
      '';
    networking.firewall.allowedTCPPorts = [ caddy-port ];

    preservation.preserveAt."/persistent" = {
      directories = [ "/var/lib/private/koffan" ];
    };
  };
}
