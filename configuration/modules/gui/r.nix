# { moduleWithSystem, ... }:

# let
#   hmodule =
#     { self', ... }:
#     { pkgs, ... }:
#     {
#       home.packages = [
#         self'.packages.rstudio
#         pkgs.mesa
#         pkgs.libGL
#       ];
#       qt.enable = true;

#     };
# in
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
      environment.systemPackages =
        with pkgs;
        let
          rstudio-fixed = rstudio.overrideAttrs (old: {
            postInstall =
              builtins.replaceStrings
                [ "--set-default ELECTRON_FORCE_IS_PACKAGED 1" ]
                [
                  "--set-default ELECTRON_FORCE_IS_PACKAGED 1 --add-flags \"--use-gl=angle --use-angle=vulkan --in-process-gpu\""
                ]
                old.postInstall;
          });
        in
        [
          rstudioWrapper
          soci
          mesa
          which
        ];
      qt.enable = true;
    };

  # flake.modules.homeManager.gui = moduleWithSystem hmodule;

  perSystem =
    { inputs', ... }:
    {
      # As of 24/11-25, unstable version of rstudio is broken
      packages.rstudio = inputs'.nixpkgs-stable.legacyPackages.rstudioWrapper;
    };
}
