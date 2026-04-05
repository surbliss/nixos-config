{
  flake.modules.nixos.system =
    { pkgs, ... }:
    {
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
      ### QMK
      # Note: Install the qmk-cli locally in a shell (for easier updating)
      # Enables necesary udev-rules, for sudo-less flashing
      hardware.keyboard.qmk.enable = true;

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

      ### Udev-rule to disable laptop-keyboard, when external keyboard plugged in
      systemd =
        let
          grabScript =
            pkgs.writers.writePython3 "laptop-kbd-grab"
              { libraries = [ pkgs.python3Packages.evdev ]; }
              ''
                import evdev
                import signal
                dev = evdev.InputDevice('/dev/input/by-path/platform-i8042-serio-0-event-kbd')
                dev.grab()
                signal.pause()
              '';
        in
        {
          services.laptop-kbd-grab = {
            description = "Grab laptop keyboard to suppress input";

            serviceConfig = {
              Type = "simple";

              ExecStartPre = "${pkgs.systemd}/bin/systemctl stop kanata-homerow-mods";
              ExecStart = grabScript;
              ExecStopPost = "${pkgs.systemd}/bin/systemctl start kanata-homerow-mods";
              Restart = "no";
            };
          };
        };

      services.udev.extraRules =
        let
          ZSA_ID = "3297";
        in
        ''
          ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", ENV{ID_VENDOR_ID}=="${ZSA_ID}", RUN+="${pkgs.systemd}/bin/systemctl start laptop-kbd-grab"
          ACTION=="remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", ENV{ID_VENDOR_ID}=="${ZSA_ID}", RUN+="${pkgs.systemd}/bin/systemctl stop laptop-kbd-grab"
        '';
    };
}
