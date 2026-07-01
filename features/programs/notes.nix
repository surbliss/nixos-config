{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    ### Zettlekasten cli-tool

    home.packages = with pkgs; [
      zk
      zettlr
      trilium-desktop
      zotero
      jabref
      ### FIX: uses electron version 39, which is marked as insecure
      # logseq
    ];

    # TODO: Move zk config into this module when stable
    # xdg.configFile.zk = TODO;
  };
}
