{ inputs, ... }:
{
  # Mandatory: Allows using the flake-parts module system
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
