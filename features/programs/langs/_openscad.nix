{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [ openscad-lsp ];
  };

  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ openscad ];
  };
}
