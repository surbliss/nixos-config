{ config, ... }:
{
  services.xserver = {
    enable = true;

    # BUG: Doesn't work...
    # desktopManager.wallpaper.mode = "max";

    # Not strictly needed
    # displayManager.defaultSession = "none+xmonad";

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
      greeters.gtk = {
        enable = true;
        #     # extraConfig = ''
        #     #   user-background = false
        #     # '';
      };
    };

    # Doesn't work setting this in home-manager
    windowManager.xmonad.enable = true;
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
    thermald.enable = true; # Prevent overheating (primarily on intel CPUs)
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

        START_CHARGE_THRESH_BATT = 50; # 50 and bellow it starts to charge
        STOP_CHARGE_THRESH_BATT = 80; # 80 and above it stops charging
      };
    };
  };

  services.kanata = {
    enable = true;
    keyboards.homerow-mods.configFile = ./homerow-mods.kbd;
  };

}
# vim: set ts=2 sw=2
