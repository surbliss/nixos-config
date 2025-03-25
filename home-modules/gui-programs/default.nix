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
      wezterm
      bitwarden-desktop
      firefox
      ;
  };
}
