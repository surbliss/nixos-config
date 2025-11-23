{
  # Should definitely be moved to the place they relate to (dotnet + Isabelle)
  flake.modules.nixos.system = {
    ### Should just be put in the relevant file, not globally...
    environment.sessionVariables = {
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };

  };
}
