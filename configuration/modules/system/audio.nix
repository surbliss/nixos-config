{
  flake.modules.nixos.system = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      # Only needed for initial connect of AirPods
      settings.General.ControllerMode = "bredr";
    };
    security.rtkit.enable = true; # For pipewire
    services = {
      blueman.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
