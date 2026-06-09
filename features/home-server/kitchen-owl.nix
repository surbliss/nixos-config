{
  flake.modules.nixos.home-server = { config, ... }: {
    virtualisation.docker.enable = true;
    preservation.preserveAt."/persistent" = {
      # Preserve data-files
      directories = [
        # Big docker-images are redownloaded on reboot otherwise, and then fills a lot of space on the RAM-storage. This also ensures the kitchenowl data is stored.
        "/var/lib/docker"
      ];
    };

    virtualisation.oci-containers.backend = "docker";
    # source: https://docs.kitchenowl.org/latest/self-hosting/
    virtualisation.oci-containers.containers.kitchen-owl = {
      image = "tombursch/kitchenowl:latest";
      ports = [ "127.0.0.1:5000:8080" ];
      environmentFiles = [ config.age.secrets.KITCHENOWL_ENV.path ];
      volumes = [ "kitchenowl_data:/data" ];
      autoStart = true;
    };

    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:5001".extraConfig =
      ''
        reverse_proxy localhost:5000
      '';

    networking.firewall.allowedTCPPorts = [ 5001 ];
  };
}
