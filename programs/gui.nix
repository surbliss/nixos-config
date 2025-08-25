{
  pkgs,
  inputs,
  system,
  ...
}:
{

  # programs.thunderbird.enable = true;
  # Settings for chromium, doesn't install the package
  programs.chromium = {
    enable = true;
    extensions = [
      "epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock orign
    ];
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://www.startpage.com/do/search?query=eurKey";
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gamemode.enable = true;
  custom.packages-installed = [
    ### Not from 'pkgs'
    inputs.zen-browser.packages."${system}".twilight
  ]
  ++ (with pkgs; [
    ### Lightweight
    mangohud
    logseq # Trying unstable version
    feh # Images
    zathura # PDF
    sioyek
    mpv-unwrapped # Simple video player
    wezterm # Idk if terminal is lightweight...
    kitty # Needed for presenterm

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

    ungoogled-chromium

    zoom-us

    zotero

    keymapp

    sleek-todo

    zettlr

    zulip

    qutebrowser
  ]);
  ### Not needed
  # networkmanagerapplet # (For logging into eduroam)
}
