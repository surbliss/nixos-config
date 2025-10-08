{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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

        tree # Better file listing

        typst # Better latex?

        watchexec

        todo-txt-cli

        just

        nim

        # helix
        # inputs.helix-steel.packages.${pkgs.system}.default
        # steel

        jujutsu
      ];
    };
}
