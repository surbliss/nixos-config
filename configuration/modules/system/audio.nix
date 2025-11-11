{
  flake.modules.nixos.system = {
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
  };
}
