# System-setup for the server
{
  flake.modules.nixos.home-server =
    { pkgs, config, ... }:
    {
      nix.settings.trusted-users = [ "angryluck" ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelParams = [ "consoleblank=60" ];

      networking.networkmanager.enable = true;
      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ]; # SSH only for now, add more as services enabled

      time.timeZone = "Europe/Copenhagen";
      i18n.defaultLocale = "en_US.UTF-8";
      console.keyMap = "dk";

      users.mutableUsers = false;
      users.users.${config.custom.mainUser} = {
        isNormalUser = true;
        hashedPassword = "$6$l4qRlTctBwRHhqCh$w2OH3O..z0sim7rYhm/1MeUtmiIxA2G2b.K7rtPBjkazlL6VwbbzDD.aek55veKOcS2dGeBHAzlIwwW6BCyPR0";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj"
        ];
      };
      # Some basic tools, ensuring ability to fix stuff
      environment.systemPackages = with pkgs; [
        vim
        neovim
        helix
        git
      ];

      services.openssh.enable = true;
      services.openssh.settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };

      ### Battery saving optimizations
      hardware.bluetooth.enable = false;
      powerManagement = {
        enable = true;
        cpuFreqGovernor = "powersave";
      };
      services.logind.settings = {
        Login.HandleLidSwitchExternalPower = "ignore";
        Login.HandleLidSwitch = "ignore";
      };
      systemd.sleep.settings.Sleep = {
        AllowSuspend = "no";
        AllowHibernation = "no";
        AllowSleep = "no";
      };
      services.tlp.enable = true;

      # Won't work on surface-pro, but maybe on a future server
      services.tlp.settings = {
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
}
