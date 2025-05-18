{ ... }:
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
}
