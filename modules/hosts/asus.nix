{
  # NOTE: Needs a do-over when I have multiple hosts
  flake.modules.nixos.asus = {
    imports = [ ./_hardware-configuration.nix ];
  };
}
