{
  flake.modules.homeManager.cli =
    { pkgs, config, ... }:
    let
      link = dir: {
        ${dir} = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${dir}";
          recursive = true;
        };
      };
    in
    {
      home.packages = with pkgs; [ zellij ];
      xdg.configFile = link "zellij";

    };
}
