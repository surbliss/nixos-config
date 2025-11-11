{ config, ... }:
{
  # TODO: This should just be moved into _xmonad.nix, and not imported
  # TODO: Also, this way of adding packages doesnt work
  flake.modules.nixos.cli =
    { pkgs, ... }:
    let
      custom = config.flake.packages.${pkgs.system};
    in
    {
      systemd.user.services.picom-jonaburg = {
        description = "Picom X11 compositor (jonaburg fork)";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session-pre.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.custom.picom-jonaburg}/bin/picom --experimental-backends";
          Restart = "always";
          RestartSec = 3;
          Environment = "DISPLAY=:0"; # On all screens
        };
      };

      environment.systemPackages = with pkgs; [
        custom.rofi-custom
        flameshot
        rofi-power-menu
        polybarFull
        dunst
        betterlockscreen
        gtk4
        custom.picom-jonaburg
        wineWowPackages.full
        (haskellPackages.ghcWithPackages (hp: [
          hp.xmonad
          hp.xmonad-contrib
        ]))
      ];
    };
  perSystem =
    { pkgs, ... }:
    {

      packages.rofi-custom = pkgs.rofi.override {
        plugins = with pkgs; [

          rofimoji
          rofi-emoji
          rofi-calc
          rofi-file-browser
        ];
      };
      packages.picom-jonaburg = pkgs.callPackage ./_picom-jonaburd.nix;
      # picom-jonaburg = (import ./pkgs/default.nix) pkgs.picom;

    };
}
