{
  flake.modules.nixos.cli = {
    virtualisation.docker.enable = true;
    users.users.angryluck.extraGroups = [ "docker" ];
  };
}
