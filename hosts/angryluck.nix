{
  inputs,
  config,
  ...
}:
{
  # The ASUS laptop (should probably have been called that instead of angryluck...)
  flake.modules.nixos.angryluck =
    { lib, ... }:
    {
      imports = [
        _generated/angryluck-hardware-configuration.nix
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
  flake.nixosConfigurations.angryluck = inputs.nixpkgs.lib.nixosSystem {
    system = [ "x86_64-linux" ];
    # Write this manually
    modules = with config.flake.modules.nixos; [
      angryluck
      cli
      desktop
      gui
      gaming
      system
      fonts
    ];

    # To check outputs of the above:
    # > nix repl (in /etc/nixos/ dir)
    # > :lf . (loads flake in . directory)
    # > builtins.attrNames outputs.<whatever>

    ### Alternative (probably better, so I'm sure I dont miss any):
    # modules = with config.flake.modules.nixos; [
    #   audio
    #   boot
    #   input
    #   misc
    #   nixos
    #   power
    #   udev
    #   variables
    #   unfree

    #   shell

    #   cli

    #   desktop
    #   fonts
    #   niri
    #   asus

    # ];

  };

  #  {
  #   # System?
  #   system = [ "x86_64-linux" ];
  #   modules = [
  #     config.nixos
  #   ];
  # };
}
