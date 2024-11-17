# /mnt/etc/nixos/flake.nix
{
  description = "My first NixOs flake (doesn't work, rip)";

  inputs = {
    # Replace "nixos-24.05" with system.stateVersion from configuration.nix
    # shared.url = "path:/etc/nix-config"; # Shared flake
    # nixpkgs.url
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.follows = "shared/nixpkgs";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      # self,
      nixpkgs,
      ...
    }:
    {
      nixosConfigurations.angryluck = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # inputs.disko.nixosModules.disko
          # {
          #   home-manager.useGlobalPkgs = true;
          #          home-manager.useUserPackages = true;
          #          home-manager.users.angryluck = import ./home.nix;
          #
          #   # Optionally, use home-manager.extraSpecialArgs to pass
          #          # arguments to home.nix
          # }
        ];
      };
    };
}
# vim: set sw=2
