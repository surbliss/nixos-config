{
  config,
  lib,
  pkgs,
}:
# For Backup:
{
  ### PLYMOUTH
  boot = {
    # Maybe load plymouth faster?
    initrd.systemd.enable = true;

    # Pretty boot
    plymouth = {
      enable = true;
      theme = "rings_2";
      # Just adding all the themes I think are good, so it is easy to switch.
      # List of theme-names: https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/themes/adi1090x-plymouth-themes/shas.nix
      # No preview: infinite_seal, ironman, owl, pixels, seals_2, seals_3, tech_a, tech_b
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "colorful_loop"
            "cuts"
            "cuts_alt"
            "deus_ex"
            "ibm"
            "liquid"
            "polaroid"
            "rings_2"
            "spin"
            "square"
          ];
        })
      ];
    };

    # Silent boot
    # See https://wiki.nixos.org/wiki/Plymouth
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  console.font = "Lat2-Terminus16";

  # Pretty background, that changes
  services.fractalart.enable = true;

  # Extra DPI-settings

  environment.variables = {
    GDK_Scale = "2";
    # Controls firefox dpi, but have to reboot
    GDK_DPI_SCALE = "1.2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  # NOT SURE IF NEEDED
  programs.ssh.sshAgent.enable = true;
}
