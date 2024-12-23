# /mnt/etc/nixos/flake.nix
# See https://github.com/nmasur/dotfiles/blob/b282e76be4606d9f2fecc06d2dc8e58d5e3514be/flake.nix for inspiration
{
  description = "AngryLuck's personal flake for NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # home-manager = {
    #   url = "github:nix-community/home-manager/master"; # /master for unstable
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # plugin-isabelle-syn = {
    #   url = "github:Treeniks/isabelle-syn.nvim";
    #   flake = false;
    # };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      # self, 
      nixpkgs,
      nixpkgs-stable,
      # home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      stablePkgs = nixpkgs-stable.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system};
      # pkgs = (
      #   import nixpkgs {
      #     inherit system;
      #     config = {
      #       permittedInsecurePackages = [ "electron_27" ];
      #     };
      #   }
      # );
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations."angryluck" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit stablePkgs;
          inherit pkgs;
        };
        # nixpkgs.config = {
        #   allowUnfree = true;
        #   nixpkgs.config.permittedInsecurePackages = [
        #     "electron-27.3.11"
        #   ];
        # };
        modules = [
          # ./system-configuration/configuration.nix
          ./configuration.nix
          #   home-manager.nixosModules.home-manager
          #   {
          #     nixpkgs.config.permittedInsecurePackages = [
          #       "electron-27.3.11"
          #     ];
          #     # nixpkgs.config.allowUnfree = true;
          #     home-manager.useGlobalPkgs = true; # Use global packages in Home Manager
          #     home-manager.useUserPackages = true; # Allow user-specific packages
          #     home-manager.users.angryluck = import ./home-manager/home.nix; # User Home Manager configuration
          #     home-manager.extraSpecialArgs = {
          #       inherit inputs;
          #       inherit stablePkgs;
          #     };
          #   }
          { nixpkgs.overlays = overlays; }
        ];
      };
      # homeConfigurations = {
      #   angryluck = home-manager.lib.homeManagerConfiguration {
      #     pkgs = import nixpkgs { system = "x86_64-linux"; };
      #     homeDirectory = "/home/angryluck";
      #     username = "angryluck";
      #     configuration = import ./home-manager/home.nix;
      #     extraSpecialArgs = {
      #       inherit inputs;
      #       inherit stablePkgs;
      #     };
      #     modules = [
      #       ./home-manager/home.nix
      #       { nixpkgs.overlays = overlays; }
      #     ];
      #   };
      # };

      # homeConfigurations."angryluck" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = {
      #     inherit inputs;
      #     inherit stablePkgs;
      #   };
      #   modules = [
      #     ./home-manager/home.nix
      #     { nixpkgs.overlays = overlays; }
      #     # { nix.settings.allowInsecure = [ "nixpkgs:electron_27" ]; }
      #     { nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ]; }
      #     { nixpkgs.config.allowUnfree = true; }
      #     { nix.package = pkgs.nix; }
      #   ];
      # };
    };
}
# vim: set sw=2
