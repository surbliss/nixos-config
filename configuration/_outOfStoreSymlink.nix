# Helper function, to make impure config-links in homeManager
# Usage: imports = [(link "myprogram")];
{
  perSystem =

    let
      root = config: config.home.homeDirectory + "/.dotfiles";
      link =
        name:
        { config, ... }:
        {
          xdg.configFile.${name}.source =
            config.lib.file.mkOutOfStoreSymlink "${root config}/${name}";
        };
      linkDir =
        dir:
        { config, ... }:
        {
          xdg.configFile.${dir} = {
            source = config.lib.file.mkOutOfStoreSymlink "${root config}/${dir}";
            recursive = true;
          };

        };
    in

    {
      _module.args = {
        inherit link;
        inherit linkDir;
      };
    };
}
