{
  flake.modules.nixos.default = { lib, ... }: {
    options.custom.mainUser = lib.mkOption {
      type = lib.types.str;
      description = "Main user on system";
      example = "angryluck";
    };
  };
}
