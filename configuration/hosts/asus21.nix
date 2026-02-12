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
  inherit (lib) mkDefault;
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
  };

  flake.nixosConfigurations.asus21 = inputs.nixpkgs.lib.nixosSystem {
    # No need to set 'system', as it is define in hardware config
    modules = nixosModules ++ [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.angryluck = {
          imports = [ self.modules.homeManager.angryluck ];
        };
      }
    ];
  };

  # flake.modules.homeManager.${hostname} =
  #   { pkgs, ... }:
  #   {
  #     # mkDefault, or conflicts with nixos-def
  #     nix.package = mkDefault pkgs.nix;
  #     nix.settings.experimental-features = [
  #       "nix-command"
  #       "flakes"
  #       "pipe-operators"
  #     ];

  #     nixpkgs.config.allowUnfreePredicate =
  #       pkg:
  #       builtins.elem (lib.getName pkg) [
  #         "discord"
  #         "steam"
  #         "zoom"
  #         "obsidian"
  #         "android-studio-stable"
  #         "android-studio"
  #         "keymapp"
  #         "steam-unwrapped"
  #         "idea"
  #       ];
  #   };

  # flake.homeConfigurations.angryluck = withSystem hostSystem (
  #   { pkgs, ... }:
  #   inputs.home-manager.lib.homeManagerConfiguration {
  #     inherit pkgs;
  #     modules = homeModules;
  #   }
  # );
}
