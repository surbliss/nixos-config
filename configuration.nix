{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    # ./disko-config.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot = {
    # systemd-boot EFI boot loader
    loader.systemd-boot = {
      enable = true;
      # Disable editing kernel command-line before boot - otherwise, can get
      # root access by passing init=bin/sh
      editor = false;
      # Set resultion of console
      consoleMode = "1";
      # So /boot/ doesn't run out of memory
      configurationLimit = 120;
    };

    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "angryluck"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "da_DK.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Make uinput group
  users.groups.uinput = { };

  # Give uinput group necessary permissions
  services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';

  # add user
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
    ];
    # Maybe in home-manager instead?
    openssh.authorizedKeys.keys = [
      # Replace with your own public key
      # NEED PRIVATE KEY IN .ssh/ (And need to chmod 600 it)!
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj" # Can, optionally, add email after public ssh-key
    ];
  };

  # Brightness control
  hardware.brillo.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search <package>
  environment.systemPackages = with pkgs; [
    # nano # installed by default
    vim
    git
    wget
    curl
    home-manager
    nix-search-cli
    xclip

    # Needed for configuring eduroam (but not otherwise)
    networkmanagerapplet
  ];

  # For jEdit to work!
  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      # viAlias = true;
      vimAlias = true;
      # configure = {
      #   customRC = ''
      #     set tabstop=2
      #     set softtabstop=4
      #     set shiftwidth=2
      #     set expandtab
      #     set number
      #     set relativenumber
      #     set clipboard+=unnamedplus
      #     set list
      #     set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
      #   '';
      # };
    };
  };
  programs.slock.enable = true;
  programs.zsh.enable = true;
  users.users.angryluck.shell = pkgs.zsh;

  # Don't change, doesn't affect the version of packages installed.
  # IF you relly want to change, first read `man configuration.nix` and 
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "24.05"; # Did you read the comment?
}
# vim: set ts=2 sw=2:
