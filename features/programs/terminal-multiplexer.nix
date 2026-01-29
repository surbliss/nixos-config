{

  flake.modules.homeManager.cli =
    { pkgs, custom-link, ... }:
    let
      with-nix = pkgs.writeShellScriptBin "with-nix" ''
        eval "$(direnv export zsh)"
        exec "$@"
      '';
    in
    {
      home.packages = with pkgs; [
        zellij
        with-nix
      ];
      xdg.configFile = custom-link "zellij";

    };
}
