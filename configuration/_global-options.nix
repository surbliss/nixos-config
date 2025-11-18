{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  # Global options for modules do use. Defined here rather than in modules/
  # to indicate that other modules are allowed to _rely_ on these options being
  # available!

  # Note that this options doesn't make much sense -- nixosConfig is global
  # to all users, so a single username-parameter does not help.
  flake.options = {
    username = mkOption {
      type = types.str;
      default = "angryluck";
    };
  };
}
