{ moduleWithSystem, ... }:
{
  flake.modules.nixos.gui = {
    hardware.graphics.enable = true;
  };

  flake.modules.homeManager.gui = moduleWithSystem (
    { self', ... }:
    { ... }:
    {
      home.packages = [ self'.packages.rstudio ];
    }
  );

  perSystem =
    { pkgs, ... }:
    {
      packages.rstudio = pkgs.callPackage ./_RPackage.nix {
        extraPackages = with pkgs.rPackages; [
          tinytex
          knitr
          rmarkdown
        ];
      };
    };
}
