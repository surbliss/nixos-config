{ moduleWithSystem, ... }:

let
  hmodule =
    { self', ... }:
    { pkgs, ... }:
    {
      home.packages = [
        self'.packages.rstudio
        pkgs.mesa
      ];
      qt.enable = true;

    };
in
{
  flake.modules.nixos.gui =
    { pkgs, ... }:
    {
      hardware.graphics.enable = true;
      environment.systemPackages = with pkgs; [
        soci
        mesa
      ];
      qt.enable = true;
    };

  flake.modules.homeManager.gui = moduleWithSystem hmodule;

  perSystem =
    { inputs', ... }:
    {
      # As of 24/11-25, unstable version of rstudio is broken
      packages.rstudio = inputs'.nixpkgs-stable.legacyPackages.rstudioWrapper;
    };
}
