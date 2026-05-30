{
  flake.modules.nixos.home-server =

    { config, ... }:
    let
      inherit (config.age) secrets;
    in
    {
      services.vikunja = {
        enable = true;
        # Default port + 1, letting 3456 be open for caddy
        port = 3457;
        frontendScheme = "https";
        frontendHostname = "0.0.0.0:3457";
        # Sets VIKUNJA_AUTH_OPENID_PROVIDERS_POCKETID_CLIENTSECRET
        environmentFiles = [ secrets.VIKUNJA_ENV.path ];
        settings = {
          auth.openid.enabled = true;
          auth.openid.redirecturl = "https://server-surface.quagga-toad.ts.net:3456/auth/openid/pocketid";
          auth.openid.providers.PocketID = {
            name = "PocketID";
            authurl = "https://server-surface.quagga-toad.ts.net:1412";
            clientid = "4a73654c-05e1-4a8b-8bd8-203a1d4fa3c3";
            scope = "openid profile email";
            forceuserinfo = false; # The default
          };
        };
      };

      preservation.preserveAt."/persistent" = {
        # Preserve data-files
        files = [
          {
            file = "/var/lib/private/vikunja/vikunja.db";
            how = "symlink";
            configureParent = true;
          }
        ];
      };

      services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:3456".extraConfig =
        ''
          reverse_proxy localhost:3457
        '';
      networking.firewall.allowedTCPPorts = [ 3456 ];
    };
}
