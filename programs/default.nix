{
  config,
  # pkgs,
  # stablePkgs,
  lib,
  ...
# inputs,
# system,
}:
let
  # getPackages =
  #   path:
  #   import path {
  #     inherit pkgs;
  #     inherit stablePkgs;
  #     inherit inputs;
  #     inherit system;
  #   };
  # # packages = lib.lists.concatMap getPackages [
  #   ./cli.nix # ## Split up cli
  #   ./desktop.nix
  #   ./utilities.nix
  # ];
  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    types
    ;
  cfg = config.custom;
in
{
  imports = [
    ./cli.nix # ## Split up cli
    ./gui.nix
    ./nushell.nix
    ./sql.nix
    ./zsh.nix
    ./utilities.nix
  ];

  options.custom = {
    packages-installed = mkOption {
      type = types.listOf types.package;
      description = "Packages to install";
      default = [ ];
    };
    only-home-manager = mkEnableOption "only home-manager (no NixOS)";
    # Move to another module, maybe...
    # home-manager = mkEnableOption "home-manager installs.";
  };

  config = {
    # Install all packages
    environment.systemPackages = mkIf (!cfg.only-home-manager) cfg.packages-installed;

    ### Right now doesn't allow rebuilding, fix later...
    # home-manager.users.TODOUSERNAME.home.packages =
    #   lib.mkIf cfg.only-home-manager cfg.packages-installed;

    ### Can do the same with environment variables!
  };
}

### Extra:
# Move this to local config
# slock.enable = true;
# nix-ld.enable = true;

### For DIKU-Canvas to work.
### Everything here seems not needed - it worked earlier, but stopped working,
### and now the nix-shell has been made to fix it.
# nix-ld.libraries =
#   (with pkgs; [
#     ### See https://github.com/diku-dk/DIKUArcade/blob/master/shell.nix
#     stdenv
#     libGL
#     # stdenv.cc.cc.lib # This includes libstdc++
#     # xorg.libXrandr # X11 randr support
#   ])
#   ++ (with pkgs.xorg; [
#     libX11
#     libXext
#     libXinerama
#     libXi
#     libXrandr
#   ]);
