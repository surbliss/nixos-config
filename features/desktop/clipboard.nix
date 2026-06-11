{
  # Unsure if 'desktop' is the right module  here :/
  flake.modules.homeManager.desktop = {
    services.wl-clip-persist.enable = true;
    services.cliphist.enable = true;
  };
}
