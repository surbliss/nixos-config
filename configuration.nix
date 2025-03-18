{
  config,
  lib,
  pkgs,
  inputs,
  stablePkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./programs.nix
    ./shell-config.nix
    # ./disko-config.nix
  ];

  # FIX:
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
    "dotnet-sdk-7.0.410" # Remove when SU is done!
  ];

  # TODO: Make per package
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # https://nixos.wiki/wiki/Automatic_system_upgrades
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

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

  networking.hostName = "angryluck"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "da_DK.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "da_DK.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    # LC_ALL = "da_DK.UTF-8";
    # LC_MESSAGES = "en_US.UTF-8";
  };
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Doesn't do anything
  # hardware.video.hidpi.enable = true;

  # # Make uinput group for kanata, see https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux
  users.groups.uinput = { };
  services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';
  #
  # add user
  users.users.milla = {
    isNormalUser = true;
    home = "/home/milla";
    description = "Til Milla - uden alt muligt mystisk ;)";
    extraGroups = [
      "wheel" # Let's you do sudo things
      "networkmanager"
      "video"
      "audio"
      # "input"
    ];
    initialPassword = "";

  };

  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.pantheon.enable = true;
  # services.xserver.displayManager.lightdm.greeters.gtk.enable = false;
  # Conflicts with tlp
  services.power-profiles-daemon.enable = false;
  # services.xserver.displayManager.sessionData.loginArgs = {
  #   milla = "--session gnome";
  #   angryluck = "--session xmonad";
  # };

  # Custom cursor
  programs.dconf.enable = true;
  # services.xserver.displayManager.sessionCommands = ''
  #   ${pkgs.xorg.xsetroot}/bin/xsetroot -xcf ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/cursors/left_ptr 24
  # '';

  environment.etc."X11/Xresources".text = ''
    Xcursor.theme: Bibata-Modern-Ice
    Xcursor.size: 24
  '';

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=24
  '';

  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=24
  '';

  environment.etc."icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Bibata-Modern-Ice
  '';

  users.users.angryluck = {
    isNormalUser = true;
    home = "/home/angryluck";
    description = "Mr. Surlykke's profile";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "uinput"
      # "nixos-editor" # Allowed to edit /etc/nixos/ without sudo
      # "vboxusers"
    ];
    # Maybe in home-manager instead?
    openssh.authorizedKeys.keys = [
      # Replace with your own public key
      # NEED PRIVATE KEY IN .ssh/ (And need to chmod 600 it)!
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj" # Can, optionally, add email after public ssh-key
    ];
    useDefaultShell = true;

    # User-specific packages
    packages = with pkgs; [
      passh
    ];
  };

  programs.ssh.startAgent = true;

  # Brightness control
  hardware.brillo.enable = true;

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "zen-browser.desktop" ];
      "x-scheme-handler/http" = [ "zen_twilight.desktop" ];
      "x-scheme-handler/https" = [ "zen_twilight.desktop" ];
      "x-scheme-handler/about" = [ "zen_twilight.desktop" ];
      "x-scheme-handler/unknown" = [ "zen_twilight.desktop" ];

      "application/pdf" = [
        "org.pwmt.zathura.desktop"
        "org.pwmt.zathura-pdf-mupdf.desktop"
        "org.pwmt.zathura-pdf-djvu.desktop"
        "org.pwmt.zathura-pdf-ps.desktop"
        "org.pwmt.zathura-pdf-cb.desktop"
        "zathura.desktop"
        "zen_twilight.desktop"
        "zen.desktop"
        "firefox.desktop"
      ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/svg+xml" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];

    };
  };

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "angryluck" ];
  # Don't change, doesn't affect the version of packages installed.
  # IF you relly want to change, first read `man configuration.nix` and
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "24.05"; # Did you read the comment?
}

# vim: set ts=2 sw=2:
