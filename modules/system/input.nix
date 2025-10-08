{
  flake.modules.nixos.input = {
    # Keyboard
    services.xserver.xkb = {
      extraLayouts.dk-custom = {
        description = "Danish layout, but æøå swapped with more useful keys";
        languages = [ "dan" ];
        symbolsFile = ./keyboard/dk-custom;
      };
      # NOTE: Do it through kanata instead, otherwise messes up QMK bindings
      # extraLayouts.dk-fixed = {
      #   description = "Small tweaks to danish layout, making it a bit closer to US
      #   layout (but not much)";
      #   languages = [ "dan" ];
      #   symbolsFile = ./keyboard/dk-fixed.xkb;
      # };

      # layout = "dk,dk-custom";
      # variant = "nodeadkeys,";
      layout = "dk,us";
      variant = "nodeadkeys,intl";
      # options = "caps:escape,grp:win_space_toggle,shift:breaks_caps";
      # options = "caps:escape,grp:win_space_toggle,compose:menu,shift:breaks_caps";
      options = "grp:win_space_toggle,compose:menu,shift:breaks_caps";
    };

    users.groups.uinput = { };
    services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';
    # TODO: Make username an argument from flake
    users.users.angryluck.extraGroups = [ "uinput" ];

    # Enables necesarry udev rules
    hardware.keyboard.zsa.enable = true;

    # Special keybindings
    services.kanata = {
      enable = true;
      keyboards.homerow-mods = {
        configFile = ./keyboard/homerow-mods.kbd;
        ### Doesn't work when 'configFile' is set
        # devices = [ ];
      };
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
