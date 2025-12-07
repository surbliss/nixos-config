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
      environment.systemPackages =
        let
          inherit (pkgs) rPackages rstudioWrapper;
          packages = with rPackages; [
            tinytex
            rmarkdown
            # Other stuff for R Markdown
            magrittr
            stringi
            stringr
          ];
          rstudio-with-packages = rstudioWrapper.override { inherit packages; };
        in
        with pkgs;
        [
          rstudio-with-packages
          # Suggested dependencies from eclaude
          glib
          gtk3
          libglvnd

        ];
    };

  # flake.modules.homeManager.gui =
  #   { pkgs, ... }:
  #   let
  #     inherit (pkgs) rPackages rstudioWrapper;
  #     packages = with rPackages; [
  #       tinytex
  #       rmarkdown
  #       # Other stuff for R Markdown
  #       magrittr
  #       stringi
  #       stringr
  #     ];
  #     rstudio-with-packages = rstudioWrapper.override { inherit packages; };
  #   in
  #   {
  #     home.packages = [ rstudio-with-packages ];
  #   };
}
