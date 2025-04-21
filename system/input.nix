{ ... }:
{
  # Keyboard
  services.xserver.xkb = {
    extraLayouts.dk-custom = {
      description = "Danish layout, but æøå swapped with more usefull keys";
      languages = [ "dan" ];
      symbolsFile = ./keyboard/dk-custom;
    };

    layout = "dk-custom,dk";
    options = "caps:escape,grp:win_space_toggle,shift:breaks_caps";
  };

  users.groups.uinput = { };
  services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';
  # TODO: Make username an argument from flake
  users.users.angryluck.extraGroups = [ "uinput" ];

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
}
