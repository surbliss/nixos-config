{
  description = "Home Manager configuration of angryluck";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # shared.url = "path:/etc/nix-config";
    # nixpkgs.follows = "shared/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master"; # /master for unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugin-isabelle-syn.url = "github:Treeniks/isabelle-syn.nvim";
    plugin-isabelle-syn.flake = false;
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
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
      homeConfigurations."angryluck" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # extraSpecialArgs = {
        #   inherit stablePkgs;
        # };

        extraSpecialArgs = {
          inherit inputs;
          inherit stablePkgs;
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home.nix
          {nixpkgs.overlays = overlays;}
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
