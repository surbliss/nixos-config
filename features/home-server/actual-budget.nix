{
  flake.modules.nixos.home-server =
    { pkgs, ... }:
    {
      services.actual = {
        # Actual Budget: Budgeting-application
        enable = true;
        settings = {
          # Default port is 3000, conflicts with Invidious
          port = 6000;
          # The default, but made explicit for the preservation module
          # Note: DynamicUser = true means systemd stores data at /var/lib/private/actual and creates /var/lib/actual as a symlink to it.
          dataDir = "/var/lib/actual";
        };
      };

      # certutil for Caddy
      environment.systemPackages = [ pkgs.nssTools ];
      # HTTPS certification with Caddy
      services.caddy = {
        enable = true;
        openFirewall = true;
      };

      services.caddy.virtualHosts."actual.home" = {
        extraConfig = ''
          tls internal
          reverse_proxy localhost:6000
        '';
      };

      preservation.preserveAt."/persistent" = {
        # As the systemd service enabled by the process above sets 'DynamicUser = true;', the actual data is stored in /var/lib/private. Trying to preserve /var/lib/actual causes an error, because the service expects that file to not exist.
        directories = [
          "/var/lib/private/actual"
          # Where certificates are stored
          "/var/lib/caddy"
        ];
      };
    };

  # Trust generated certificate from caddy on main machine
  flake.modules.nixos.system = {
    # Give caddy something to connect to
    networking.hosts = {
      "192.168.0.247" = [ "actual.home" ];
    };

    security.pki.certificates = [
      # Caddy certificate
      ''
        -----BEGIN CERTIFICATE-----
        MIIBpDCCAUqgAwIBAgIRAOfkNC5o9p9ADfUfhkOe4jMwCgYIKoZIzj0EAwIwMDEu
        MCwGA1UEAxMlQ2FkZHkgTG9jYWwgQXV0aG9yaXR5IC0gMjAyNiBFQ0MgUm9vdDAe
        Fw0yNjA1MjExMjA0NTVaFw0zNjAzMjkxMjA0NTVaMDAxLjAsBgNVBAMTJUNhZGR5
        IExvY2FsIEF1dGhvcml0eSAtIDIwMjYgRUNDIFJvb3QwWTATBgcqhkjOPQIBBggq
        hkjOPQMBBwNCAAS0R6iJmTlybxEnBJW9+5vyVmAV925afEpWHdtMgBWJqtG6Fzpr
        yCkB4L59E/NQ4poLVQL+ruIriqQYAFarKir2o0UwQzAOBgNVHQ8BAf8EBAMCAQYw
        EgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQUTu1FE+e3Iif+nFWbvr/dEIEp
        HV4wCgYIKoZIzj0EAwIDSAAwRQIga62kr/8c8+kUM9qKlKmksAFV+hVayG+urzOD
        m3xrx6UCIQC7uL/xRtxwWkJeKvw6b6uVbh58iU5LR8ybF6C/gOXQ+Q==
        -----END CERTIFICATE-----
      ''
    ];
  };
}
