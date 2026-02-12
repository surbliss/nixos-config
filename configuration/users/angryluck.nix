{ self, ... }:
# Home-manager config for angryluck, i.e. list of modules to install.
{
  flake.modules.nixos.angryluck = {
    home-manager.users.angryluck = {
      imports = with self.modules.homeManager; [
        angryluck
        cli
        default
        desktop
        gui
        gaming
        fonts
      ];
    };
  };
}
