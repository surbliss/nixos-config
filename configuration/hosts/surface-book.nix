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
  moduleList = [
    hostname
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
  # The Surface Book 1, even older than the zenbook
  flake.modules.nixos.${hostname} = {
    custom.mainUser = "angryluck";

    imports = [ _generated/surface-book-hardware-configuration.nix ];
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
      ];
    networking.hostName = hostname;

    # Driver crash fix, known bug for Surface Books
    boot.kernelParams = [ "mwifiex_pcie.disable_host_sleep=1" ];
  };

  flake.nixosConfigurations.surface-book = inputs.nixpkgs.lib.nixosSystem {
    # No need to set 'system', as it is define in hardware config
    modules = nixosModules;
  };
}
