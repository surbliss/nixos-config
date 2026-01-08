{
  flake.modules.homeManager.cli =
    { pkgs, ... }:
    {
      # julia (not bin) broken as of 2026/01/09
      home.packages = with pkgs; [ julia-bin ];
    };
}
