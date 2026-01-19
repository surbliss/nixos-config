{ inputs, ... }:
let
  stateVersion = "24.05";
in
{
  flake.modules.nixos.system = {
    # See https://github.com/NixOS/nix/issues/1281
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;

    # See https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry
    nix.channel.enable = false;
    nixpkgs.flake.setFlakeRegistry = true;
    nix.registry.nixpkgs.flake = inputs.nixpkgs;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # https://nixos.wiki/wiki/Automatic_system_upgrades
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };

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
