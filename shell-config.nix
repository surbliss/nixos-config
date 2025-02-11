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
  environment.sessionVariables = {
    #   # For jEdit to work!
    _JAVA_AWT_WM_NONREPARENTING = 1;
    DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    DOTNET_ROOT = "${pkgs.dotnet-sdk_7}/share/dotnet";
    #   AOCD_DIR = "$HOME/aocd/";
  };

  environment.shellAliases = {
    ls = "eza --group-directories-first --icons=auto";
    l = "eza -l --total-size --no-permissions -h --git --icons=auto";
    cp = "cp -i"; # Interactive
    df = "df -h";
    free = "free -m";
    bc = "bc -l";
    # hms = "home-manager switch --flake /etc/nixos"; # opt: #angryluck
    # hm = "home-manager --flake /etc/nixos"; # opt: #angryluck
    sudo = "sudo ";
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    polybar-refresh = "pkill polybar; polybar -c ~/.config/home-manager/polybar/config.ini default&; disown";
    # Temporarily needed, delete later
    popcp = "cp mothApp.fsx ../../virtual-box-share/pop-3/src/";
    dotstow = "stow -R -d ~/dotfiles . --dotfiles";
  };

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
