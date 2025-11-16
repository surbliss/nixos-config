{
  flake.modules.nixos.cli = {
    programs.yazi = {
      enable = true;
      # TODO: Move out of nixos config
      settings = {
        yazi.opener.open = [
          {
            run = "xdg-open \"$1\"";
            orphan = true; # Allows closing yazi, after opening a file (e.g. pdf)
            desc = "Open";
            for = "linux";
          }
          {
            run = "open \"$@\"";
            desc = "Open";
            for = "macos";
          }
          {
            run = "start \"\" \"%1\"";
            orphan = true;
            desc = "Open";
            for = "windows";
          }
        ];
        keymap.mgr.prepend_keymap = [
          {
            on = "T";
            run = "shell \"$SHELL\"  --confirm --block --orphan";
            desc = "Open shell here";
          }
          {
            on = "a";
            run = "create --dir";
            desc = "Create directory";
          }
        ];
      };
    };
  };
}
