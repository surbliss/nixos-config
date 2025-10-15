{

  flake.modules.nixos.gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        logseq # Trying unstable version
        feh # Images

        # PDF
        zathura
        sioyek

        # Media
        mpv-unwrapped
        vlc

        wezterm
        alacritty

        ### Desktop-applications
        bitwarden-desktop
        isabelle # Also adds jedit
        isabelle-components.isabelle-linter # Wrong place?
        libreoffice-qt # Spreadsheets

        # vscode
        obsidian
        rmview # Haven't made work yet...

        ### Unsure about these
        android-studio
        inkscape
        figma-linux

        discord

        zoom-us

        zotero

        keymapp

        sleek-todo

        zettlr

        zulip

        dorion

        # TODO: Delete
        mangohud
        foot
        kitty # Needed for presenterm
      ];
      ### Not needed
      # networkmanagerapplet # (For logging into eduroam)
    };
}
