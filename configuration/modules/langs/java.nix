{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.idea-ultimate
        ant
        jdt-language-server
      ];
      home.sessionVariables = {
        # NOTE: Intellij complains about setting Java environment variables,
        # e.g. _JAVA_OPTIONS.

        # For jEdit to work! (Isabelle) (So should be set there...)
        _JAVA_AWT_WM_NONREPARENTING = 1;
      };
      programs.eclipse.enable = true;
      programs.java = {
        enable = true;
        package = pkgs.jdk11;
      };
    };
}
