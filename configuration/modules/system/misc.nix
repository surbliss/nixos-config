{
  flake.modules.nixos.system =
    { pkgs, ... }:
    {

      ### Idk bout this
      services.accounts-daemon.enable = true;

      services.autorandr.enable = true;

      services.syncthing = {
        enable = true;
      };

      services.openssh = {
        enable = true;
        settings = {
          X11Forwarding = true;
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
        openFirewall = true;
      };

      # Default apps
      xdg.mime = {
        enable = true;
        defaultApplications = {
          "application/pdf" = [
            "org.pwmt.zathura.desktop"
            "org.pwmt.zathura-pdf-mupdf.desktop"
            "org.pwmt.zathura-pdf-djvu.desktop"
            "org.pwmt.zathura-pdf-ps.desktop"
            "org.pwmt.zathura-pdf-cb.desktop"
            "sioyek.desktop"
          ];

          # TODO: Move to separate modules
          "image/jpeg" = [ "feh.desktop" ];
          "image/png" = [ "feh.desktop" ];
          "image/gif" = [ "feh.desktop" ];
          "image/svg+xml" = [ "feh.desktop" ];
          "image/webp" = [ "feh.desktop" ];
          "image/tiff" = [ "feh.desktop" ];
          "image/bmp" = [ "feh.desktop" ];
        };
      };

      # Brightness control
      hardware.brillo.enable = true;

      # ssh
      # programs.ssh.startAgent = true;

      # User-settings

      time.timeZone = "Europe/Copenhagen";
      # i18n.defaultLocale = "en_US.UTF-8";
      i18n.defaultLocale = "da_DK.UTF-8";
      i18n.supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "da_DK.UTF-8/UTF-8"
      ];
      i18n.extraLocaleSettings = {
        # LC_ALL = "da_DK.UTF-8";
        # LC_MESSAGES = "en_US.UTF-8";
      };
      console = {
        font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
        useXkbConfig = true; # use xkb.options in tty.
      };

    };
}
