{ ... }:
{
  # Battery, see https://nixos.wiki/wiki/Laptop
  powerManagement.enable = true;
  services.upower.enable = true; # Battery info

  services.tlp = {
    enable = true;
    settings = {
      # Optional helps save long term battery health
      # Change the AC-options if performance bad
      # CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      # CPU_ENERGY_PERF_POLICY_ON_AC = "power";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #
      # CPU_MIN_PERF_ON_AC = 0;
      # CPU_MAX_PERF_ON_AC = 20;
      # CPU_MIN_PERF_ON_BAT = 0;
      # CPU_MAX_PERF_ON_BAT = 20;

      # Top one doesn't work for this laptop, but maybe next one
      START_CHARGE_THRESH_BAT0 = 40; # % to start charging
      STOP_CHARGE_THRESH_BAT0 = 80; # % to stop charging
    };
  };

  services.auto-cpufreq.enable = true;

  # Also measures overheating
  # services.thermald.enable = true; # Prevent overheating (primarily on intel CPUs)
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       # schedutil?
  #       govenor = "powersave";
  #       turbo = "never";
  #       enable_thresholds = true;
  #       start_threshold = 40;
  #       stop_threshold = 80;
  #     };
  #     charger = {
  #       govenor = "powersave";
  #       turbo = "never";
  #     };
  #
  #   };

  # };

  # Conflicts with tlp
  services.power-profiles-daemon.enable = false;

  services.logind.lidSwitch = "hibernate";
  services.logind.lidSwitchExternalPower = "lock";
  services.logind.lidSwitchDocked = "ignore";

  # Lock screen?
  services.physlock = {
    enable = true;
    allowAnyUser = true;
    lockMessage = "Thomas Surlykke's Laptop, LOCKED";
    lockOn.suspend = true;
    lockOn.hibernate = true;
  };
  # See https://nixos.wiki/wiki/Power_Management
  # systemd.sleep.extraConfig = ''
  #   AllowSuspendThenHibernate=no
  # '';
}
