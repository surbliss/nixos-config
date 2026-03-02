# This file defines the available modules (so even if it contains no valid settings currently, it can still be imported).
# It is possible to define new modules in features/, but should be avoided, as you would have to comb through that directory then, to identify available modules.
{
  flake.modules.nixos = {
    cli = { };
    default = { };
    desktop = { };
    gui = { };
    gaming = { };
    system = { };
    fonts = { };
  };

  flake.modules.homeManager = {
    angryluck = { };
    cli = { };
    default = { };
    desktop = { };
    gui = { };
    gaming = { };
    fonts = { };
    system = { };
  };
}
