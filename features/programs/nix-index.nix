{ inputs, ... }:
{
  flake.modules.homeManager.cli = {
    imports = [ inputs.nix-index-database.homeModules.default ];
    programs.nix-index = {
      enable = true;
      enableNushellIntegration = true;
    };
    programs.nix-index-database.comma.enable = true;
  };
}
