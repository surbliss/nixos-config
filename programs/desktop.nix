{
  pkgs,
  stablePkgs,
  inputs,
  system,
}:
[
  ### Not from 'pkgs'
  stablePkgs.logseq
  inputs.zen-browser.packages."${system}".twilight
]
++ (with pkgs; [
  ### Lightweight
  feh # Images
  zathura # PDF
  mpv-unwrapped # Simple video player
  wezterm # Idk if terminal is lightweight...

  ### Desktop-applications
  bitwarden-desktop
  isabelle
  ### Wrong place
  isabelle-components.isabelle-linter
  libreoffice-qt # Spreadsheets
  # ungoogled-chromium
  vscode
  vlc # Video-player
  obsidian
  rmview # Haven't made work yet...

  ### Unsure about these
  android-studio
  inkscape
  figma-linux
])
### Not needed
# networkmanagerapplet # (For logging into eduroam)
