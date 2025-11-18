{ inputs, self, ... }:
{
  # The ASUS laptop (should probably have been called that instead of angryluck...)
  flake.modules.nixos.asus21 =
    { lib, ... }:
    {
      imports = [
        _generated/asus21-hardware-configuration.nix
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
    };

  flake.nixosConfigurations.asus21 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.modules.nixos; [
      asus21
      angryluck
      cli
      desktop
      gui
      gaming
      system
      fonts
    ];
  };
  # To check outputs of the above:
  # > nix repl (in /etc/nixos/ dir)
  # > :lf . (loads flake in . directory)
  # > builtins.attrNames outputs.<whatever>

  # TODO: Add home-manager config for angryluck here!
}
