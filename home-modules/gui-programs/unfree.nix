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
      discord
      # zoom-us
      ;
  };
}
