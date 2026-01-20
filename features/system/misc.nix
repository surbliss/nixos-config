{
  flake.modules.nixos.system =
    { pkgs, ... }:
    {

      ### Idk bout this
      services.accounts-daemon.enable = true;

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
