{ pkgs, ... }:

let
  keyboard-remove = pkgs.writeShellScriptBin "keyboard-remove" ''
    # sleep 1
    KEYBOARDID=$(${pkgs.xorg.xinput}/bin/xinput list --id-only 'keyboard:AT Translated Set 2 keyboard')
    KANATAID=$(${pkgs.xorg.xinput}/bin/xinput list --id-only 'keyboard:kanata')
    echo $KEYBOARDID > $HOME/.keyboardid
    echo $KANATAID > $HOME/.kanataid
    ${pkgs.xorg.xinput}/bin/xinput float $KEYBOARDID
    ${pkgs.xorg.xinput}/bin/xinput float $KANATAID
  '';
  keyboard-add = pkgs.writeShellScriptBin "keyboard-add" ''
    # sleep 1
    # KEYBOARDID=$(${pkgs.xorg.xinput}/bin/xinput list --id-only 'AT Translated Set 2 keyboard')
    KEYBOARDID=$(cat $HOME/.keyboardid)
    KANATAID=$(cat $HOME/.kanataid)
    ${pkgs.xorg.xinput}/bin/xinput reattach $KEYBOARDID 3
    ${pkgs.xorg.xinput}/bin/xinput reattach $KANATAID 3
  '';
in
{
  # Alternative if many udev-rules: services.udev.packages
  environment.systemPackages = [
    keyboard-add
    keyboard-remove
  ];

  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1977", RUN+="${keyboard-remove}"
    ACTION=="remove", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1977", RUN+="${keyboard-add}"
  '';
}
