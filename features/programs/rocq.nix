{
  flake.modules.nixos.gui =
    { pkgs, lib, ... }:
    let
      # coq-with-ide = pkgs.coq.override { buildIde = true; };
      coq-with-ide = pkgs.coq.override { buildIde = true; };
      coq-with-packages = coq-with-ide.withPackages (
        p: with p; [
          ssprove
          vscoq-language-server
        ]
      );
    in
    {
      environment.systemPackages = [
        (lib.lowPrio coq-with-ide)
        coq-with-packages
      ];

    };

  flake.modules.homeManager.gui = {
    xdg.desktopEntries.rocqide = {
      type = "Application";
      exec = "env GTK_THEME=Adwaita:light rocqide";
      name = "RocqIDE";
      terminal = false;
    };
  };
}
