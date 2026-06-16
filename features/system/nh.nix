{
  flake.modules.nixos.nh = {
    programs.nh = {
      # Cli-tool for unified nixos-commands
      enable = true;
      # Periodic cleaning
      clean.enable = true;
      # Keep the last 5 _and_ anything more recent than 14 days
      clean.extraArgs = "--keep 5 --keep-since 14d";
    };
    # nh cleaning conflicts with standard gc-setting!
    nix.gc.automatic = false;
  };
}
