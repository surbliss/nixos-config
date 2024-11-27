{ pkgs, ... }:
{
  #FIX: Reparer polybar, og skift xmobar ud med det.
  #Enten konfigurer i xmonad.hs, ellers få nedenstående til at virke...
  services.polybar = {
    enable = true;
    # For testing: run polybar -c ~/.config/home-manager/polybar/config.ini example&
    script = "polybar default&";
    config = ./config.ini;
    package = pkgs.polybarFull;
    # config = {
    #   "bar/top" = {
    #     monitor = "\${env:MONITOR:eDP1}";
    #     width = "100%";
    #     height = "3%";
    #     radius = 0;
    #     modules-center = "date";
    #   };
    #
    #   "module/date" = {
    #     type = "internal/date";
    #     internal = 5;
    #     date = "%d.%m.%y";
    #     time = "%H:%M";
    #     label = "%time%  %date%";
    #   };
    # };
  };
}
