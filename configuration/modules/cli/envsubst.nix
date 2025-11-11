{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.envsubst ];
    };
}
