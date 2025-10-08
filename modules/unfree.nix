# Top level definition of allowed unfree packages.
# Does couple the remaining packages with this, but personally I think that tradeoff
# is worth, for in exchange having control of all unfree packages in one place.

let
  allowed-unfree = [
    "discord"
    "steam"
    "zoom-us"
  ];
in
{
  flake.modules.nixos.unfree =
    { lib, ... }:
    {
      nixpkgs.config.allowUnfreePredicate = p: builtins.elem (lib.getName p) allowed-unfree;
    };
}
