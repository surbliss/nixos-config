{ pkgs, config, ... }:
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
  #
  # environment.systemPackages = [ pkgs.canta-theme ];

  programs.regreet = {
    # theme = {
    #   package = pkgs.canta-theme;
    #   name = "Canta";
    # };
    # cursorTheme set in cursor module
    enable = true;
    settings.GTK.application_prefer_dark_theme = true;
  };

}
