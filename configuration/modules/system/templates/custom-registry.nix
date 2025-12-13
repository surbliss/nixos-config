{
  flake.modules.nixos.system = {
    # Can add more later for other custom shells in registry

    # For dev-shells
    nix.registry.devshell.to = {
      type = "path";
      path = ./_devshell;
    };
  };
}
