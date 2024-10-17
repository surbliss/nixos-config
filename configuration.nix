{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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

  # TODO: Put all 'xserver' configs together
  services = {
    displayManager.defaultSession = "none+xmonad";
    xserver = {
      enable = true;

      desktopManager.wallpaper.mode = "fill";

      dpi = 120;

      xkb = {
        extraLayouts.dk-custom = {
          description = "Danish layout, but æøå swapped with more usefull keys";
          languages = ["dan"];
          symbolsFile = ./symbols/dk-custom;
        };

        layout = "dk-custom,dk";
        options = "caps:escape,grp:win_space_toggle,shift:breaks_caps";
      };

      displayManager.lightdm = {
        enable = true;
        background = /home/angryluck/.background-image;
        greeters.gtk = {
          enable = true;
          extraConfig = ''
            user-background = false
          '';
        };
      };

      windowManager.xmonad.enable = true;

      # desktopManager = {
      #   xterm.enable = false;
      #   xfce.enable = true;
      # };

      # windowManager.xmonad = {
      #   enable = true;
      #   enableContribAndExtras = true;
      #   config = ./xmonad.hs;
      #   extraPackages =
      #     hpkgs: with hpkgs; [
      #       xmonad
      #       xmonad-contrib
      #       xmonad-extras
      #       xmobar
      #     ];
      # };
    };

    blueman.enable = true;

    # Replaced with pulseaudio, but consider reenabling if you have
    # bluetooth-problems
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = false; # disable password login
      };
      openFirewall = true;
    };

    upower.enable = true;

    # Touchpad config:
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
        naturalScrolling = false;
        disableWhileTyping = true;
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "0";
        naturalScrolling = true;
        disableWhileTyping = true;
        buttonMapping = "1 1 3 4 5 6 7";
      };
    };
  };

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
    ];
    # Maybe in home-manager instead?
    openssh.authorizedKeys.keys = [
      # Replace with your own public key
      # NEED PRIVATE KEY IN .ssh/ (And need to chmod 600 it)!
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj" # Can, optionally, add email after public ssh-key
    ];
  };

  # Configure keymap in X11
  # console.keyMap = "dk";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # For pipewire (optional, but recommended apparently)
  security.rtkit.enable = true;

  # Enable sound.
  # Replacement for pipewire, until I can figure out how to fix
  # muted untill muting and unmuting on boot...
  # hardware.pulseaudio.enable = true;

  hardware.brillo.enable = true;
  # OR
  # rtkit is optional but recommended
  # services.pipewire = {
  # enable = true;
  #   pulse.enable = true;
  # };
  #Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # Only needed for initial connect of AirPods
  hardware.bluetooth.settings.General.ControllerMode = "bredr";

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

    # Needed for xmonad-script
    # nvm, didn't work
    # killall

    #ONLY NEEDED FOR **CONFIGURING** EDUROAM!
    networkmanagerapplet
    # rofi
    # rofi-file-browser
    # rofi-power-menu

    # Annoying in VM
    xmobar
  ];

  # environment.variables.EDITOR = "nvim";

  # For jEdit to work!
  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # viAlias = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  users.users.angryluck.shell = pkgs.zsh;

  programs.slock.enable = true;

  # services.xserver.xkb.extraLayouts.dk-modified = {
  #   description = "Danish layout, with slight modifications";
  #   languages = [ "dk" ];
  #   symbolsFile = ./symbols/dk-modified;
  # };
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
  #boot.loader.grub.device = "/dev/sda";
  #boot.initrd.checkJournalingFS = false;

  # Extra VM stuff:
  # virtualisation.virtualbox.guest.enable = true;
  # Battery: See https://nixos.wiki/wiki/Laptop
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # Optional helps save long term battery health
      # Change the AC-options if performance shit
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 20;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = 70; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 75; # 80 and above it stops charging
    };
  };
}
# vim: set ts=2 sw=2

