{ inputs, self, ... }:
# Home-manager config for angryluck, i.e. list of modules to install.
let
  moduleList = [
    "asus21"
    "cli"
    "default"
    "desktop"
    "gui"
    "gaming"
    "system"
    "fonts"
  ];
  getModules =
    cont:
    moduleList
    |> map (name: cont.${name} or null)
    |> builtins.filter (m: m != null);
  homeModules = getModules self.modules.homeManager;
in
{
  flake.modules.homeManager.angryluck = {
    imports = homeModules;
  };

  # flake.modules.nixos.angryluck = {
  #   inputs.home-manager = {
  #     useGlobalPkgs = true;
  #     useUserPackages = true;
  #     users.angryluck.imports = [ self.modules.homeManager.angryluck ];
  #   };
  # };

}
