##################################################
# Terminal + Shell config
##################################################
{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.nushell;
      # NOTE: NixOS wiki recommends enabling zsh this way
      programs.zsh.enable = true;

      # Default terminal-opener
      xdg.mime.enable = true;
      xdg.mime.defaultApplications =
        let
          terminal = [
            "Alacritty.desktop"
            "org.wezfurlong.wezterm.desktop"
            "kitty.desktop"
            "kitty-open.desktop"
          ];
        in
        {
          "x-scheme-handler/terminal" = terminal;
          "application/x-terminal-emulator" = terminal;
        };

      environment.systemPackages = with pkgs; [
        nushell
        carapace # completions for nushell
        # nufmt # NOTE: Very broken formatter, wait for it to mature more
        git # Needed for zinit plugin-manager
        zoxide
        eza
        starship
        oh-my-posh

        # Terminals
        wezterm
        alacritty
        kitty
        foot
      ];
    };
}
