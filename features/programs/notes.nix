{
  flake.modules.homeManager.gui =
    { pkgs, custom-link, ... }:
    {
      ### Zettlekasten cli-tool

      home.packages = with pkgs; [
        zk
        sleek-todo
        zettlr
        obsidian
        rmview # Haven't made work yet...
        logseq
      ];

      xdg.configFile = custom-link "zk";
    };
}
