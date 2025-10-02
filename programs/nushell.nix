{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nushell
    zoxide # Better cd
    # nufmt # Broken af, maybe later?
    oh-my-posh # prompt
  ];
}
