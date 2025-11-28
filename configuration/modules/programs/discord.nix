{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      programs.vesktop.enable = true;
      home.packages = [ pkgs.dorion ];
    };
}
