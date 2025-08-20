{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  users.users.angryluck.shell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
    git # Needed for zinit plugin-manager
    zoxide # Better cd
    eza # Better ls
  ];

  # Needed to git nix-store path infos
  programs.zsh.enable = true;

  # Set later in boot-process than sessionVariables, and doesn't allow '"'.
  # # environment.variables = {}

  # # environment.systemPackages = [ pkgs.pure-prompt ];
  # programs.zsh = {
  #   enable = true;
  #   ### Consider moving this to .zshrc...
  #   autosuggestions = {
  #     enable = true;
  #     # extraConfig = {
  #     #   "ZSH_AUTOSUGGEST_CLEAR_WIDGETS" = ''
  #     #     (
  #     #        zhm_history_prev
  #     #        zhm_history_next
  #     #        zhm_prompt_accept
  #     #        zhm_accept
  #     #        zhm_accept_or_insert_newline
  #     #      )
  #     #   '';

  #     #   "ZSH_AUTOSUGGEST_ACCEPT_WIDGETS" = ''( zhm_move_right )'';

  #     #   "ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS" = ''
  #     #     (
  #     #       zhm_move_next_word_start
  #     #       zhm_move_next_word_end
  #     #     )
  #     #   '';
  #     # };
  #   };
  #   enableCompletion = true;
  #   syntaxHighlighting.enable = true;
  #   # Plugins
  #   # promptInit = ''
  #   #   autoload -U promptinit; promptinit
  #   #   prompt pure
  #   # '';
  #   # source ${pkgs.zsh-git-prompt}/share/zsh-git-prompt/zshrc.sh

  #   # source ${inputs.zsh-helix-mode}/zsh-helix-mode.plugin.zsh
  #   # for autocomplete, see https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/zsh/zsh-autosuggestions.nix
  #   interactiveShellInit = ''
  #     source ${pkgs.spaceship-prompt}/lib/spaceship-prompt/spaceship.zsh
  #     source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  #     source ${pkgs.zsh-system-clipboard}/share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh

  #     export _ZO_EXCLUDE_DIRS="$HOME/.config/*"
  #     eval "$(zoxide init --cmd j zsh)"
  #   '';
  # };

}
