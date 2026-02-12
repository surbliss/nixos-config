## Enabling flake-parts.
## Mandatory for enabling dendritic configuration-pattern
{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
}
