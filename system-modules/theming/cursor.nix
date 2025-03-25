{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.custom.cursor;
in
{
  options.custom.cursor = {
    enable = mkEnableOption "cursor theme";
    package = mkOption {
      type = types.package;
      default = pkgs.bibata-cursors;
      description = "The cursor package to use. Remember to set name too.";
    };
    name = mkOption {
      type = types.str;
      description = "Cursor theme name";
    };
  };

  ### In your module, you're using it correctly on line 37 to set a default cursor theme name when using the default package, letting users easily override it if needed.
  # custom.module1.enable = lib.mkDefault false;

  config = mkIf cfg.enable {
    custom.cursor.name = mkIf (cfg.package == pkgs.bibata-cursors) (
      lib.mkDefault "Bibata-Modern-Amber"
    );
    services.displayManager.sddm.settings.Theme.CursorTheme = cfg.name;
    environment.systemPackages = [ cfg.package ];
  };

}
