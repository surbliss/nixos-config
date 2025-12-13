{ pkgs, ... }:
{
  packages = with pkgs; [ hello ];

  # inputsFrom = with pkgs;[ ];

  env = {
    IS_NIX_SHELL = true;
  };

  shellHook = ''
    echo Hello!
  '';
}
