### Packages for fun, which are not needed.
{
  pkgs,
  ...
}:
{
  # home.packages = builtins.attrValues {
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      hello
      neofetch
      cowsay
      ;

    inherit (pkgs.haskellPackages)
      misfortune
      ;
  };
}
