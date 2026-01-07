{
  flake.modules.nixos.system = {
    # Keyboard
    # NOTE: Does nothing on wayland (or at least on Niri)
    services.xserver.xkb = {
      layout = "dk";
      variant = "nodeadkeys";
      # NOTE: shift:breaks_caps makes both shifts simultaniously enable capslock...
      options = "caps:escape,compose:menu";
    };

    # Enables necesarry udev rules for Voyager keyboard
    hardware.keyboard.zsa.enable = true;

    # Special keybindings
    services.kanata = {
      enable = true;
      keyboards.homerow-mods.configFile = ./keyboard/homerow-mods.kbd;
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

    ### QMK
    # Note: Install the qmk-cli locally in a shell (for easier updating)
    # Enable necesary udev-rules, for sudo-less flashing
    hardware.keyboard.qmk.enable = true;
  };
}
