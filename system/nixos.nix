{ inputs, ... }:
{
  # FIX: (And put in appropriate place)
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
    "dotnet-sdk-7.0.410" # Remove when SU is done!
  ];

  # TODO: Make per package
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Got errors saying paths cannot be repaired, trying to disable this.
  # See https://github.com/NixOS/nix/issues/1281
  nix.optimise.automatic = false;
  nix.settings.auto-optimise-store = false;
  nix.channel.enable = false;
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
  system.stateVersion = "24.05"; # Did you read the comment?

}
