{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
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
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Pretty boot
    plymouth = {
      enable = true;
      theme = "square";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "square" ];
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
    # loader.timeout = 0;
  };

  networking.hostName = "angryluck"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "da_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # font = "ter-124b";
    # keyMap = "dk";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system, and GNOME
  services.xserver.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;
  # services.displayManager.defaultSession = "xfce";
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  # services.displayManager.sddm.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
    extraPackages = hPkgs: [ hPkgs.xmobar ];
    # now it is ~/.config/xmonad/xmonad.hs
  };

  # add user
  users.users.angryluck = {
    isNormalUser = true;
    home = "/home/angryluck";
    description = "Mr. Surlykke's profile";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    # TUTORIAL:
    openssh.authorizedKeys.keys = [
      # Replace with your own public key
      # NEED PRIVATE KEY IN .ssh/ !
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj thomas@surlykke.dk"
    ];
    #    packages = with pkgs; [
    #    	firefox
    # wezterm
    # # _0xproto
    #    ];
    # REMEMBER TO SET PASSWORD WITH "passwd" COMMAND!
  };
  # NOT SURE IF NEEDED
  # programs.ssh.sshAgent.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # Font:
  fonts.packages = with pkgs; [
    _0xproto
    font-awesome
    inconsolata
    hack-font
    noto-fonts-color-emoji
    # noto-fonts-extra
    # otf-fira-mono
    terminus_font
    # ttf-aptos 1.0-1
    caladea
    # ttf-fira-code 6.2-2
    # ttf-fira-mono 2:3.206-4
    # ttf-font-awesome 6.6.0-1
    # ttf-inconsolata 1:3.000-4
    # inconsolata-nerdfont
    # ttf-nerd-fonts-symbols 3.2.1-1
    (nerdfonts.override {
      fonts = [
        "0xProto"
        "Inconsolata"
        "Hack"
      ];
    })
  ];
  # Configure keymap in X11
  services.xserver.xkb.layout = "dk-custom,dk";
  services.xserver.xkb.options = "caps:escape,grp:win_space_toggle,shift:breaks_caps";
  # console.keyMap = "dk";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  # OR
  services.pipewire.enable = false;
  # services.pipewire = {
  # enable = true;
  #   pulse.enable = true;
  # };
  #Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # neovim # Managed by stuff below
    git
    wget
    curl
    home-manager
    nix-search-cli
    xclip
    # rofi
    # rofi-file-browser
    # rofi-power-menu

    # Annoying in VM
  ];

  # environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    #   # viAlias = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  users.users.angryluck.shell = pkgs.zsh;

  # services.xserver.xkb.extraLayouts.dk-modified = {
  #   description = "Danish layout, with slight modifications";
  #   languages = [ "dk" ];
  #   symbolsFile = ./symbols/dk-modified;
  # };
  services.xserver.xkb.extraLayouts.dk-custom = {
    description = "Danish layout, but æøå swapped with more usefull keys";
    languages = [ "dan" ];
    symbolsFile = ./symbols/dk-custom;
  };
  #   configure ={
  #     customRC=''
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
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  ### DOESN'T WORK WITH FLAKES!!! ###
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  # EXTRA, FROM TUTORIAL
  # POTENTIALLY ONLY NEEDED FOR VM
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  # Extra VM stuff:
  virtualisation.virtualbox.guest.enable = true;
}

# vim: set ts=2 sw=2
