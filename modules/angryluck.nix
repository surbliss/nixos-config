{ inputs, config, ... }:
{
  flake.nixosConfigurations.angryluck = inputs.nixpkgs.lib.nixosSystem {

    system = [ "x86_64-linux" ];
    modules = builtins.attrValues config.flake.modules.nixos;
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
