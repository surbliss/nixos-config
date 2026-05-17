{
  flake.modules.nixos.home-server =
    { config, ... }:
    {
      virtualisation.docker.enable = true;
      virtualisation.oci-containers.backend = "docker";
      # source: https://docs.kitchenowl.org/latest/self-hosting/
      virtualisation.oci-containers.containers.kitchen-owl = {
        image = "tombursch/kitchenowl:latest";
        ports = [ "5000:8080" ];
        environmentFiles = [ config.age.secrets.KITCHENOWL_ENV.path ];
        volumes = [ "/persistent/kitchenowl_data:/data" ];
        autoStart = true;
      };
      networking.firewall.allowedTCPPorts = [ 5000 ];

      ### NOTE: Not needed, since we mounting directly on '/persistent/' above
      # Preserve data-files
      # preservation.preserveAt."/persistent".directories = [
      #   "/var/lib/docker/volumes/kitchenowl_data"
      # ];
    };
}
