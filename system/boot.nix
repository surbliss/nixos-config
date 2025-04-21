{ ... }:
{
  boot = {
    # systemd-boot EFI boot loader
    loader.systemd-boot = {
      enable = true;
      # Disable editing kernel command-line before boot - otherwise, can get
      # root access by passing init=bin/sh
      editor = false;
      # Set resultion of console
      consoleMode = "auto";
      # So /boot/ doesn't run out of memory
      configurationLimit = 120;
    };

    loader.efi.canTouchEfiVariables = true;
  };
}
