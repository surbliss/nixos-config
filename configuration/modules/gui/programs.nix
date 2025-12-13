{

  flake.modules.nixos.gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ### Desktop-applications
        bitwarden-desktop
        isabelle # Also adds jedit
        isabelle-components.isabelle-linter # Wrong place?
        libreoffice-qt # Spreadsheets

        # vscode

        ### Unsure about these
        android-studio
        inkscape
        figma-linux

        zotero

        keymapp

        # dorion

        # TODO: Delete
        mangohud
        pdfpc
      ];
    };
}
