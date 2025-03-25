{ pkgs, ... }:
let
  luaPackaged = pkgs.lua.withPackages (p: [ p.tiktoken_core ]);
  pythonPackaged = pkgs.python3.withPackages (
    p:
    builtins.attrValues {
      inherit (p)
        numpy
        matplotlib
        ipython

        pyparsing
        pytest
        catppuccin
        ;
    }
  );
  programming-languages = builtins.attrValues {
    inherit luaPackaged;
    inherit pythonPackaged;
    inherit (pkgs)
      gcc14
      gnumake
      futhark
      ispc
      ;
  };
  tools = builtins.attrValues {
    inherit (pkgs) valgrind;
  };
in
{
  environment.systemPackages = programming-languages ++ tools;
}
