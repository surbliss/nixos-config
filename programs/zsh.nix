{ pkgs, ... }:
# Shouldn't be in /programs, not a program?
{
  users.defaultUserShell = pkgs.zsh;
  users.users.angryluck.shell = pkgs.zsh;

  # Set later in boot-process than sessionVariables, and doesn't allow '"'.
  # environment.variables = {}

  programs.zsh = {
    enable = true;
    ### Consider moving this to .zshrc...
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # Plugins
    promptInit = ''
      source ${pkgs.zsh-git-prompt}/share/zsh-git-prompt/zshrc.sh
    '';

    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-system-clipboard}/ share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh
      export _ZO_EXCLUDE_DIRS="$HOME/.config"
      eval "$(zoxide init --cmd j zsh)"
    '';
  };

}
