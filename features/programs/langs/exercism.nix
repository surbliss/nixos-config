# Exercism: Cli-tool for training programming languages
{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ exercism ];
    };
}
