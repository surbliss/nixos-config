{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      # Better discord client
      programs.vesktop.enable = true;
      home.packages = with pkgs; [
        teams-for-linux
        discord # Only for backup, if vesktop doesn't work
        zoom-us
        ### FIX: Depends on EOL Electron 39
        # zulip

        # dorion # Broken, white page half the time
      ];
    };
}
