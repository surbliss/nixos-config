# See https://vic.github.io/dendrix/Dendritic.html for style-guide
# and https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/
# and https://github.com/dliberalesso/nix-config/tree/e78eae677a5545aed7dfeea9167e2f1298d06d9b
{
  description = "Thomas's personal flake for NixOS";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);

  # Consider:
  # _module.args.rootPath =./.;
  inputs = {
    ### The Dentritic stuff
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    ## Maybe later
    # flake-file.url = "github:vic/flake-file";
    # systems.url = "github:nix-systems/default";

    ### Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

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
    # helix-master = {
    #   url = "github:helix-editor/helix/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # starship-jj = {
    #   url = "gitlab:lanastara_foss/starship-jj/main";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # zsh-helix-mode = {
    #   url = "github:multirious/zsh-helix-mode/main";
    #   flake = false;
    # };

  };

  # inputs:
  # inputs.flake-parts.lib.mkFlake {
  #   inherit inputs;
  # } (inputs.import-tree ./modules);

  # outputs =
  #   {
  #     nixpkgs,
  #     ...
  #   }@inputs:
  #   {
  #     nixosConfigurations = {
  #       angryluck = nixpkgs.lib.nixosSystem rec {
  #         system = "x86_64-linux";
  #         specialArgs = {
  #           inherit inputs;
  #           inherit system;
  #         };
  #         modules = [
  #           ./configuration.nix
  #         ];
  #       };
  #     };
  #   };
}
