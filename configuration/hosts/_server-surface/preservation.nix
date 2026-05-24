{
  boot.initrd.systemd.enable = true; # Required
  preservation.enable = true; # Needed to preserve anything
  preservation.preserveAt."/persistent" = {
    # NOTE: /etc/nixos is _not_ added - updating of server is done from main computer
    directories = [
      "/etc/NetworkManager/system-connections" # Save wifi-connections
      # Needed for user/group management state, hence in initrd
      {
        directory = "/var/lib/nixos";
        inInitrd = true;
      }

      # For systemd services with a specific candence/timing, otherwise might fire immediately on reboot
      "/var/lib/systemd/timers"

      # Log files, useful for debugging, but take notice if it grows too much
      "/var/log"
    ];
    files = [
      # If deleted on reboot, can slow down cryptography a lot, like encrypting SSH keys
      {
        file = "/var/lib/systemd/random-seed";
        inInitrd = true;
        how = "symlink";
        configureParent = true;
      }

      # Needed at boot
      {
        file = "/etc/machine-id";
        inInitrd = true;
      }
      # See https://nix-community.github.io/preservation/impermanence-migration.html for guide on configuring ssh
      {
        file = "/etc/ssh/ssh_host_rsa_key";
        configureParent = true;
        # So agenix can read key
        how = "symlink";
        inInitrd = true;
      }
      {
        file = "/etc/ssh/ssh_host_ed25519_key";
        configureParent = true;
        # So agenix can read key
        how = "symlink";
        inInitrd = true;
      }
    ];
    # NOTE: User .ssh folder also not added, authorized_keys is managed through nixos-config
  };

  # systemd-machine-id-commit tries to save a transient machine-id to disk, but
  # since machine-id is already on persistent storage via preservation, it fails.
  # Disable the condition so the service never runs.
  systemd.services."systemd-machine-id-commit" = {
    unitConfig.ConditionPathIsMountPoint = "!/etc/machine-id";
  };
}
