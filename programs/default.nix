{
  pkgs,
  stablePkgs,
  lib,
  inputs,
  system,
}:
let
  getPackages =
    path:
    import path {
      inherit pkgs;
      inherit stablePkgs;
      inherit inputs;
      inherit system;
    };
  packages = lib.lists.concatMap getPackages [
    ./cli.nix # ## Split up cli
    ./desktop.nix
    ./utilities.nix
  ];
in
{
  ### Install all packages
  environment.systemPackages = packages;

  ### Could do so with following instead (using home-manager):
  # home.packages = packages;
}
