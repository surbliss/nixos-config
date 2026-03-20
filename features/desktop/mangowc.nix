{ inputs, moduleWithSystem, ... }:

{
  flake.modules.nixos.desktop = moduleWithSystem (
    { inputs', ... }:
    { pkgs, ... }:
    let
      mango = inputs'.mangowc.packages.mango;
    in
    {
      ### Import mango-module from flake
      imports = [ inputs.mangowc.nixosModules.mango ];

      ### DankMaterialShell
      programs.dms-shell.enable = true;

      ### DankMateralGreeter
      programs.sway.enable = true; # For running the greeter in
      services.displayManager.dms-greeter = {
        enable = true;
        compositor = {
          name = "sway"; # Required. Can be also "hyprland" or "niri"
          # Disable mouse acceleration
          customConfig = ''
            input type:pointer {
              accel_profile flat
            }
          '';
        };

        # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
        configHome = "/home/angryluck";

      };

      programs.mango.enable = true;
      # Add the default config
      environment.etc."mango".source = "${mango}/etc/mango";
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    }
  );
  flake.modules.homeManager.desktop =
    { pkgs, custom-link, ... }:
    {
      xdg.configFile = custom-link "mango";
      home.packages = with pkgs; [
        ### Packages that default config uses
        foot
        # rofi

        ### Suggested packages, see https://mangowc.vercel.app/docs/quick-start/
        # fuzzel
        wezterm
        # waybar
        # noctalia-shell
        swaybg
        wl-clipboard
        wl-clip-persist
        cliphist

        wlsunset

        wlogout
        slurp
        wlr-which-key

        # dunst

        # polkit_gnome
      ];

    };
}
