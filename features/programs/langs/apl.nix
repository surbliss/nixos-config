# Install dyalog APL
{

  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      home.packages = [ (pkgs.dyalog.override { acceptLicense = true; }) ]; # Note: Unfree license
    };

  ### FIX: Hardcoded path for now, make a derivation
  flake.modules.homeManager.gui =
    { config, ... }:
    {
      xdg.desktopEntries.ride = {
        name = "RIDE";
        exec = "${config.home.homeDirectory}/ride-4.6/Ride-4.6";
        icon = "${config.home.homeDirectory}/ride-4.6/icons/hicolor/scalable/apps/ride46.svg";
        comment = "Remote IDE for Dyalog APL";
        categories = [
          "Development"
          "IDE"
        ];
      };
    };
  ### NOTE: Nixpkgs version of RIDE uses too new version of electron.
  # Install binary manually instead.
  flake.modules.nixos.gui =
    { pkgs, ... }:
    {
      # Needed nix-ld dependencies for RIDE
      # TODO: Fetch the binary too, and extract it
      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glib
        nss
        nspr
        dbus
        atk
        at-spi2-atk
        at-spi2-core
        cups
        gtk3
        pango
        cairo
        expat
        mesa
        libxkbcommon
        alsa-lib
        systemd # libudev
        libX11
        libXcomposite
        libXdamage
        libXext
        libXfixes
        libXrandr
        libxcb
        libgbm
        libGL
      ];
    };
}
