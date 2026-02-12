{ moduleWithSystem, inputs, ... }:

{
  flake.modules.nixos.cli = {
    programs.vim.enable = true;
    programs.neovim.enable = true;

    # To let lsps get info about nixpkgs
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  flake.modules.homeManager.cli = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    {
      home.sessionVariables = {
        EDITOR = "hx";
      };
      home.packages = with pkgs; [
        self'.packages.helix

        # Lsps and formatters
        harper

        lua-language-server
        stylua

        nixd
        nixfmt

        haskellPackages.haskell-language-server
        haskellPackages.ormolu

        llvmPackages_20.clang-tools

        ltex-ls-plus # Supposedly more updated

        bash-language-server

        # Python
        ruff
        ty

        pstree # for vimtex?

        # Typst
        tinymist
        typstyle

        # Nim (TODO: Delete this)
        nimlsp
        nph
        nimlangserver

        simple-completion-language-server # completions # TODO: Delete
        # Default lsp-s for helix
        texlab
        bibtex-tidy
        omnisharp-roslyn
        neocmakelsp
        vscode-langservers-extracted
        just-lsp
        marksman
        markdown-oxide
        nil
        systemd-lsp
        taplo
        tombi
        yaml-language-server
        yamlfmt

      ];
    }
  );

  perSystem =
    { inputs', ... }:
    {
      packages.helix = inputs'.helix-master.packages.default;
    };
}
