{ inputs, ... }:
{
  # Mandatory for enabling dendritic configuration-pattern
  imports = [
    inputs.flake-parts.flakeModules.modules # flake-parts modules
    inputs.home-manager.flakeModules.home-manager # Home manager
  ];
}
