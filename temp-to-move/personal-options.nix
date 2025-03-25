{ lib }:
{
  personal-options = {
    is-server = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this is a server configuration";
    };
  };
}
