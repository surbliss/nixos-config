let
  # Same config between nixos and homemanager
  fontconfig = {
    enable = true;
    # Lets you just set e.g. "monospace" as font in other configs
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        # "NerdFontSymbolsOnly"
        "Symbols Nerd Font"
        # "Symbols Nerd Font Mono"
      ];
      monospace = [
        "0xProto"
        "Font Awesome 7 Free Solid"
        "Font Awesome 7 Free"
        "Font Awesome 7 Brands"
        "0xProto Nerd Font"

      ];
      sansSerif = [
        "Lato"
        "Font Awesome 7 Free Solid"
        "Font Awesome 7 Free"
        "Font Awesome 7 Brands"
        "0xProto Nerd Font"

      ];
      serif = [
        "Noto Serif"
        "Font Awesome 7 Free Solid"
        "Font Awesome 7 Free"
        "Font Awesome 7 Brands"
        "0xProto Nerd Font"

      ];
    };
  };
in

{

  flake.modules.homeManager.fonts = {
    fonts = { inherit fontconfig; };
  };

  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = { inherit fontconfig; };

      fonts.enableDefaultPackages = true;
      fonts.packages = with pkgs; [
        ### Errors when defined as nerd-fonts below, but only one is probably
        # needed...
        # _0xproto
        # inconsolata
        font-awesome
        hack-font

        noto-fonts-color-emoji
        noto-fonts

        # noto-fonts-extra
        # otf-fira-mono
        terminus_font
        # ttf-aptos 1.0-1
        caladea
        fira-sans
        julia-mono
        # Aptos clone
        inter

        # Helvetica clones
        # tex-gyre-heros-fonts
        gyre-fonts
        # urw-base35-fonts # Includes Nimbus Sans
        aileron

        lato
        poppins

        # Need nermal versions too
        _0xproto
        inconsolata
        hack-font

        nerd-fonts._0xproto
        nerd-fonts.symbols-only
        nerd-fonts.inconsolata
        nerd-fonts.hack
        nerd-fonts.dejavu-sans-mono

        # Fonts for polylux slides (metropolus)
        fira
        fira-math
        nerd-fonts.fira-code
        fira-sans
        texlivePackages.lete-sans-math # Lato-based
        # Latex base-font
        newcomputermodern
      ];
    };
}
