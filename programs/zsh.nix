{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    git # Needed for zinit plugin-manager
    zoxide # Better cd
    eza # Better ls
    starship
    inputs.starship-jj.packages.${pkgs.system}.default
    oh-my-posh # Todo: Replace starship prompt by oh-my-posh
  ];

  programs.zsh.enable = true;
}
