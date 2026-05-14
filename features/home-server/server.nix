# System-setup for the server
{
  flake.modules.nixos.home-server =
    { pkgs, config, ... }:
    {

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;
      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ]; # SSH only for now, add more as services enabled

      time.timeZone = "Europe/Copenhagen";
      i18n.defaultLocale = "en_US.UTF-8";
      console.keyMap = "dk";

      users.users.${config.custom.mainUser} = {
        isNormalUser = true;
        initialPassword = "1234";
        extraGroups = [ "wheel" ];
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

      powerManagement.cpuFreqGovernor = "powersave";
      services.logind.settings = {
        Login.HandleLidSwitchExternalPower = "ignore";
        Login.handleLidSwitch = "ignore";
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
