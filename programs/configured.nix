# programs. ... .enable, with default nix configurations
# All these should probably be user settings
{ pkgs, inputs }:
{
  programs = {
    thunderbird.enable = true;

    direnv.enable = true;
    environment.etc."direnv/direnv.toml".text = ''
      [global]
      hide_env_diff = true
    '';

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };

    # Move this to local config
    yazi = {
      enable = true;
      settings = {
        yazi.opener.open = [
          {
            run = "xdg-open \"$1\"";
            orphan = true; # Allows closing yazi, after opening a file (e.g. pdf)
            desc = "Open";
            for = "linux";
          }
          {
            run = "open \"$@\"";
            desc = "Open";
            for = "macos";
          }
          {
            run = "start \"\" \"%1\"";
            orphan = true;
            desc = "Open";
            for = "windows";
          }
        ];
        keymap.manager.prepend_keymap = [
          {
            on = "T";
            run = "shell \"$SHELL\"  --confirm --block --orphan";
            desc = "Open shell here";
          }
        ];
      };
    };

    # slock.enable = true;
    # nix-ld.enable = true;

    ### For DIKU-Canvas to work.
    ### Everything here seems not needed - it worked earlier, but stopped working,
    ### and now the nix-shell has been made to fix it.
    # nix-ld.libraries =
    #   (with pkgs; [
    #     ### See https://github.com/diku-dk/DIKUArcade/blob/master/shell.nix
    #     stdenv
    #     libGL
    #     # stdenv.cc.cc.lib # This includes libstdc++
    #     # xorg.libXrandr # X11 randr support
    #   ])
    #   ++ (with pkgs.xorg; [
    #     libX11
    #     libXext
    #     libXinerama
    #     libXi
    #     libXrandr
    #   ]);

  };
}
