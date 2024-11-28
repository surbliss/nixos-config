{
  # config,
  pkgs,
  lib,
  # inputs,
  stablePkgs,
  ...
}:
{
  imports = [
    ./nvim
    ./zsh # Note, zsh has to be installed in configuration.nix (for now)
    ./wezterm
    ./polybar
  ];

  # FIX: DELETE THIS!
  home.enableNixpkgsReleaseCheck = false;

  # Let home-manager manage itself, required
  programs.home-manager.enable = true;

  home.username = "angryluck";
  home.homeDirectory = "/home/angryluck";

  # DON'T CHANGE, UNLESS YOU HAVE READ Home Manager RELEASE NOTES!
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  # # Temporary fix for pipewire-issue
  # home.activation.mute-unmute = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
  #   ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
  # '';
  # # ${pkgs.systemd}/bin/systemctl --user restart polybar.service

  home.activation = {
    # NOTE: Only idempotent actions (runs on each home-manager switch)
    myActivationScript =
      lib.hm.dag.entryAfter [ "writeBoundary" ] # sh

        ''
          ${pkgs.systemd}/bin/systemctl --user restart polybar
        '';
  };

  # home.pointerCursor.name = "Vanilla-DMZ";
  # home.pointerCursor.package = pkgs.vanilla-dmz;
  # Allows you to install fonts in home.packages

  home.preferXdgDirectories = true;

  # Window-manager. Could consider putting it in a file called
  # "window-manager", together with polybar...

  xdg.configFile."xmonad/xmonad.hs" = {
    # enable = true;
    # target = "${config.xdg.configHome}/xmonad";
    # target = "xmonad/xmonad.hs";
    source = ./xmonad.hs;
  };

  xsession = {
    enable = true;
    initExtra = ''
      systemctl --user restart polybar
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      # extraPackages = hp: [
      #   hp.dbus
      #   hp.monad-logger
      # ];
      config = ./xmonad.hs;
    };
  };
  # xsession = {
  #   enable = true;
  #   initExtra = # sh
  #     ''
  #       systemctl --user restart polybar
  #     '';
  #   # wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  #   # wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  #   windowManager.xmonad = {
  #     enable = true;
  #     enableContribAndExtras = true;
  #     config = ./xmonad.hs;
  #
  #     # extraPackages = hPkgs: [
  #     #   #   hPkgs.xmobar
  #     #   hPkgs.xmonad
  #     #   hPkgs.xmonad-contrib
  #     #   hPkgs.xmonad-extras
  #     #   # hPkgs.monad-logger
  #     # ];
  #   };
  # };

  # FIX: Slå korrekt notation op! (se VimJoyers video)
  # xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [
        "org.pwmt.zathura.desktop"
        "org.pwmt.zathura-pdf-mupdf.desktop"
        "org.pwmt.zathura-pdf-djvu.desktop"
        "org.pwmt.zathura-pdf-ps.desktop"
        "org.pwmt.zathura-pdf-cb.desktop"
        "zathura.desktop"
        "firefox.desktop"
      ];
    };
  };

  programs.git = {
    enable = true;
    userName = "angryluck";
    # Github email, maybe better to write own email, idk
    userEmail = "54353246+angryluck@users.noreply.github.com";
    aliases = {
      a = "add .";
      cm = "commit -m";
      acm = "!git add . && git commit -m";
      ca = "!git add . && git commit -m 'empty'"; # commit with no msg
      st = "status";
      br = "branch";
      co = "checkout"; # Still not sure what this does...
      qp = "!git add . && git commit -m 'quick-commit' && git push"; # quick-push
      # acp = "!git add . && git commit -m 'empty' && git push";
    };
    extraConfig = {
      # Set push.autoSetupRemote to true
      push.autoSetupRemote = "true";
      init.defaultBranch = "master";
      safe.directory = "/etc/nixos";
    };
  };

  # File browser
  programs.yazi.enable = true;

  programs.rofi = {
    # Can't set file-browser-extended options here, have to modify the command
    # in xmonad!
    enable = true;
    terminal = "${pkgs.wezterm}/bin/wezterm";
    font = "Lato 20";
    # theme = "gruvbox-dark-soft";
    theme = "Arc-Dark";
    # package = pkgs.rofi;
    plugins = with pkgs; [
      rofi-calc
      rofi-file-browser
      # rofimoji
      rofi-emoji
    ];
    extraConfig = {
      display-drun = "Applications";
      modi = [
        "drun"
        "file-browser-extended"
        "calc"
        "emoji"
      ];
      # file-browser-matching = "fuzzy";
      # file-browser-directory = "~/documents";
      # file-browser-depth = 0;
      show-icons = true;
    };
  };

  # Browser
  programs.firefox = {
    enable = true;
    # Have to remove stuff from old install first...
    # profiles.angryluck = {
    #   search.default = "DuckDuckGo";
    # };

    ## LIST OF about:config changes:
    # mousewheel.default.delta.multiplyer_y: 100->50
  };

  programs.thunderbird = {
    enable = true;
    profiles."angryluck" = {
      isDefault = true;
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      synctex = true;
      # database = "sqlite";
    };
  };

  programs.feh = {
    enable = true;

    keybindings = {
      menu_parent = "Left";
      menu_child = "Right";
      menu_down = "Down";
      menu_up = "Up";

      scroll_left = "h";
      scroll_right = "l";
      scroll_up = "k";
      scroll_down = "j";

      scroll_left_page = "C-h";
      scroll_right_page = "C-l";
      scroll_up_page = "C-k";
      scroll_down_page = "C-j";

      toggle_aliasing = "A";
      toggle_filenames = "d";
      toggle_pointer = "o";
      toggle_fullscreen = "f";

      zoom_in = "plus";
      zoom_out = "minus";

      next_img = [
        "greater"
        "C-n"
      ];
      prev_img = [
        "less"
        "C-p"
      ];
      reload_image = "r";
      size_to_image = "w";
      next_dir = "bracketright";
      prev_dir = "bracketleft";
      orient_3 = "parenright";
      orient_1 = "parenleft";
      flip = "underscore";
      mirror = "bar";
      remove = "Delete";
      zoom_fit = "s";
      zoom_default = "a";

      close = [
        "q"
        "Q"
      ];
    };
  };

  # Doesn't work in tandem with the above
  # xdg.configFile.rofi = {
  #   # enable = true;
  #   source = ./rofi;
  # };

  services = {
    syncthing.enable = true;
    picom = {
      enable = true;
      package = pkgs.picom-pijulius;
      inactiveOpacity = 0.95;
      menuOpacity = 1.0;
      fadeDelta = 1000;
      backend = "glx";
      settings = {
        corner-radius = 8; # or whatever
        round-borders = 1;
        # these are required!
        experimental-backends = true;
        # backend = "glx";
        blur = {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
      };
    };
  };

  systemd.user = {
    # Start systemd-services automatically after home-manager switch
    startServices = "sd-switch";

    # See https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
    # services.pipewire-fix = {
    #
    #   Install.WantedBy = [ "graphical-session.target" ];
    #
    #   Unit = {
    #     Description = "Mute and Unmute Audio at Startup";
    #     After = "pipewire.service"; # Wait for pipewire to start
    #     Wants = "pipewire.service"; # Ensure pipewire starts before this service
    #     BindsTo = "graphical-session.target";
    #     PartOf = "graphical-session.target";
    #     Requisite = "graphical-session.target";
    #   };
    #
    #   Service = {
    #     ExecStart = "${pkgs.writeShellScript "pipewire-fix" ''
    #       #!/run/current-system/sw/bin/bash
    #       ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    #       ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    #     ''}";
    #
    #     Type = "oneshot"; # Runs once and exits
    #     RemainAfterExit = true; # Keeps the service active after running
    #   };
    #
    # };
  };

  # services.pipewire-fix = {
  #   Unit = {
  #     After = "pipewire.service";
  #     Description = "Mute and unmute pipewire, should only be necessary until version 1.2.5 is on nixpkgs-unstable";
  #   };
  #   Service = {
  #     ExecStart = "sh wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 &";
  #   };
  # };
  # systemd.user.services.pipewire-fix = {
  #   Unit = {
  #     Description = "Pipewire muted on boot, mute and unmute on boot to fix";
  #   };
  #   Install = {
  #     # graphical-target
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     # Add muting + unmuting twise here
  #     ExecStart = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 &";
  #   };
  # };

  # THIS MIGHT NOT WORK!
  # See https://nixos.wiki/wiki/TexLive
  # programs.texlive = {
  #   enable = true;
  #   # packageSet = pkgs.texlive.combined.scheme-medium;
  #   packageSet = pkgs.texlive.combined {
  #     inherit (pkgs.texlive) scheme-medium; # Choose LaTeX scheme
  #   };
  # };
  # programs.texlive = {
  #   enable = true;
  #   packageSet = pkgs.texlive.combined.scheme-tetex;
  # };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        "NerdFontSymbolsOnly"
      ];
      monospace = [ "0xProto" ];
      sansSerif = [ "Lato" ];
      serif = [ "Noto Serif" ];
    };
  };

  # HACK: Upstream Logseq package was htrowing errors, so had to downgrade
  # electron-version. Make sure to check
  # https://github.com/logseq/logseq/issues/10851, so that when it's fixed you
  # can delete this (electron 27 is marked as insecure).
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     logseq = prev.logseq.override {
  #       electron = prev.electron_27;
  #     };
  #   })
  # ];

  # permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];

  # Unfree packages, to allow
  # nixpkgs.config.allowUnfree = true;
  # config.allowUnfree = true;
  # Didn't work :/
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (pkgs.lib.getName pkgs) [
  #     "discord"
  #   ];

  # All user-packages, systemwide packages should go in configuration.nix
  home.packages = with pkgs; [
    # UNFREE PACKAGES:
    # discord
    # gh-copilot # Not as helpful as I thought...

    # UNFREE END
    gh
    # bitwarden-desktop # FIX: Some build dependency problem, check up on it

    # v1
    stablePkgs.bitwarden-desktop

    # v2
    # inputs.nixpkgs-stable.legacyPackages."x86_64-linux". # Not the best...

    ### FONTS
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
    noto-fonts
    lato
    font-awesome

    (nerdfonts.override {
      fonts = [
        # "0xProto"
        # "Inconsolata"
        # "Hack"
        "NerdFontsSymbolsOnly"
      ];
    })

    ### CLI-tools
    hello
    neofetch
    trash-cli
    fzf
    bc
    htop
    # powertop
    # fd
    cowsay
    haskellPackages.misfortune
    # plocate
    # ripgrep
    zip
    unzip
    # wget
    xcolor
    xorg.xev
    xorg.xkill
    xorg.xprop
    killall
    file
    # Set in configuration.nix insted
    # brillo
    direnv

    ### Applications
    nautilus
    # dolphin

    # Trying stable version
    # Didn't work...
    # stablePkgs.logseq
    logseq
    # Needed for logseq for some reason
    # glibc
    isabelle
    isabelle-components.isabelle-linter

    # virtualbox

    ### Utilities
    redshift
    # syncthing
    flameshot
    # wineWowPackages.stable
    rofi-power-menu

    # Terminal
    # wezterm

    ### Programming languages
    gcc14
    gnumake
    valgrind
    gdb
    rars
    fsharp
    dotnet-sdk

    ### IF YOU INSTALL THIS, THEN HASKELL-LANGUAGE-SERVER DOESN'T WORK!
    ### -> Must be because you then have two different ghc-versions...
    # ghc

    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        # select Python packages here
        # pandas
        # requests
        torch
        torchvision
        numpy
        scikit-learn
        matplotlib
        notebook
        # sklearn-deap
      ]
    ))
    # rust
    # go
    # kotlin

    # DIVERSE
    # mpc-cli
    #FIX: Configure this with 'programs.texlive.enable' instead
    texlive.combined.scheme-full

    # nodejs
    # Fonts:
    # noto-fonts-emoji
    # noto-fonts-extra
    # otf-fira-mono
    # terminus_font
    # ttf-0xproto 1.602-1
    # ttf-0xproto-nerd 3.2.1-2
    # ttf-aptos 1.0-1
    # ttf-caladea 20200113-4
    # ttf-fira-code 6.2-2
    # ttf-fira-mono 2:3.206-4
    # ttf-font-awesome 6.6.0-1
    # ttf-hack 3.003-7
    # ttf-hack-nerd 3.2.1-2
    # ttf-inconsolata 1:3.000-4
    # ttf-inconsolata-nerd 3.2.1-2
    # ttf-nerd-fonts-symbols 3.2.1-1

    # Potential programs, but don't use them right now
    # Emacs (/doom)
    # gtk?
    # i3
    # kitty
    # kupfer
    # qalculate
    # Thunar
    # tmux
    # Virtualbox
    # vlc
    # zoom-us
    # bitwarden
    # pavucontrol
    # brillo
    # chromium
    # dmenu
    # flatpak
    # fswatch
    # gimp
    # iwd (shouldn't be needed)
    # jupyterlab
    # libreoffice-fresh
    # ly?
    # networkmanager (in configuration.nix)
    # nextcloud? (need own server first)
    # obsidian
    # p7zip
    # pamixer
    # pandoc
    # pdftk
    # ranger
    # rofimoji
    # sbctl (secureboot key manager)
    # slock
    # tlp (in configuration.nix)
    # ueberzugpp
    # wirelesstools

    ### From nvim-health-check (so might need to be moved there)
    xdotool
    ripgrep
    # libreoffice-still

    kmonad
    evtest

    pinta # Simple image editor

    unrar-free # Unzip rar-files

    time # time programs

    pdfgrep

    # nix-prefetch # get rev and sha256 of github-projects
    # nurl # get rev and sha256 of github-projects

    futhark
    sshfs

    openconnect
    networkmanager-openconnect

    # til dpp (hendrix server)
    slurm

    # Citations
    zotero

    # test
    # haskellPackages.misfortune
    libreoffice

    lazygit
  ];
}
