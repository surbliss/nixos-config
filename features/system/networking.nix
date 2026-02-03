{
  flake.modules.nixos.system =
    { pkgs, ... }:
    {

      # Don't enable iwd, doesn't mash well with eduroam
      networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
        wifi.powersave = false;
      };
      networking.wireless.iwd.enable = true;
      networking.wireless.iwd.settings = {
        General.EnableNetworkConfiguration = true;
        Network.EnableIPv6 = true;
        Settings.AutoConnect = true;
      };

      services.gnome.gnome-keyring.enable = true;
      # Remember to set host-name in host-configuration
      # Also add "networkmanager" to users 'extraGroups'

      environment.systemPackages = with pkgs; [
        networkmanagerapplet # (For logging into eduroam)
        geteduroam
        geteduroam-cli
        networkmanager_dmenu
      ];
      # # For vnc casting to iPad
      # networking.firewall.allowedTCPPorts = [ 5900 ];
    };
}
