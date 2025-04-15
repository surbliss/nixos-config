{ pkgs }:
let
  rofi-custom = pkgs.rofi.override {
    plugins = with pkgs; [
      rofimoji
      rofi-emoji
      rofi-calc
      rofi-file-browser
    ];
  };
  catppuccin-sddm-custom = pkgs.catppuccin-sddm.override { flavor = "mocha"; };
  ### Belongs in 'modules' (theming)
  # picom-jonaburg = (import ./pkgs/default.nix) pkgs.picom;
  xmonad-with-contrib = pkgs.haskellPackages.ghcWithPackages (hp: [
    hp.xmonad
    hp.xmonad-contrib
  ]);
in
[
  ### Outside 'with pkgs;' scope
  rofi-custom
  ### No clue where to put this
  # For customization:
  catppuccin-sddm-custom
  xmonad-with-contrib
]
++ (with pkgs; [
  ### Utilities
  redshift
  flameshot
  rofi-powermenu
  polybarFull
  dunst
  betterlockscreen
  gtk4
])
