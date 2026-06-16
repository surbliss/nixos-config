{ inputs, self, ... }:
let
  hostname = "server-surface";
  host-config = {
    custom.mainUser = "angryluck";
    networking.hostName = hostname;
    system.stateVersion = "26.05";
  };
in
{
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      host-config

      self.modules.nixos.default
      self.modules.nixos.home-server
      self.modules.nixos.nh # Garbage-collection

      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default

      ./hardware-configuration.nix
      ./disk-config.nix
      ./preservation.nix
    ];
  };
}
