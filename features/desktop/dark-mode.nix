{
  flake.modules.nixos.dark-mode = {
    environment.variables = {
      GTK_THEME = "Adwaita:dark";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };
  };

  flake.modules.nixos.light-mode = {
    environment.variables = {
      GTK_THEME = "Adwaita:light";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };
  };
}
