{ pkgs, ... }:
{

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        # "NerdFontSymbolsOnly"
        "Symbols Nerd Font"
        # "Symbols Nerd Font Mono"
      ];
      monospace = [
        # "0xProto Nerd Font Mono"
        "0xProto Nerd Font"
        "Font Awesome 7 Free Solid"
      ];
      sansSerif = [ "Lato" ];
      serif = [ "Noto Serif" ];
    };
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    ### Errors when defined as nerd-fonts below, but only one is probably
    # needed...
    # _0xproto
    # inconsolata
    font-awesome
    hack-font
    noto-fonts-color-emoji
    # noto-fonts-extra
    # otf-fira-mono
    terminus_font
    # ttf-aptos 1.0-1
    caladea
    noto-fonts
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

    # Su style:
  ];
}
