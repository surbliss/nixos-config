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
  wayland-tools = with pkgs; [
    mako # Notifications
    waybar
    swaylock
    xwayland-satellite # X11 compatibility
    wl-clipboard
    wl-clipboard-x11
    wl-clip-persist
    fuzzel # Application picker
    wofi
    wofi-power-menu
    wofi-emoji
    wlr-randr # Monitor-info
    # Casting/sharing screen
    wayvnc
    wf-recorder
    wl-mirror
    wbg # Set background
  ];
  other = with pkgs; [
    nautilus # Default file picker
    alacritty # Defauls niri terminal, in case config is messed up
    kdlfmt # Formatter for niri config
  ];
in
{
  options.custom.niri = {
    enable = mkEnableOption "niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;

    # For vnc casting to iPad
    networking.firewall.allowedTCPPorts = [ 5900 ];

    # For integration with Gnome-wayland tools
    services.gnome.gnome-keyring.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    programs.waybar = {
      enable = true;
      systemd.target = "niri.service";
    };
    # systemd.user.units."niri.service".wantedBy = "mako.service";
    # Chromium + Electron without Xwayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = wayland-tools ++ other;
  };
}
