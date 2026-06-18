{
  flake.modules.nixos.nh = {
    programs.nh = {
      # Cli-tool for unified nixos-commands
      enable = true;
      # Periodic cleaning
      clean.enable = true;
      # Keep the last 5 _and_ anything more recent than 14 days
      clean.extraArgs = "--keep 5 --keep-since 14d";
    };
    # nh cleaning conflicts with standard gc-setting!
    nix.gc.automatic = false;

    # Allow password-less rebuilding of server
  };

  flake.modules.nixos.home-server = {
    security.sudo.extraRules = [
      {
        users = [ "angryluck" ];
        # See https://www.man7.org/linux/man-pages/man5/sudoers.5.html for 'glob' info. Note, that '*' inside the command-part does _not_ match '/', but it _does_ inside the command passed (alongside whitespace). So, specify 'test', 'switch' and 'boot' explicitly!
        commands = [
          {
            command = "/nix/store/*nixos-system-server-surface-*/bin/switch-to-configuration test";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/nix/store/*nixos-system-server-surface-*/bin/switch-to-configuration switch";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/nix/store/*nixos-system-server-surface-*/bin/switch-to-configuration boot";
            options = [ "NOPASSWD" ];
          }
        ];

      }
    ];
  };

}
