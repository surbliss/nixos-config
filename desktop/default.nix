{ pkgs, ... }: # Anything relating to theming, or visuals?
let
  catppuccin-sddm = pkgs.catppuccin-sddm.override { flavor = "mocha"; };
in
{
  # This should just be merged in, but leaving it there, as a good example of
  # how to construct a module
  imports = [
    ./cursor.nix
    ./fonts.nix
  ];
  custom.cursor.enable = true;

  # TODO: Move this to system/video.nix
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm; # Use Qt6 version
    # extraPackages = [ ]; # Can't be set here, has to be set below!
    theme = "catppuccin-mocha";
  };

  environment.systemPackages = [
    catppuccin-sddm
    # pkgs.sddm-chili-theme
  ];

  services.displayManager.defaultSession = "none+xmonad";

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    # Autorun XDG autostart files
    # desktopManager.runXdgAutostartIfNone = true;
    # dpi = 120;
  };

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    ## Consider putting config here, so it is installed with NixOS, when done
    ## configuring
    # config = ./xmonad.hs;
  };
}
### Not sure if needed
# services.xserver.desktopManager.runXdgAutostartIfNone = true;
