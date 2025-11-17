{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        eclipses.eclipse-java
        jdk
      ];
      environment.sessionVariables = {
        # Better font rendering
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      };
    };
}
