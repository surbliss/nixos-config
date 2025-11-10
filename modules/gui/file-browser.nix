{ ... }:
{

  flake.modules.nixos.gui = {
    programs.thunar.enable = true;
    xdg.mime = {
      enable = true;
      defaultApplications =
        let
          files = [
            # "yazi.desktop"
            "thunar.desktop"
            "org.gnome.Nautilus.desktop"
            "kitty-open.desktop"
          ];
        in
        {
          "inode/directory" = files;
          "application/x-directory" = files;
        };
    };
  };

}
