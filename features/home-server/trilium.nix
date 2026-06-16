let
  trilium-data-dir = "/var/lib/trilium";
in
{
  flake.modules.nixos.home-server = { config, ... }: {
    services.trilium-server = {
      enable = true;
      dataDir = trilium-data-dir; # The default

      host = "127.0.0.1";
      port = 9050;

      # Sets env-vars for TRILIUM_MULTIFACTORAUTHENTICATION_ settings, to configure OpenID login with Pocket ID.
      environmentFile = config.age.secrets.TRILIUM_ENV.path;
    };

    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:9051".extraConfig =
      ''
        reverse_proxy localhost:9050
      '';

    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = trilium-data-dir;
          mode = "0755";
          user = "trilium";
          group = "trilium";
        }
      ];
    };

  };
}
