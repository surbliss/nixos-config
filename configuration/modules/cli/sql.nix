{
  flake.modules.nixos.cli = {
    virtualisation.docker.enable = true;
    # Also need to add "docker" as extraGroups.
    # TODO: Find way to do this, without coupling 'username'
  };
}
