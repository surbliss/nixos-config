{
  flake.modules.nixos.system =
    { pkgs, ... }:
    {

      # Don't enable iwd, doesn't mash well with eduroam
      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.powersave = false;

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
