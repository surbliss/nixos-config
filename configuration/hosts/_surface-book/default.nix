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
  hostname = "surface-book";
  host-config = {
    custom.mainUser = "angryluck";
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

    # Driver crash fix, known bug for Surface Books
    boot.kernelParams = [ "mwifiex_pcie.disable_host_sleep=1" ];
  };

in
{

  # Surface-book 1, even older than Zenbook
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
      self.modules.nixos.gaming
      self.modules.nixos.system
      self.modules.nixos.fonts
      self.modules.nixos.home-manager-setup
    ];
  };
}
