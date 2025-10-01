{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nushell
    nufmt
    oh-my-posh # shell
  ];
}
