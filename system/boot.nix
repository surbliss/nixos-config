{ pkgs, ... }:
{
  # systemd-boot EFI boot loader
  boot.loader.systemd-boot = {
    enable = true;
    # Disable editing kernel command-line before boot - otherwise, can get
    # root access by passing init=bin/sh
    editor = false;
    # Set resultion of console
    consoleMode = "auto";
    # So /boot/ doesn't run out of memory
    configurationLimit = 120;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # See https://wiki.nixos.org/wiki/Plymouth
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
    ];
  };
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  # Hide the OS choice for bootloaders.
  # It's still possible to open the bootloader list by pressing any key
  # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;
}
