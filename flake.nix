# /mnt/etc/nixos/flake.nix
# See https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix for inspiration
{
  description = "AngryLuck's personal flake for NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master"; # /master for unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugin-isabelle-syn = {
      url = "github:Treeniks/isabelle-syn.nvim";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      # self, 
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      stablePkgs = nixpkgs-stable.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations."angryluck" = nixpkgs.lib.nixosSystem {
        # system = "x86_64-linux";
        specialArgs = {
          inherit system;
          #   inherit inputs;
          #   inherit stablePkgs;
        };
        modules = [
          ./system-configuration/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # Use global packages in Home Manager
            home-manager.useUserPackages = true; # Allow user-specific packages
            home-manager.users.angryluck = import ./home-manager/home.nix; # User Home Manager configuration
          }
          # inputs.home-manager.nixosModules.angryluck
          # home-manager.nixosModules.home-manager
          #
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.angryluck = import ./home-manager/home.nix;
          #   # nixpkgs.overlays = overlays;
          # }
          { nixpkgs.overlays = overlays; }
        ];
      };
      # homeConfigurations."angryluck" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = {
      #     inherit inputs;
      #     inherit stablePkgs;
      #   };
      #   modules = [
      #     ./home-manager/home.nix
      #     { nixpkgs.overlays = overlays; }
      #   ];
      # };
    };
}
# vim: set sw=2
