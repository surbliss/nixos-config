{
  pkgs,
  ...
}:
{

  users.defaultUserShell = pkgs.zsh;

  # For before login (systemd services)
  # environment.variables = {
  #   ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
  #
  # };
  # For after login

  # Set later in boot-process than sessionVariables, and doesn't allow '"'.
  # environment.variables = {}

  environment.sessionVariables = {
    #   # For jEdit to work!
    _JAVA_AWT_WM_NONREPARENTING = 1;
    DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    LC_MESSAGES = "en_US.UTF8";
    # Do this locally (if you must)
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_7}/share/dotnet";
    #   AOCD_DIR = "$HOME/aocd/";
  };

  # environment.shellAliases = {
  # };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # Plugins
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      eval "$(zoxide init --cmd j zsh)"
    '';
  };

}
