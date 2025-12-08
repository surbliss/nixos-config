{
  flake.modules.nixos.system = {
    # Keyboard
    services.xserver.xkb = {
      layout = "dk";
      variant = "nodeadkeys";
      options = "caps:escape,compose:menu,shift:breaks_caps";
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

  };
}
