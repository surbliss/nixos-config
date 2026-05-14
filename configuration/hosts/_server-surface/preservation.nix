{ config, ... }:
{
  preservation = {
    enable = true;
    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        "/var/lib/systemd"
        "/var/log"
        "/etc/ssh"
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
      users.${config.custom.mainUser} = {
        directories = [ ".ssh" ];
      };
    };
  };
}
