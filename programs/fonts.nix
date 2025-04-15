{ pkgs }:
{
  fonts.enableDefaultPackages = true;
  fonts.packages = builtins.attrValues {
    inherit (pkgs)
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
      ;

    inherit (pkgs.nerd-fonts)
      _0xproto
      symbols-only
      inconsolata
      hack
      ;
  };
}
