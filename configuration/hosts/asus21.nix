{
  inputs,
  self,
  lib,
  ...
}:
# To check outputs of modules:
# > nix repl (in /etc/nixos/ dir)
# > :lf . (loads flake in . directory)
# > builtins.attrNames outputs.<whatever>
let
  hostname = "asus21";
  moduleList = [
    "asus21"
    "angryluck"
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
  nixosModules = getModules self.modules.nixos;
in
{

  # The ASUS zenbook, from 2021
  flake.modules.nixos.${hostname} = {
    custom.mainUser = "angryluck";

    imports = [ _generated/asus21-hardware-configuration.nix ];
    # TODO: Find better global place for this!
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "discord"
        "vscode"
        "steam"
        "zoom"
        "obsidian"
        "android-studio-stable"
        "android-studio"
        "keymapp"
        "steam-unwrapped"
        "idea"
        "claude-code"
      ];
    networking.hostName = hostname;
  };

  flake.nixosConfigurations.asus21 = inputs.nixpkgs.lib.nixosSystem {
    # No need to set 'system', as it is define in hardware config
    modules = nixosModules;
  };
}
