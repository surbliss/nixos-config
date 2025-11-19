# User-configuration, see https://vic.github.io/dendrix/Dendritic.html
let
  username = "angryluck";
in
{
  flake.modules.nixos.${username} = {
    # Belongs to input :/
    # But! Probably makes sense to move to a user-local config anyways!
    users.groups.uinput = { };
    services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'';

    # VirtualBox
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ username ];

    users.users.${username} = {
      isNormalUser = true;
      home = "/home/${username}";
      description = "Mr. Surlykke's profile";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "input"
        "uinput"
        # "nixos-editor" # Allowed to edit /etc/nixos/ without sudo
        # "vboxusers"
        "docker"
        "uinput" # Custom keyboard layouts?
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj" # Can, optionally, add email after public ssh-key
      ];
      useDefaultShell = true;
    };
  };
  flake.modules.homeManager.${username} =
    { pkgs, ... }:
    {
      # TEMP: Just for testing user-install of home-manager:
      home.packages = [ pkgs.hello ];
      home.username = username;
      home.homeDirectory = /home/${username};
    };
}
