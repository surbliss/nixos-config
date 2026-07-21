let
  port = 28981;
  caddy-port = 28980;
in
{
  flake.modules.nixos.home-server = { config, ... }: {
    services.paperless = {
      enable = false;
      address = "127.0.0.1";
      domain = "server-surface.quagga-toad.ts.net:${toString caddy-port}";
      inherit port; # Default
      configureTika = true;
      ### Sets PAPERLESS_SOCIALACCOUNT_PROVIDERS for open_id, see https://pocket-id.org/docs/client-examples/paperless-ngx
      environmentFile = config.age.secrets.PAPERLESS_ENV.path;
      settings = {
        # Part of open_id-login setup, together with env-file above
        PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";

        # Only show open_id login as an option
        PAPERLESS_DISABLE_REGULAR_LOGIN = true;
        PAPERLESS_REDIRECT_LOGIN_TO_SSO = true;

        # For email redirects?
        PAPERLESS_URL = "https://server-surface.quagga-toad.ts.net:${toString caddy-port}";

        # Improve OCR for danish documents (tries both danish and english)
        # NOTE: Setting PAPERLESS_OCR_LANGUAGES only works in docker containers, so we need to override tesseract5 manually instead.
        # _But_ the nixos-module automatically adds the appropriate override, as seen at https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/misc/paperless.nix
        PAPERLESS_OCR_LANGUAGE = "dan+eng";

        # For date parsing
        PAPERLESS_TIME_ZONE = "Europe/Copenhagen";
        # Human readable filenames, in case of any future exports
        PAPERLESS_FILENAME_FORMAT = "{created_year}/{correspondent}/{title}";
      };
    };

    preservation.preserveAt."/persistent" = {
      # Preserve data-files
      directories = [
        {
          directory = "/var/lib/paperless";
          user = "paperless";
          group = "paperless";
          mode = "0750";
        }
      ];
    };

    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:${toString caddy-port}".extraConfig =
      ''
        reverse_proxy localhost:${toString port}
      '';
    networking.firewall.allowedTCPPorts = [ caddy-port ];

  };
}
