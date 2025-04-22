{
  pkgs,
  stablePkgs,
  inputs,
  system,
  ...
}:
{

  programs.thunderbird.enable = true;

  custom.packages-installed =
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
      # hunspell
      # hunspellDicts.da_DK
      # hunspellDicts.en_US
      # hunspellDicts.en_GB-large
      # ungoogled-chromium
      vscode
      vlc # Video-player
      obsidian
      rmview # Haven't made work yet...

      ### Unsure about these
      android-studio
      inkscape
      figma-linux

      discord
    ]);
  ### Not needed
  # networkmanagerapplet # (For logging into eduroam)
}
