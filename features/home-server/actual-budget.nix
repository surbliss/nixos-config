{
  flake.modules.nixos.home-server =
    { config, pkgs, ... }:
    let
      inherit (config.age) secrets;
    in
    {
      services.actual = {
        # Actual Budget: Budgeting-application
        enable = true;
        settings = {
          # Default port is 3000, conflicts with Invidious
          port = 6000;
          # The default, but made explicit for the preservation module
          # Note: DynamicUser = true means systemd stores data at /var/lib/private/actual and creates /var/lib/actual as a symlink to it.
          dataDir = "/var/lib/actual";
          hostname = "127.0.0.1";

          # OpenID setup
          # openId.discoverURL = "";
        };
      };

      # certutil for Caddy
      environment.systemPackages = [ pkgs.nssTools ];
      # HTTPS certification with Caddy
      services.caddy = {
        enable = true;
        openFirewall = true;
      };
      # Actual Budget
      services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:6001".extraConfig =
        ''
          reverse_proxy localhost:6000
        '';
      # Pocket ID
      services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:1412".extraConfig =
        ''
          reverse_proxy localhost:1411
        '';
      networking.firewall.allowedTCPPorts = [
        6001
        1412
      ];

      # For Actual authentication
      services.pocket-id.enable = true;
      services.pocket-id.credentials = {
        ENCRYPTION_KEY = secrets.POCKET_ID_ENCRYPTION_KEY.path;
      };
      services.pocket-id.settings = {
        ANALYTICS_DISABLED = true;
        APP_URL = "https://server-surface.quagga-toad.ts.net:1412";
        TRUST_PROXY = true;
        HOST = "127.0.0.1";
        PORT = 1411; # The default
      };

      ## Pocket-ID port
      # networking.firewall.allowedTCPPorts = [ 1411 ];

      preservation.preserveAt."/persistent" = {
        # As the systemd service enabled by the process above sets 'DynamicUser = true;', the actual data is stored in /var/lib/private. Trying to preserve /var/lib/actual causes an error, because the service expects that file to not exist.
        directories = [
          "/var/lib/private/actual"
          {
            directory = "/var/lib/pocket-id";
            mode = "0755";
            user = "pocket-id";
            group = "pocket-id";
          }
        ];
      };
    };
}
