{
  flake.modules.homeManager.cli =
    { pkgs, custom-link, ... }:
    {
      home.packages = with pkgs; [ zellij ];
      xdg.configFile = custom-link "zellij";

    };
}
