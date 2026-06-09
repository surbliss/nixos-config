# Git/jujutsu
{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      difftastic
      jujutsu
      git # Necessary!
      ### Git pager
      delta
      lazygit
    ];
  };
}
