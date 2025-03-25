{ lib, ... }:
{
  imports = [ ./cursor.nix ];

  custom.cursor.enable = lib.mkDefault true;
}
