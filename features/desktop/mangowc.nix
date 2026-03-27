{ inputs, moduleWithSystem, ... }:

{
  flake.modules.nixos.desktop = moduleWithSystem (
    { inputs', ... }:
    { pkgs, config, ... }:
    let
      mango-pkg = inputs'.mangowc.packages.mango;
    in
    {
      ### Mango flake input
      imports = [ inputs.mangowc.nixosModules.mango ];
      ### Login greeter
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = builtins.concatStringsSep " " [
              "${pkgs.tuigreet}/bin/tuigreet"
              "--time"
              "--remember"
              "--cmd ${mango-pkg}/bin/mango"
              # Sample theme from https://github.com/apognu/tuigreet
              "--theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red"
            ];
            user = "greeter";
          };
        };
      };

      ### Mango
      programs.mango.enable = true;
      # Add the default config
      environment.etc."mango".source = "${mango-pkg}/etc/mango";

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      ### Noctalia
      # Noctalia requires these settings enabled, make sure enabled elsewhere
      assertions = [
        {
          assertion =
            config.services.power-profiles-daemon.enable || config.services.tuned.enable;
          message = "Noctalia: requires either services.power-profiles-daemon.enable or services.tuned.enable";
        }
        {
          assertion = config.networking.networkmanager.enable;
          message = "Noctalia: requires networking.networkmanager.enable";
        }
        {
          assertion = config.hardware.bluetooth.enable;
          message = "Noctalia: requires hardware.bluetooth.enable";
        }
        {
          assertion = config.services.upower.enable;
          message = "Noctalia: requires services.upower.enable";
        }
      ];
    }
  );

  flake.modules.homeManager.desktop =
    { pkgs, custom-link, ... }:
    {
      ### Noctalia flake input
      imports = [ inputs.noctalia.homeModules.default ];
      xdg.configFile = custom-link "mango";
      programs.noctalia-shell.enable = true;

      home.packages = with pkgs; [
        ### Packages that default config uses
        foot

        ### Suggested packages, see https://mangowc.vercel.app/docs/quick-start/
        wezterm
        swaybg
        wl-clipboard
        wl-clip-persist
        cliphist

        wlsunset

        wlogout
        slurp
        wlr-which-key
      ];

    };
}
