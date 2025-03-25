{ pkgs, inputs, ... }:
let
  language-tools = builtins.attrValues {
    inherit (pkgs)
      ### LSPs

      ### Grammar
      harper

      ### Lua
      lua-language-server
      stylua

      ### Nix
      nixd
      nixfmt-rfc-style
      # Need lua52Packages.tiktoken_core too, for copilot

      ### C/C++
      clang-tools_19 # clangd + clang-format
      clang

      tree-sitter

      ### F#
      mono
      # pkg-config

      ### Futhark
      jemalloc
      numactl

      ### Latex
      ltex-ls

      ### Bash (remember to enable this)
      bash-language-server

      ### Python
      ruff
      pyright
      ;

    ### Haskell
    inherit (pkgs.haskellPackages)
      fourmolu
      hoogle
      haskell-language-server
      ;

  };
in

{
  ### Manage this with Stow instead, define this in nixos/config.
  ### We can do this in
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  # For nixd lsp.
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.systemPackages = [ pkgs.nvim ] ++ language-tools;
}
