# See https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix for inspiration
{
  description = "AngryLuck's personal flake for NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    # let
    #   overlays = [
    #     inputs.neovim-nightly-overlay.overlays.default
    #   ];
    # in
    {
      nixosConfigurations."angryluck" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          stablePkgs = import nixpkgs-stable {
            config.allowUnfree = true;
            inherit system;
          };
        };
        modules = [
          ./configuration.nix
          # { nixpkgs.overlays = overlays; }
        ];
      };
    };
}
# vim: set sw=2
