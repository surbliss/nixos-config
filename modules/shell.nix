# { config, ... }:
{
  flake.modules.nixos.shell =
    { pkgs, ... }:
    # let
    #   custom = config.flake.packages.${pkgs.system};
    # in
    {
      users.defaultUserShell = pkgs.nushell;
      # Name definitions should probably be done somewhere else?
      users.users.angryluck.shell = pkgs.nushell;

      programs.zsh.enable = true;

      environment.systemPackages = with pkgs; [
        nushell
        zoxide # Better cd
        # nufmt # Broken af, maybe later?

        git # Needed for zinit plugin-manager
        zoxide # Better cd
        eza # Better ls
        starship
        # custom.starship-jj
        # inputs.starship-jj.packages.${pkgs.system}.default
        oh-my-posh # Todo: Replace starship prompt by oh-my-posh
      ];
    };
  # perSystem =
  #   { inputs', ... }:
  #   {
  #     packages.starship-jj = inputs'.starship-jj.packages.default;
  #   };
}
