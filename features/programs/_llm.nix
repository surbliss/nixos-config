{
  flake.modules.homeManager.cli = {
    ### Manage Gemini-cli through home manager instead of symlinking a
    # config file, to avoid issues of managing credentials or private info
    programs.gemini-cli = {
      enable = true;
      settings = {
        ### Remove data-collection
        privacy.usageStatisticsEnabled = false;
        telemetry.enabled = false;
      };
      # TODO: Add custom prompts/commands below
    };
  };
}
