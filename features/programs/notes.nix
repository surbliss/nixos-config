{
  flake.modules.homeManager.gui =
    { pkgs, custom-link, ... }:
    {
      ### Zettlekasten cli-tool

      home.packages = with pkgs; [
        zk
        zettlr
        ### FIX: uses electron version 39, which is marked as insecure
        # logseq
      ];

      xdg.configFile = custom-link "zk";
    };
}
