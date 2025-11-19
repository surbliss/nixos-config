{
  inputs,
  withSystem,
  self,
  ...
}:
let
  hostname = "asus21";
  hostSystem = "x86_64-linux";
  # TODO: Make this work?
  moduleList = [
    "asus21"
    "angryluck"
    "cli"
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
in
{

  # The ASUS zenbook
  flake.modules.nixos.${hostname} =
    { lib, ... }:
    {
      imports = [
        _generated/asus21-hardware-configuration.nix
      ];
      # TODO: Find better global place for this!
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
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
        ];
      networking.hostName = hostname;
      networking.networkmanager.enable = true;
    };

  flake.nixosConfigurations.asus21 = inputs.nixpkgs.lib.nixosSystem {
    # inherit system; # Not technically needed, as defined in hardware config
    modules = getModules self.modules.nixos;

  };
  # To check outputs of the above:
  # > nix repl (in /etc/nixos/ dir)
  # > :lf . (loads flake in . directory)
  # > builtins.attrNames outputs.<whatever>

  flake.homeConfigurations.angryluck = withSystem hostSystem (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = getModules self.modules.homeManager;
      # with self.modules.homeManager; [
      #   angryluck
      #   system
      # ];
    }
  );
}
