{
  flake.modules.nixos.gui =
    { pkgs, ... }:
    let
      # coq-with-ide = pkgs.coq.override { buildIde = true; };
      coq-with-ide = pkgs.coq.override { buildIde = true; };

      rocq-packages = with pkgs.rocqPackages; [
        ssprove
        vsrocq-language-server
      ];
    in
    {
      environment.systemPackages = [ coq-with-ide ] ++ rocq-packages;

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
