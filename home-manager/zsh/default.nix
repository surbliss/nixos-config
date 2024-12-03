{ pkgs, ... }:
{
  programs = {
    # Jump directly to directory, without writing entire path
    zoxide = {
      enable = true;
      options = [ "--cmd j" ];
    };

    eza = {
      enable = true;
      icons = "auto";
      git = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        AOCD_DIR = "~/aocd/";
      };
      shellAliases = {
        # ls = "ls --color --group-directories-first -F";
        ls = "eza --group-directories-first";
        l = "eza -l --total-size --no-permissions -h";
        cp = "cp -i"; # Interactive
        df = "df -h";
        free = "free -m";
        bc = "bc -l";
        hms = "home-manager switch --flake /etc/nixos"; # opt: #angryluck
        hm = "home-manager --flake /etc/nixos"; # opt: #angryluck
        sudo = "sudo ";
        nrs = "nixos-rebuild switch";
        nrt = "nixos-rebuild test";
        polybar-refresh = "pkill polybar; polybar -c ~/.config/home-manager/polybar/config.ini default&; disown";
      };
      # autocd = true;
      dotDir = ".config/zsh";
      plugins = [
        {
          name = "vi-mode"; # Improved vi-mode
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        # {
        #   # will source zsh-autosuggestions.plugin.zsh
        #   name = "manydots-magic";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "knu";
        #     repo = "zsh-manydots-magic";
        #   };
        # }
      ];
      initExtra = "${builtins.readFile ./zshrc}";
    };
  };
}
