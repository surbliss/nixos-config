{
  # Unsure if 'desktop' is the right module  here :/
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    services.wl-clip-persist.enable = true;
    services.cliphist.enable = true;
    home.packages = with pkgs; [ wl-clipboard ];
  };
}
