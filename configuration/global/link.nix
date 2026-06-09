### Makes an outOfStoreSymlink, for configs that are often modified
{
  flake.modules.homeManager.default = { config, ... }: {
    ### Usage:
    # in .config: xdg.configFile = config.custom.link <src>;
    # in home: home.file = config.custom.link <src>;
    _module.args.custom-link = src: {
      ${src} = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${src}";
        recursive = true;
      };
    };
  };
}
