{
  # flake.modules.nixos.gui = {
  #   environment.sessionVariables = {
  # Better font rendering
  # BUT: Intellij complains about these...
  # _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  #   };
  # };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk15
        jetbrains.idea-community
        ant
      ];
      home.sessionVariables = {
        #   # For jEdit to work! (Isabelle) (So should be set there...)
        _JAVA_AWT_WM_NONREPARENTING = 1;
        ### Idk why this is needed, rip. remove for now
        # JAVA_HOME = "${pkgs.jdk}";

      };
      programs.eclipse.enable = true;
    };
}
