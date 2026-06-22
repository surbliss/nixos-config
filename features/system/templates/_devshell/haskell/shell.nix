{ ... }: {
  haskellProjects.default = {
    # For other settings, see https://flake.parts/options/haskell-flake.html

    ## Default tools. Following are included by default:
    # - cabal-install
    # - haskell-language-server
    # - ghcid
    # - hlint
    devShell.tools = hp: { inherit (hp) cabal-gild; };
  };
}
