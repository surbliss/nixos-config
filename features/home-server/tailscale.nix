let
  tailscale-module = {
    services.tailscale.enable = true;
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    services.tailscale.extraUpFlags = [ "--accept-dns=true" ];
  };
in
{
  flake.modules.nixos.home-server = tailscale-module // {

    # Caddy certification
    services.caddy.enable = true;
    services.caddy.virtualHosts."https://server-surface.quagga-toad.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:5000
      '';
    };

    preservation.preserveAt."/persistent" = {
      directories = [
        "/var/lib/tailscale"
        "/var/lib/caddy"
      ];
    };
  };

  flake.modules.nixos.cli = tailscale-module;
}
