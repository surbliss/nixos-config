{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    let
      # Latex installetion, slightly larger than medium, but smaller than full
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-medium csquotes biblatex;
      };
      other-packages = with pkgs; [
        biber # bibtex legacy at this point

        # Editor-lsps
        ltex-ls-plus # Supposedly more updated
        pstree # for vimtex?

        # Default lsp-s for helix
        texlab
        bibtex-tidy

        ### Fonts:
        ## Helvetica clone
        # tex-gyre-heros-fonts
        texlivePackages.lete-sans-math # Lato-based
        # Latex base-font
        newcomputermodern

      ];
    in
    {
      home.packages = [ tex ] ++ other-packages;

    };
}
