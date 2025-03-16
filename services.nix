{
  lib,
  config,
  pkgs,
  ...
}:
{
  services.accounts-daemon.enable = true;
  services.pantheon.apps.enable = false;
  services.displayManager.defaultSession = "none+xmonad";
  services.xserver = {
    enable = true;

    # BUG: Doesn't work...
    # desktopManager.wallpaper.mode = "max";

    # Not strictly needed

    dpi = 120;

    xkb = {
      extraLayouts.dk-custom = {
        description = "Danish layout, but æøå swapped with more usefull keys";
        languages = [ "dan" ];
        symbolsFile = ./symbols/dk-custom;
      };

      layout = "dk-custom,dk";
      options = "caps:escape,grp:win_space_toggle,shift:breaks_caps";
    };

    displayManager.lightdm = {
      enable = true;
      # greeters.pantheon.enable = true;
      #   # background = /home/angryluck/.background-image;
      background = ./.background-image;
      # greeter.package = lib.mkForce pkgs.lightdm-gtk-greeter;
      greeters.pantheon.enable = false;
      greeters.gtk = {
        # enable = lib.mkForce true;
        enable = true;
        #     # extraConfig = ''
        #     #   user-background = false
        #     # '';
      };
    };

    # Doesn't work setting this in home-manager
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # Put just config-file in dot-files, and then having this is requirement
      # for now...
      # enableConfiguredRecompile = true;
      # config = ./xmonad.hs;
    };
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
  };

  # Audio
  security.rtkit.enable = true; # For pipewire (optional)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # Only needed for initial connect of AirPods
    settings.General.ControllerMode = "bredr";
  };
  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # Touchpad
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      naturalScrolling = false;
      disableWhileTyping = true;
    };
    touchpad = {
      accelProfile = "flat";
      accelSpeed = "0";
      naturalScrolling = true;
      disableWhileTyping = true;
      buttonMapping = "1 1 3 4 5 6 7";
    };
  };

  # Battery, see https://nixos.wiki/wiki/Laptop
  powerManagement.enable = true;
  services = {
    upower.enable = true; # Battery info
    # thermald.enable = true; # Prevent overheating (primarily on intel CPUs)
    tlp = {
      enable = true;
      settings = {
        # Optional helps save long term battery health
        # Change the AC-options if performance shit
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 20;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 50; # 50 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
  };

  services.kanata = {
    enable = true;
    keyboards.homerow-mods.configFile = ./homerow-mods.kbd;
  };

  services.autorandr.enable = true;

  services.picom = {
    enable = true;
    package = pkgs.picom-pijulius;
    # inactiveOpacity = 0.95;
    # menuOpacity = 1.0;
    # fadeDelta = 1000;
    backend = "glx";
    settings = {
      corner-radius = 4;
      # corner-radius = 8;
      round-borders = 1;

      rounded-corners-exclude = [
        "class_g = 'Rofi'"
        "class_g = 'flameshot'"
      ];

      # these are required!
      experimental-backends = true;

      transition-length = 301;
      transition-pow-x = 0.3;
      transition-pow-y = 0.3;
      transition-pow-w = 0.3;
      transition-pow-h = 0.3;
      size-transition = true;

      fading = true;
      fade-in-step = 0.05;
      fade-out-step = 0.05;
      fade-exclude = [ "class_g = 'flameshot'" ];

      log-level = "warn";

      # Stupid to put this as nix-table, use standard config instead...
      animations = [
        {
          triggers = [
            "close"
            "hide"
          ];
          opacity = {
            curve = "linear";
            duration = 0.1;
            start = "window-raw-opacity-before";
            end = 0;
          };
          blur-opacity = "opacity";
          shadow-opacity = "opacity";
        }
        {
          triggers = [
            "open"
            "show"
          ];
          opacity = {
            curve = "cubic-bezier(0,1,1,1)";
            duration = 0.3;
            start = 0;
            end = "window-raw-opacity";
          };
          blur-opacity = "opacity";
          shadow-opacity = "opacity";
          offset-x = "(1 - scale-x) / 2 * window-width";
          offset-y = "(1 - scale-y) / 2 * window-height";
          scale-x = {
            curve = "cubic-bezier(0,1.3,1,1)";
            duration = 0.3;
            start = 0.6;
            end = 1;
          };
          scale-y = "scale-x";
          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        }
        {
          triggers = [ "geometry" ];
          scale-x = {
            curve = "cubic-bezier(0,0,0,1.28)";
            duration = 0.22;
            start = "window-width-before / window-width";
            end = 1;
          };
          scale-y = {
            curve = "cubic-bezier(0,0,0,1.28)";
            duration = 0.22;
            start = "window-height-before / window-height";
            end = 1;
          };
          offset-x = {
            curve = "cubic-bezier(0,0,0,1.28)";
            duration = 0.22;
            start = "window-x-before - window-x";
            end = 0;
          };
          offset-y = {
            curve = "cubic-bezier(0,0,0,1.28)";
            duration = 0.22;
            start = "window-y-before - window-y";
            end = 0;
          };

          shadow-scale-x = "scale-x";
          shadow-scale-y = "scale-y";
          shadow-offset-x = "offset-x";
          shadow-offset-y = "offset-y";
        }
      ];

      # backend = "glx";
      # blur = {
      #   method = "gaussian";
      #   size = 10;
      #   deviation = 5.0;
      # };
    };
  };

  services.syncthing = {
    enable = true;
    # openDefaultPorts = true;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        "NerdFontSymbolsOnly"
      ];
      monospace = [ "0xProto" ];
      sansSerif = [ "Lato" ];
      serif = [ "Noto Serif" ];
    };
  };

  # systemd.user.services.polybar = {
  #   Unit = {
  #     Description = "Polybar status bar";
  #     PartOf = [ "tray.target" ];
  #     X-Restart-Triggers = mkIf (configFile != null) "${configFile}";
  #   };
  #
  #   Service = {
  #     Type = "forking";
  #     Environment = "PATH=${cfg.package}/bin:/run/wrappers/bin";
  #     ExecStart =
  #       let
  #         scriptPkg = pkgs.writeShellScriptBin "polybar-start" cfg.script;
  #       in
  #       "${scriptPkg}/bin/polybar-start";
  #     Restart = "on-failure";
  #   };
  #
  #   Install = {
  #     WantedBy = [ "tray.target" ];
  #   };
  # };

}
# vim: set ts=2 sw=2
