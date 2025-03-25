{
  lib,
  pkgs,
  inputs,
  stablePkgs,
  ...
}:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      vim
      nvim
      wget
      curl
      nix-search-cli
      xclip
      # hello

      # Only needed for configuring eduroam
      # networkmanagerapplet

      # gh
      # neofetch

      trash-cli
      fzf
      bc
      htpop

      ;
  };
}
