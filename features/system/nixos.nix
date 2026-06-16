{ inputs, self, ... }:
let
  stateVersion = "24.05";
in
{
  flake.modules.nixos.system = {
    imports = [ self.modules.nixos.nh ];
    # See https://github.com/NixOS/nix/issues/1281
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;

    # See https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry
    nix.channel.enable = false;
    nixpkgs.flake.setFlakeRegistry = true;
    nix.registry.nixpkgs.flake = inputs.nixpkgs;

    ### Always needed
    # Don't change, doesn't affect the version of packages installed.
    # IF you relly want to change, first read `man configuration.nix` and
    # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
    # system.stateVersion = "24.05"; # Did you read the comment?
    system.stateVersion = stateVersion;

  };

  flake.modules.homeManager.system = {
    # Should probably match the nixos-stateVersion
    home.stateVersion = stateVersion;
    programs.home-manager.enable = true;
  };
}
