{ ... }:
{

  flake.modules.nixos.gui = {
    programs.thunar.enable = true;
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "Thunar.desktop";
        "application/x-directory" = "Thunar.desktop";
      };
    };
  };

}
