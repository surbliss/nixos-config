{
  flake.modules.nixos.home-server = {
    services.uptime-kuma.enable = true;
    services.uptime-kuma.settings = {
      # DATA_DIR = "/var/lib/uptime-kuma"; # The default, and cant be overridden without lib.mkForce
      HOST = "127.0.0.1";
      PORT = "10000";
    };

    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:10001".extraConfig =
      ''
        reverse_proxy localhost:10000
      '';

    preservation.preserveAt."/persistent" = {
      # DynamicUser
      directories = [ "/var/lib/private/uptime-kuma" ];
    };
  };
}
