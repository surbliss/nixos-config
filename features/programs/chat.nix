{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    # WARN: As of 2026-07-16, Vesktop uses EOL electron version
    # programs.vesktop.enable = true;

    # Dorion uses Tauri, should be more stable
    home.packages = with pkgs; [ dorion ];
  };
}
