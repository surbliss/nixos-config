# Enabling home-manager properly.
# NOTE: Part of 'default' now - move to separate module, if a system-install without home-manager is needed.
{ inputs, ... }:
{
  flake.modules.nixos.default = { };
}
