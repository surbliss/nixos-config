{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      # terminal.vt = 2;
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
    useTextGreeter = true;
  };

}
