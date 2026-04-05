# Claude code
{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ claude-code ];
    };
}
