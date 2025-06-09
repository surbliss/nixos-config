{ pkgs, ... }:
# let
#   catppuccin-sddm = pkgs.catppuccin-sddm.override { flavor = "mocha"; };
# in
{
  # TODO: Move this to system/video.nix
  # services.displayManager.sddm = {
  #   enable = true;
  #   package = pkgs.kdePackages.sddm; # Use Qt6 version
  #   # extraPackages = [ ]; # Can't be set here, has to be set below!
  #   theme = "catppuccin-mocha";
  # };
  #
  # environment.systemPackages = [
  #   catppuccin-sddm
  #   # pkgs.sddm-chili-theme
  # ];
  #
  # services.displayManager.defaultSession = "none+xmonad";
  services.greetd = {
    enable = true;
    # settings = rec {
    #   initial_session = {
    #     # command = "${pkgs.xmonad}/bin/xmonad";
    #     user = "angryluck";
    #   };
    #   default_session = initial_session;
    # };
  };

}
