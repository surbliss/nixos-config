# See https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix for inspiration
{
  description = "AngryLuck's personal flake for NixOS + Home Manager";

  inputs = {
    ### Should: Use implicit flake for local packages, but excplicit for flakes
    # part of a git repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Best one
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    helix-steel = {
      url = "github:mattwparas/helix/steel-event-system";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser.url = "github:quantum9innovation/zen-browser-twilight-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    # Flake utils?
    # https://ayats.org/blog/no-flake-utils
    #
    zsh-helix-mode = {
      url = "github:multirious/zsh-helix-mode/main";
      flake = false;
    };

  };
  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    # let
    #   overlays = [
    #     inputs.neovim-nightly-overlay.overlays.default
    #   ];
    # in
    {
      nixosConfigurations = {
        # Split (potentially) this out into multiple configs, e.g.
        # 'angryluck-laptop' and 'angryluck-server', ...
        angryluck = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit system;
            # inherit nixpkgs;
            # inherit nixpkgs;
            # stablePkgs = import nixpkgs-stable {
            #   config = {
            #     allowUnfree = true;
            #     permittedInsecurePackages = [ "electron-27.3.11" ];
            #   };
            #
            #   inherit system;
            # };
          };
          modules = [
            ./configuration.nix
            # { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}

# {
#   nixosConfigurations = let
#     # Common configuration function
#     mkSystem = { system ? "x86_64-linux", hostModule, extraModules ? [] }:
#       let
#         stablePkgs = import nixpkgs-stable {
#           config = {
#             allowUnfree = true;
#             permittedInsecurePackages = [
#               "electron-27.3.11"
#             ];
#           };
#           inherit system;
#         };
#       in nixpkgs.lib.nixosSystem {
#         inherit system;
#         specialArgs = { inherit inputs stablePkgs; };
#         modules = [
#           ./modules/common
#           hostModule
#         ] ++ extraModules;
#       };
#   in {
#     "laptop" = mkSystem {
#       hostModule = ./hosts/laptop;
#       extraModules = [ ./modules/desktop ];
#     };
#
#     "server" = mkSystem {
#       hostModule = ./hosts/server;
#       extraModules = [ ./modules/server ];
#     };
#   };
# }

# vim: set sw=2
