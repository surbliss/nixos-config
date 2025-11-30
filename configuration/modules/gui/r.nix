{
  flake.modules.nixos.gui =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          mesa
          soci
        ];
      };
      qt.enable = true;
    };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      inherit (pkgs) rPackages rstudioWrapper;
      packages = with rPackages; [ tinytex ];
      rstudio-with-packages = rstudioWrapper.override { inherit packages; };
    in
    {
      home.packages = [ rstudio-with-packages ];
    };
}
