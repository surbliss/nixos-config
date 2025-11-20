{
  flake.modules.nixos.gui = {
    environment.sessionVariables = {
      # Better font rendering
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    };
  };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk11
        jetbrains.idea-community
        ant
      ];
      programs.eclipse.enable = true;
    };
}
