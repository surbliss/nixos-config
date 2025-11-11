{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      programs.direnv = {
        enable = true;
        settings.hide_env_diff = true;
      };

      environment.systemPackages = [ pkgs.devenv ];
      # Fix binary cache error
      nix.extraOptions = ''
        extra-substituters = https://devenv.cachix.org
        extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
      '';
    };
}
