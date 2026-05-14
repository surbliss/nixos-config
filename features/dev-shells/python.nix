{ inputs, ... }:
{

  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      devshells.python = {
        packages = with pkgs; [
          python3
          ty
          ruff
        ];
      };
    };
}
