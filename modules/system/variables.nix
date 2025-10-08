{
  flake.modules.nixos.variables =
    { pkgs, ... }:
    {
      ### Should just be put in the relevant file, not globally...
      environment.sessionVariables = {
        #   # For jEdit to work! (Isabelle)
        _JAVA_AWT_WM_NONREPARENTING = 1;
        DOTNET_CLI_TELEMETRY_OPTOUT = 1;

        ### Idk why this is needed, rip
        JAVA_HOME = "${pkgs.jdk}";
      };

    };
}
