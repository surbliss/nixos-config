{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ wineWow64Packages.waylandFull ];
  };
}
