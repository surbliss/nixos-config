{ ... }:
{
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

  # Conflicts with tlp
  services.power-profiles-daemon.enable = false;
}
