{
  config,
  lib,
  pkgs,
  ...
}:
# https://teu5us.github.io/nix-lib.html#attribute-set-functions
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    mkPackageOption
    types
    ;
  cfg = config.custom.cursor;
in
{

  #   mkOption {
  #   type = types.package;
  #   default = pkgs.bibata-cursors;
  #   description = "The cursor package to use. Remember to set name too.";
  # };

  options.custom.cursor = {
    enable = mkEnableOption "cursor theme";
    package = mkPackageOption pkgs "bibata-cursors" { };
    theme = mkOption {
      type = types.str;
      default = "Bibata-Modern-Amber";
      description = "Cursor theme name";
    };
    size = mkOption {
      type = types.int;
      default = 24;
      description = "Cursor size";
    };
  };

  config = mkIf cfg.enable {
    # Consider setting this in separate display-manager module...
    services.displayManager.sddm.settings.Theme.CursorTheme = cfg.theme;
    # Top two lines here might not be necessary
    services.xserver.displayManager.setupCommands =
      let
        # Path might differ between cursor themes
        cursorPath = "${cfg.package}/share/icons/${cfg.theme}/cursors/left_ptr";
        size = toString cfg.size;
      in
      ''
        echo 'Xcursor.theme: ${cfg.theme}' | ${pkgs.xorg.xrdb}/bin/xrdb -nocpp -merge
        echo 'Xcursor.size: ${size}' | ${pkgs.xorg.xrdb}/bin/xrdb -nocpp -merge
        if [ -e "${cursorPath}" ]; then
          ${pkgs.xorg.xsetroot}/bin/xsetroot -xcf ${cursorPath} ${size}
        else 
          echo "Warning: cursor file not found at ${cursorPath}" >&2
        fi
      '';
    environment.systemPackages = [ cfg.package ];
  };

}
