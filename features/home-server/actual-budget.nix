{
  flake.modules.nixos.home-server = { pkgs, ... }: {
    services.actual = {
      # Actual Budget: Budgeting-application
      enable = true;
      settings = {
        # Default port is 3000, conflicts with Invidious
        port = 6000;
        # The default, but made explicit for the preservation module
        # Note: DynamicUser = true means systemd stores data at /var/lib/private/actual and creates /var/lib/actual as a symlink to it.
        dataDir = "/var/lib/actual";
        hostname = "127.0.0.1";

        # OpenID setup
        # openId.discoverURL = "";
      };
    };

    # certutil for Caddy
    environment.systemPackages = [ pkgs.nssTools ];
    # HTTPS certification with Caddy
    services.caddy = {
      enable = true;
      openFirewall = true;
    };
    # Actual Budget
    services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:6001".extraConfig =
      ''
        reverse_proxy localhost:6000
      '';
    networking.firewall.allowedTCPPorts = [ 6001 ];

    preservation.preserveAt."/persistent" = {
      # As the systemd service enabled by the process above sets 'DynamicUser = true;', the actual data is stored in /var/lib/private. Trying to preserve /var/lib/actual causes an error, because the service expects that file to not exist.
      directories = [ "/var/lib/private/actual" ];
    };
  };
}
