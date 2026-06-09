{
  flake.modules.nixos.home-server = {
    # Caddy certification
    services.tailscale.enable = true;
    services.tailscale.extraUpFlags = [ "--accept-dns=true" ];
    services.tailscale.permitCertUid = "caddy";
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    # Caddy

    services.caddy.enable = true;
    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net".extraConfig = ''
      tls {
        get_certificate tailscale
      }

      # PocketID as default host
      redir https://server-surface.quagga-toad.ts.net:1412
    '';

    preservation.preserveAt."/persistent" = {
      directories = [
        "/var/lib/tailscale"
        "/var/lib/caddy"
      ];
    };
  };

  flake.modules.nixos.cli = {
    services.tailscale.enable = true;
    services.tailscale.extraUpFlags = [ "--accept-dns=true" ];
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
