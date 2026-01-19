# Top level definition of allowed unfree packages.
# Does couple the remaining packages with this, but personally I think that tradeoff
# is worth, for in exchange having control of all unfree packages in one place.

{
  flake.modules.nixos.unfree =
    { lib, config, ... }:
    let
      cfg = config.allowed-unfree;
      isIn = p: builtins.elem (getName p);
      inherit (lib)
        mkEnableOption
        mkOption
        mkIf
        getName
        types
        ;
    in
    {
      options.allowed-unfree = {
        enable = mkEnableOption "allowed unfree packages";
        packages = mkOption {
          type = lib.types.listOf types.string;
          default = [ ];
          description = "The unfree packages to allow";
        };
      };
      config = mkIf cfg.enable {
        nixpkgs.config.allowedUnfreePredicate = isIn cfg.packages;

      };
    };
}
