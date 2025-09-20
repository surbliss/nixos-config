{ pkgs, ... }:
{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = ''
  #         ${pkgs.tuigreet}/bin/tuigreet \
  #         --time \
  #         --remember \
  #         --cmd niri-session \
  #         --asterisks \
  #         --theme border=magenta;text=cyan;prompt=magenta;time=green;action=blue;button=yellow;container=black;input=white \
  #       '';
  #       user = "greeter";
  #     };
  #   };
  #   useTextGreeter = true;
  # };

  programs.regreet.enable = true;

}
