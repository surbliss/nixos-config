{ pkgs, ... }:
let
  rofi-custom = pkgs.rofi.override {
    plugins = with pkgs; [

      rofimoji
      rofi-emoji
      rofi-calc
      rofi-file-browser
    ];
  };
  # picom-jonaburg = (import ./pkgs/default.nix) pkgs.picom;
  xmonad-with-contrib = pkgs.haskellPackages.ghcWithPackages (hp: [
    hp.xmonad
    hp.xmonad-contrib
  ]);
in
{
  nixpkgs.overlays = [ (import ../pkgs) ];

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

  custom.packages-installed = [
    ### Outside 'with pkgs;' scope
    rofi-custom
    ### No clue where to put this
    # For customization:
    # catppuccin-sddm-custom
    xmonad-with-contrib
  ]
  ++ (with pkgs; [
    ### Utilities
    # nixpkgs-stable.redshift
    flameshot
    devenv
    rofi-power-menu
    polybarFull
    dunst
    betterlockscreen
    gtk4
    custom.picom-jonaburg # From overlay
    wineWowPackages.full
    # rofi-rbw-x11 # Couldnt write @ , lul
  ]);
}

### Dont need:
# slock
# nix-ld (set in shell-config)
# programs.nix-ld.enable = true;
# ### For DIKU-Canvas to work.
# ### Everything here seems not needed - it worked earlier, but stopped working,
# ### and now the nix-shell has been made to fix it.
# programs.nix-ld.libraries =
#   (with pkgs; [
#     ### See https://github.com/diku-dk/DIKUArcade/blob/master/shell.nix
#     stdenv
#     libGL
#     # stdenv.cc.cc.lib # This includes libstdc++
#     # xorg.libXrandr # X11 randr support
#   ])
#   ++ (with pkgs.xorg; [
#     libX11
#     libXext
#     libXinerama
#     libXi
#     libXrandr
#   ]);
