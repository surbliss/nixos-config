{
  ### See https://www.vimjoyer.com/vid89-impermanent/disko

  # Mount /nix before booting, as entire system lives in /nix/store
  fileSystems."/nix".neededForBoot = true;

  disko.devices.nodev = {
    "/" = {
      # Root filesystem in RAM
      fsType = "tmpfs";

      mountOptions = [
        # Max RAM root can use
        "size=25%"
        # Standard directory permissions
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    # The disk, REMEMBER to check with `lsblk
    device = "/dev/nvme0n1";
    type = "disk"; # A physical disk
    content.type = "gpt"; # GPT partition table, required for UEFI

    # Tiny BIOS boot partition. Should only be necessary for legacy BIOS systems, but is harmless to include.
    content.partitions.boot = {
      size = "1M";
      type = "EF02";
    };

    # EFI System Partitions where bootloader lives.
    content.partitions.esp = {
      size = "1G";
      # EF00 is GPT type code for EFI Partitions
      type = "EF00";
      content = {
        type = "filesystem";
        # FAT32, reqired by EFI
        format = "vfat";
        mountpoint = "/boot";
      };
    };

    content.partitions.swap = {
      size = "4G"; # No need for 1.5x RAM, since no hibernations
      content = {
        type = "swap";
        # Tells the kernel this is the swap device to resume from, for hibernation. Hibernation is not needed in this case, but this setting is required by NixOS if swap exists.
        resumeDevice = true;
      };
    };

    # Main partition
    content.partitions.root = {
      # All remaining space
      size = "100%";
      content = {
        type = "btrfs";
        # Force creation, even if disk already has a filesystem
        extraArgs = [ "-f" ];

        subvolumes = {
          "/persistent" = {
            mountOptions = [
              "subvol=persistent"
              "noatime" # Don't update access timestamps, better performance
            ];
            # The mount that is not deleted between boots
            mountpoint = "/persistent";
          };
          "/nix" = {
            mountOptions = [
              "subvol=nix"
              "noatime"
            ];
            # Nix store lives here. Survives reboots, otherwise system wouldn't boot. Separate from /persistent, to distinguish nix-store-generation stuff from actual files (documents, logs, databases, etc, which live in /persistent). This allows still garbage-collecting nix-store-stuff
            mountpoint = "/nix";

          };
        };
      };
    };
  };
}
