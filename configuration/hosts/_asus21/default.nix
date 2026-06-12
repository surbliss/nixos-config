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
  host-config = {
    custom.mainUser = "angryluck";

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
        "dyalog"
      ];
    networking.hostName = hostname;
  };
in
{

  # The ASUS zenbook, from 2021
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    # No need to set 'system', as it is define in hardware config
    modules = [
      host-config
      ./hardware-configuration.nix
      self.modules.nixos.angryluck
      self.modules.nixos.cli
      self.modules.nixos.default
      self.modules.nixos.desktop
      self.modules.nixos.gui
      self.modules.nixos.light-mode
      self.modules.nixos.system
      self.modules.nixos.fonts
      self.modules.nixos.home-manager-setup
    ];
  };
}
