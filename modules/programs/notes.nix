{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        sleek-todo
        zettlr
        obsidian
        rmview # Haven't made work yet...
        logseq # Trying unstable version
      ];
    };
}
