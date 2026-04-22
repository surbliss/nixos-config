# See https://vic.github.io/dendrix/Dendritic.html for style-guide
# and https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/
# and https://github.com/dliberalesso/nix-config/tree/e78eae677a5545aed7dfeea9167e2f1298d06d9b
{
  description = "Thomas's personal flake for NixOS";

  ### Imports all modules without '_' prefix
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      inputs.import-tree [
        ### Contains
        # A: Setup necessary for dendritic config to function, and common
        #   functionality modules in features/ are allowed to rely on.
        # B: Host-setups, which _relies_ on specific modules in features/ to
        #   function
        ./configuration

        # Self-contained modules, with not inter-dependencies
        ./features
      ]
    );

  inputs = {
    ### The Dentritic stuff
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    ### Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Other inputs
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake"; # Best one
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-steel = {
      url = "github:mattwparas/helix/steel-event-system";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-master = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowc = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}
