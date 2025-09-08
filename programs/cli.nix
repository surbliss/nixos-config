{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    # defaultEditor = true;
    # vimAlias = true;
    # viAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    # Can also set some default options here, but unsure how they conflict with
    # local configuration
  };
  # For nixd lsp-server
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.sessionVariables = {
    EDITOR = "hx";
  };

  programs.yazi = {
    enable = true;
    settings = {
      yazi.opener.open = [
        {
          run = "xdg-open \"$1\"";
          orphan = true; # Allows closing yazi, after opening a file (e.g. pdf)
          desc = "Open";
          for = "linux";
        }
        {
          run = "open \"$@\"";
          desc = "Open";
          for = "macos";
        }
        {
          run = "start \"\" \"%1\"";
          orphan = true;
          desc = "Open";
          for = "windows";
        }
      ];
      keymap.manager.prepend_keymap = [
        {
          on = "T";
          run = "shell \"$SHELL\"  --confirm --block --orphan";
          desc = "Open shell here";
        }
      ];
    };
  };

  programs.direnv = {
    enable = true;
    settings.hide_env_diff = true;
  };
  # environment.etc."direnv/direnv.toml".text = ''
  #   [global]
  #   hide_env_diff = true
  # '';

  ### Terminal tools
  custom.packages-installed = with pkgs; [
    git # Very important

    stow # For dotfiles

    wget # Download stuff
    curl

    vim # Edit files
    ### Needed for neovim
    xclip # Manage clipboard
    xdotool
    ripgrep

    ## LSPs for neovim:

    harper

    lua-language-server
    stylua
    # lua52Packages.tiktoken_core
    # For copilot
    luajitPackages.tiktoken_core
    luajitPackages.jsregexp # For LuaSnip
    luajitPackages.luarocks # For LuaSnip

    ### Replaced by nixd
    # nil
    nixd
    nixfmt-rfc-style

    ### To fix haskell-lsp for xmonad
    # haskellPackages.fourmolu
    haskellPackages.ormolu
    haskellPackages.hoogle
    haskellPackages.haskell-language-server

    # ccls
    clang-tools_19 # clangd + clang-format
    clang

    ltex-ls-plus # Supposedly more updated
    bash-language-server

    zoxide
    eza
    # nix-search-cli # Search nixpkgs

    # neofetch
    trash-cli
    fzf
    bc
    htop

    # cowsay

    zip
    unzip

    ### Not needed (should just be run with 'nix run' instead)
    # xcolor
    # killall
    # file

    xorg.xev
    xorg.xkill
    xorg.xprop

    texlive.combined.scheme-full

    time # time programs

    ### Programming languages and tools
    # C + RISC-V
    gcc14
    gnumake
    valgrind
    rars
    # jdk

    ### Nix helpers
    nix-prefetch
    nix-prefetch-git
    nix-prefetch-github

    mermaid-cli

    # Instead of cat
    bat

    # Get wifi-name (iwgetid -r)
    wirelesstools

    rbw
    pinentry-curses

    lazygit

    evtest

    fd # find files

    tree-sitter

    pstree # for vimtex

    tree # Better file listing

    typst # Better latex?
    tinymist
    typstyle

    watchexec

    todo-txt-cli

    just

    # helix
    # inputs.helix-steel.packages.${pkgs.system}.default
    # steel
    inputs.helix-master.packages.${pkgs.system}.default

    simple-completion-language-server # completions
    # Default lsp-s for helix
    # TODO Make a separate nixos-module
    texlab
    bibtex-tidy
    omnisharp-roslyn
    neocmakelsp
    # vscode-css-languageserver
    vscode-langservers-extracted
    just-lsp
    marksman
    markdown-oxide
    nil
    systemd-lsp
    taplo
    tombi
    yaml-language-server
    jujutsu
  ];
}

# Might be useful later
### Citations
# zotero

### Don't think these are needed anymore
# SDL2
# SDL2_ttf
# SDL2_image
# SDL2_net
# SDL2_Pango
# SDL2_gfx
# SDL2_mixer
# SDL2_sound
# gtk3
