{

  flake.modules.nixos.system = {
    powerManagement.enable = true;
    services.upower.enable = true;

    services.tlp.enable = false; # or remove entirely
    services.power-profiles-daemon.enable = true;

    services.asusd.enable = true; # ASUS-specific: charge thresholds, fan curves, etc.

    # FIX: Find a way to fix this later, so we can suspend/hibernate
    # See https://nixos.wiki/wiki/Power_Management
    services.logind.settings.Login.HandleLidSwitch = "ignore";
    services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
    services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  };
}
