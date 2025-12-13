# Git/jujutsu
{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Necessary!
        difftastic
        jujutsu
        git
        ### Git pager
        delta
        lazygit
      ];
    };
}
