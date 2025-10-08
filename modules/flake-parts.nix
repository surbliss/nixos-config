{ inputs, ... }:
{
  # Allows defining in the module structure, important!
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];
}
