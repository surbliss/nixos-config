# Setup terminal emulator + the shell + main tools. Specific cli-tools are
# defined elsewhere
{
  flake.modules.nixos.cli = { pkgs, ... }: {
    users.defaultUserShell = pkgs.nushell;
    # NOTE: NixOS wiki recommends enabling zsh this way
    programs.zsh.enable = true;

    # Default terminal-opener
    xdg.mime.enable = true;
    xdg.mime.defaultApplications =
      let
        terminal = [
          "org.wezfurlong.wezterm.desktop"
          "Alacritty.desktop"
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
      nufmt # NOTE: Very broken formatter, but trying again
      git # Needed for zinit plugin-manager
      zoxide
      eza
      oh-my-posh

      # Terminals
      wezterm
      alacritty
      kitty
      foot
    ];
  };

  flake.modules.homeManager.cli = { pkgs, ... }: {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
    };
    home.packages = [
      # Terminal multiplexer
      pkgs.zellij
    ];
    # TODO: Integrate config-files for ghostty and zellij, when stable
    # xdg.configFile.ghostty = TODO;
    # xdg.configFile.zellij = TODO;
  };
}
