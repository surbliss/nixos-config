{ inputs, ... }:

{
  flake.modules.nixos.cli = { pkgs, ... }: {
    programs.vim.enable = true;
    programs.neovim.enable = true;
    environment.systemPackages = [
      pkgs.steelix

    ];

    # To let lsps get info about nixpkgs
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    environment.sessionVariables.EDITOR = "hx";
  };

  flake.modules.homeManager.cli = { pkgs, ... }: {
    ## NOTE: sessionVariables doesn't work with nushell, see https://github.com/nix-community/home-manager/issues/4313
    # home.sessionVariables = {
    #   EDITOR = "hx";
    # };
    home.packages = with pkgs; [
      pkgs.steelix

      # Lsps and formatters
      harper

      lua-language-server
      stylua

      nixd
      nixfmt

      haskellPackages.haskell-language-server
      haskellPackages.ormolu

      llvmPackages_20.clang-tools

      bash-language-server

      # Python
      ruff
      ty

      # Typst
      tinymist
      typstyle

      # Nim (TODO: Delete this)
      nimlsp
      nph
      nimlangserver

      simple-completion-language-server # completions # TODO: Delete
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
}
