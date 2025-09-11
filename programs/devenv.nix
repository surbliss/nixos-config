{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.devenv = {
    enable = lib.mkEnableOption "devenv developer environments";
  };

  config = lib.mkIf config.custom.devenv.enable {
    environment.systemPackages = [ pkgs.devenv ];
    # Fix binary cache error
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
