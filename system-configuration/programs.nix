{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nano # installed by default
    vim
    git
    wget
    curl
    home-manager
    nix-search-cli
    xclip

    # Needed for configuring eduroam (but not otherwise)
    networkmanagerapplet

    stow
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.slock.enable = true;

  programs.zsh.enable = true;
}
