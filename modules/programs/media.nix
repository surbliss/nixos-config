{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Images
        feh

        # PDF
        zathura
        sioyek

        # Videos
        mpv-unwrapped
        vlc
      ];

    };
}
