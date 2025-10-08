{
  config,
  lib,
  pkgs,
  ...
}:
# https://teu5us.github.io/nix-lib.html#attribute-set-functions
let
  cursor = pkgs: pkgs.bibata-cursors;
  theme = "Bibata-Modern-Amber";
  size = 24;
  str_size = toString size;
in
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      # probably not needed on wayland anymore
      services.xserver.displayManager.setupCommands =
        let
          # Path might differ between cursor themes
          cursor_path = "${cursor pkgs}/share/icons/${theme}/cursors/left_ptr";
        in
        ''
          echo 'Xcursor.theme: ${theme}' | ${pkgs.xorg.xrdb}/bin/xrdb -nocpp -merge
          echo 'Xcursor.̛̛size: ${str_size}' | ${pkgs.xorg.xrdb}/bin/xrdb -nocpp -merge
          if [ -e "${cursor_path}" ]; then
            ${pkgs.xorg.xsetroot}/bin/xsetroot -xcf ${cursor_path} ${str_size}
          else 
            echo "Warning: cursor file not found at ${cursor_path}" >&2
          fi
        '';
      environment.systemPackages = [ (cursor pkgs) ];

      # Display manager
      programs.regreet.cursorTheme = {
        package = cursor pkgs;
        name = theme;
      };
    };

}
