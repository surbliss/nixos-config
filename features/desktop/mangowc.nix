{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    # Dank Material Shell
    programs.dms-shell.enable = true;
    programs.dms-shell.systemd.enable = true;

    ### Wire dms to MangoWC
    programs.dms-shell.systemd.target = "mango-session.target";

    systemd.user.targets.mango-session = {
      unitConfig = {
        Description = "MangoWC Session Target";
        Requires = "graphical-session.target";
        After = "graphical-session.target";
      };
      wants = [ "dms" ];

    };

    ### Login greeter
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = builtins.concatStringsSep " " [
            "${pkgs.tuigreet}/bin/tuigreet"
            "--time"
            "--remember"
            "--cmd ${pkgs.mango}/bin/mango"
            "--asterisks"
            # Sample theme from https://github.com/apognu/tuigreet, with input changed from 'red' to 'white'
            "--theme border=magenta;text=cyan;prompt=green;time=white;action=blue;button=yellow;container=black;input=white"
          ];
          user = "greeter";
        };
      };
    };

    ### Global themeing for console, based on terminal theme (minimal-custom)
    console.colors = [
      "1f1f28" # black (terminal bg)
      "C34043" # red
      "98BB6C" # green
      "E6C384" # yellow
      "A3D4D5" # blue
      "B8B4D0" # magenta
      "7E9CD8" # cyan
      "c8c093" # white
      "727169" # bright black
      "e82424" # bright red
      "98bb6c" # bright green
      "e6c384" # bright yellow
      "7fb4ca" # bright blue
      "938aa9" # bright magenta
      "7aa89f" # bright cyan
      "dcd7ba" # bright white
    ];

    ### Mango
    programs.mango.enable = true;
    # Add the default config
    environment.etc."mango".source = "${pkgs.mango}/etc/mango";

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    ### Noctalia
    # Noctalia requires these settings enabled, make sure enabled elsewhere
    # assertions = [
    #   {
    #     assertion =
    #       config.services.power-profiles-daemon.enable || config.services.tuned.enable;
    #     message = "Noctalia: requires either services.power-profiles-daemon.enable or services.tuned.enable";
    #   }
    #   {
    #     assertion = config.networking.networkmanager.enable;
    #     message = "Noctalia: requires networking.networkmanager.enable";
    #   }
    #   {
    #     assertion = config.hardware.bluetooth.enable;
    #     message = "Noctalia: requires hardware.bluetooth.enable";
    #   }
    #   {
    #     assertion = config.services.upower.enable;
    #     message = "Noctalia: requires services.upower.enable";
    #   }
    # ];
  };

  flake.modules.homeManager.desktop = { pkgs, ... }: {

    # TODO: Migrate mango-config back into this module, when stable
    # xdg.configFile.mango = TODO;

    gtk.iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    home.packages = with pkgs; [
      ### Packages that default config uses
      foot
      rofi

      # Other program suggested by `dms doctor`
      fprintd
      # Optional dms-programs suggested here: https://danklinux.com/docs/dankmaterialshell/installation#miracle-wm
      dgop
      dsearch
      matugen
      i2c-tools
      cava
      qt6.qtmultimedia

      ### Suggested packages, see https://mangowc.vercel.app/docs/quick-start/
      wezterm
      swaybg

      wlsunset

      wlogout
      slurp
      wlr-which-key

      ### For starting xwayland
      xwayland-satellite
      xrdb

      brightnessctl

      ### Screenshotting
      grim
      satty

    ];
  };
}
