{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      stow # For dotfiles

      wget # Download stuff
      curl

      vim # Edit files
      ### Needed for neovim
      xclip # Manage clipboard
      xdotool
      ripgrep

      ## LSPs for neovim:

      # lua52Packages.tiktoken_core
      # For copilot
      luajitPackages.tiktoken_core
      luajitPackages.jsregexp # For LuaSnip
      luajitPackages.luarocks # For LuaSnip

      ### Replaced by nixd
      # nil

      ### To fix haskell-lsp for xmonad
      # haskellPackages.fourmolu
      haskellPackages.hoogle
      ghcid

      # ccls
      clang

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

      xev
      xkill
      xprop

      time # time programs

      ### Programming languages and tools
      # C + RISC-V
      # gcc14
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

      evtest

      fd # find files

      tree-sitter

      tree # Better file listing

      typst # Better latex?

      watchexec

      todo-txt-cli

      just

      nim

      wl-color-picker

    ];
  };

  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [
      ### Desktop-applications
      # FIX: Disabel for now, as electron 39 is marked as insecure
      # bitwarden-desktop

      # isabelle # Also adds jedit
      # isabelle-components.isabelle-linter # Wrong place?
      # libreoffice-still # Spreadsheets

      # vscode

      ### Unsure about these
      android-studio

      zotero

      # For Voyager keyboard
      keymapp
    ];
  };
}
