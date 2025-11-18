{
  moduleWithSystem,
  inputs,
  ...
}:

let
  module =
    { self', ... }:
    { pkgs, ... }:
    {
      programs.vim.enable = true;
      programs.neovim = {
        enable = true;
        package = self'.packages.neovim-nightly;
      };

      environment.sessionVariables = {
        EDITOR = "hx";
      };
      # To let lsps get info about nixpkgs
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      environment.systemPackages = with pkgs; [
        self'.packages.helix-steel

        # Lsps and formatters
        harper

        lua-language-server
        stylua

        nixd
        nixfmt-rfc-style

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
    };
in
{
  flake.modules.nixos.cli = moduleWithSystem module;

  perSystem =
    { inputs', ... }:
    {
      packages.neovim-nightly = inputs'.neovim-nightly-overlay.packages.default;
      packages.helix-steel = inputs'.helix-steel.packages.default;
    };
}
