# Virtualization, specifically enabling KVM. See https://nixos.wiki/wiki/Virt-manager
{
  flake.modules.nixos.system = {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ "angryluck" ];

    users.users.angryluck.extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };

  flake.modules.homeManager.system = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
