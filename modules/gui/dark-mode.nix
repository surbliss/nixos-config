{ ... }:
{
  flake.modules.nixos.gui = {
    environment = {
      sessionVariables.GTK_THEME = "Adwaita:dark";
      variables.GTK_THEME = "Adwaita:dark";
    };
  };
}
