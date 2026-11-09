let
  tandoor-port = 11000;
  caddy-port = tandoor-port + 1;
  tandoor-path = "/var/lib/tandoor-recipes";
in
{
  flake.modules.nixos.home-server = { config, ... }: {
    services.tandoor-recipes.enable = true;
    services.tandoor-recipes.port = tandoor-port;
    services.tandoor-recipes.address = "localhost";
    services.tandoor-recipes.extraConfig = {
      SECRET_KEY_FILE = config.age.secrets.TANDOOR_SECRET_KEY.path;
      ALLOWED_HOSTS = "server-surface.quagga-toad.ts.net";

      # SOCIAL_PROVIDERS = "allauth.socialaccount.providers.openid_connect";
      # SOCIALACCOUNT_PROVIDERS_FILE =
      #   config.age.secrets.TANDOOR_SOCIALACCOUNT_PROVIDERS.path;
      # SOCIALACCOUNT_ONLY = 1;
      ACCOUNT_EMAIL_VERIFICATION = "none";
      SOCIAL_DEFAULT_ACCESS = 1;
      SOCIAL_DEFAULT_GROUP = "admin";
    };
    services.tandoor-recipes.database.createLocally = true;

    services.caddy.enable = true;
    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:${toString caddy-port}".extraConfig =
      ''
        reverse_proxy localhost:${toString tandoor-port}
      '';
    networking.firewall.allowedTCPPorts = [ caddy-port ];

    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = tandoor-path;
          # Same permission and groups as the services.memos module sets. To ensure the persisted directory is created with the correct owner and permissions.
          mode = "750";
          user = "tandoor_recipes";
          group = "tandoor_recipes";
        }
      ];
    };

  };
}
