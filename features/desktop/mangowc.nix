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
              "--asterisks"
              # Sample theme from https://github.com/apognu/tuigreet, with input changed from 'red' to 'white'
              "--theme border=magenta;text=cyan;prompt=green;time=white;action=blue;button=yellow;container=black;input=white"
            ];
            user = "greeter";
          };
        };
      };

      ### Global themeing for console, based on terminal theme (minimal-custom)
      console.colors = [
        "1f1f28" # black (terminal bg)
        "C34043" # red
        "98BB6C" # green
        "E6C384" # yellow
        "A3D4D5" # blue
        "B8B4D0" # magenta
        "7E9CD8" # cyan
        "c8c093" # white
        "727169" # bright black
        "e82424" # bright red
        "98bb6c" # bright green
        "e6c384" # bright yellow
        "7fb4ca" # bright blue
        "938aa9" # bright magenta
        "7aa89f" # bright cyan
        "dcd7ba" # bright white
      ];

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

  flake.modules.homeManager.desktop = { pkgs, custom-link, ... }: {
    ### Noctalia flake input
    imports = [ inputs.noctalia.homeModules.default ];
    xdg.configFile = custom-link "mango";
    programs.noctalia-shell.enable = true;

    gtk.iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

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

      ### For starting xwayland
      xrdb

      brightnessctl

      ### Screenshotting
      grim
      satty
    ];

  };
}
