{ ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    # Autorun XDG autostart files
    # desktopManager.runXdgAutostartIfNone = true;
    dpi = 120;
  };
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    ## Consider putting config here, so it is installed with NixOS, when done
    ## configuring
    # config = ./xmonad.hs;
  };
}
