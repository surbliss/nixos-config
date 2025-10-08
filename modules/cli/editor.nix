{ inputs, config, ... }:

{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    let
      custom = config.flake.packages.${pkgs.system};
    in
    {
      programs.vim.enable = true;

      programs.neovim = {
        enable = true;
        package = custom.neovim-nightly;
      };

      environment.sessionVariables = {
        EDITOR = "hx";
      };

      # To let lsps get info about nixpkgs
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      environment.systemPackages = with pkgs; [
        # Helix!
        custom.helix-steel

        # Lsps and formatters
        harper

        lua-language-server
        stylua

        nixd
        nixfmt-rfc-style

        haskellPackages.haskell-language-server
        haskellPackages.ormolu

        clang-tools_19 # clangd + clang-format

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
    };

  perSystem =
    { inputs', ... }:
    {
      packages.neovim-nightly = inputs'.neovim-nightly-overlay.packages.default;
      packages.helix-steel = inputs'.helix-steel.packages.default;
    };
}
