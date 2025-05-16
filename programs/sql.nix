{ pkgs, ... }:
{
  # Couldn't figure out how to make this part of a nix shell
  # services.postgresql = {
  #   enable = true;
  #   package = pkgs.postgresql;
  #   ensureDatabases = [ "dis" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';
  # };

  virtualisation.docker.enable = true;
  users.users.angryluck.extraGroups = [ "docker" ];

  # custom.packages-installed = [
  #   pkgs.pgadmin4
  #   pkgs.pgadmin4-desktop
  # ];
  #   = {
  #   enable = true;
  #   ensureDatabases = [ "mydatabase" ];
  #   authentication = lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';
  # };
  # services.pgadmin = {
  #   enable = true;
  #   initialEmail = "email@email.dk";
  #   initialPasswordFile = "/home/angryluck/.sql/password.txt";
  # };

}
