{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    let
      # Latex installation, smallest version, with all packages explicitly declared
      tex = pkgs.texliveBasic.withPackages (
        ps: with ps; [
          csquotes
          biber # biblatex legacy at this point
          babel-danish
          tikz-cd
        ]
      );
      other-packages = with pkgs; [
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
