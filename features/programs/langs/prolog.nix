{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ swi-prolog ];
    };

  ### Gui version, apparently, conflicts with ordinary verison
  # flake.modules.homeManager.gui =
  #   { pkgs, ... }:
  #   {
  #     home.packages = with pkgs; [ swi-prolog-gui ];
  #   };
}
