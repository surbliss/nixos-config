{ inputs, moduleWithSystem, ... }:

{
  flake.modules.nixos.desktop = moduleWithSystem (
    { inputs', ... }:
    { pkgs, ... }:
    {
      imports = [ inputs.mangowc.nixosModules.mango ];
      programs.mango.enable = true;
      # Add the default config
      environment.etc."mango".source =
        "${inputs'.mangowc.packages.mango}/etc/mango";
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    }
  );
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ### Packages that default config uses
        foot
        rofi

        ### Suggested packages, see https://mangowc.vercel.app/docs/quick-start/
        fuzzel
        wezterm
        waybar
        noctalia-shell
        swaybg
        wl-clipboard
        wl-clip-persist
        cliphist

        wlsunset

        wlogout

        dunst

        polkit_gnome
      ];

    };
}
