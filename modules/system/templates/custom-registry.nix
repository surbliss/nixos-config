{
  flake.modules.nixos.system = {
    # Can repurpose it later and rename this file to "custom-registry",
    # but for now only purpose is templates
    nix.registry.custom.to = {
      type = "path";
      path = ./_custom;
    };
  };
}
