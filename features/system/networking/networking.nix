{
  flake.modules.nixos.system =
    { config, pkgs, ... }:
    {

      # Don't enable iwd, doesn't mash well with eduroam
      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.powersave = false;

      environment.etc."ssl/certs/eduroam-ca.pem" = {
        source = ./ca.pem;
        mode = "644";
      };

      ## should be enabled already if you're using NetworkManager
      networking.networkmanager.ensureProfiles.environmentFiles = [
        config.age.secrets.KU_MAIL.path
        config.age.secrets.KU_PASSWORD.path
      ];

      networking.networkmanager.ensureProfiles.profiles.eduroam = {
        connection.id = "eduroam";
        connection.type = "wifi";

        wifi.mode = "infrastructure";
        wifi.ssid = "eduroam";

        wifi-security.key-mgmt = "wpa-eap";

        "802-1x".eap = "peap";
        "802-1x".phase2-auth = "mschapv2";
        "802-1x".identity = "$KU_MAIL";
        "802-1x".anonymous-identity = "anonymous@ku.dk";
        "802-1x".password = "$KU_PASSWORD";
        "802-1x".ca-cert = "/etc/ssl/certs/eduroam-ca.pem";
        "802-1x".domain-suffix-match = "radius.ku.dk";

        ipv4.method = "auto";
        ipv6.method = "auto";
      };

      # Remember to set host-name in host-configuration
      # Also add "networkmanager" to users 'extraGroups'

      environment.systemPackages = with pkgs; [
        networkmanagerapplet # (For logging into eduroam)
        geteduroam
        geteduroam-cli
        networkmanager_dmenu

        wpa_supplicant_gui
      ];
    };
}
