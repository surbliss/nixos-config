{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Images
        imv
        feh

        # PDF
        zathura
        sioyek

        # Videos
        mpv-unwrapped
        vlc
      ];

    };

  flake.modules.nixos.gui = {
    xdg.mime = {
      enable = true;
      # Use 'just mime' from justfile to query for application-names
      defaultApplications = {
        "application/pdf" = [
          "sioyek.desktop"
          "org.pwmt.zathura.desktop"
          "org.pwmt.zathura-pdf-mupdf.desktop"
          "org.pwmt.zathura-pdf-djvu.desktop"
          "org.pwmt.zathura-pdf-ps.desktop"
          "org.pwmt.zathura-pdf-cb.desktop"
        ];

        "image/*" = [
          "imv.desktop"
          "feh.desktop"
        ];

        "video/*" = [
          "mpv.desktop"
          "umpv.desktop"
          "vlc.desktop"
        ];

      };
    };
  };
}
