# Enabling home-manager properly, as a nixos-module.
# NOTE: Part of 'default' now - move to separate module, if a system-install without home-manager is needed.
# Requires importing 'inputs.home-manager.nixosModules.home-manager' into the 'modules' of the nixosConfiguration.
# To add a user config, do "home-manager.users.<user> = {...};", and add home-manager modules as imports to this attribute set.
{ inputs, ... }:
{
  flake.modules.nixos.default = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.backupFileExtension = "backup";
  };
}
