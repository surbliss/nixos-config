{ config, ... }:
{
  preservation = {
    enable = true;
    preserveAt."/persistent" = {
      # NOTE: /etc/nixos is _not_ added - updating of server is done from main computer
      directories = [
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
