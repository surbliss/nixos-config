{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    # mkOption
    # mkPackageOption
    # types
    ;
  cfg = config.custom.niri;
in
{
  options.custom.niri = {
    enable = mkEnableOption "niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;

    networking.firewall.allowedTCPPorts = [ 5900 ];

    environment.systemPackages = with pkgs; [
      kdlfmt
      mako
      nautilus
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-gnome
      # gnome-keyring
      # plasma-polkit-agent
      waybar
      alacritty
      fuzzel
      swaylock
      xwayland-satellite
      wl-clipboard
      wlogout
      wlr-randr
      wayvnc
      wf-recorder
      wl-mirror
    ];
  };
}
