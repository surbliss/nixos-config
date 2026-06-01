{
  flake.modules.nixos.home-server =
    { config, ... }:
    let
      inherit (config.age) secrets;
    in
    {

      # For authentication
      services.pocket-id.enable = true;
      services.pocket-id.credentials = {
        ENCRYPTION_KEY = secrets.POCKET_ID_ENCRYPTION_KEY.path;
      };
      services.pocket-id.settings = {
        ANALYTICS_DISABLED = true;
        VERSION_CHECK_DISABLED = true;
        APP_URL = "https://server-surface.quagga-toad.ts.net:1412";
        TRUST_PROXY = true;
        HOST = "127.0.0.1";
        PORT = 1411; # The default
        ### UI Configs
        UI_CONFIG_DISABLED = true;
        HOME_PAGE_URL = "/settings/apps"; # Start-screen
      };

      # Pocket ID, explicit port
      services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:1412".extraConfig =
        ''
          reverse_proxy localhost:1411
        '';
      networking.firewall.allowedTCPPorts = [ 1412 ];

      preservation.preserveAt."/persistent" = {
        directories = [
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
