let
  # Same as default dataDir, put here for documentation purposes
  memos-data-dir = "/var/lib/memos/";
in
{
  # Memos: App to make simple, quick, temporary notes
  flake.modules.nixos.home-server = {
    services.memos.enable = true;
    # BUG: This setting refers to non-existent 'services.memos.port' setting
    # services.memos.openFirewall = true;

    services.memos.dataDir = memos-data-dir;

    # WARN: For some reason this does not merge properly, so set all the options!
    services.memos.settings = {
      MEMOS_MODE = "prod";
      MEMOS_ADDR = "0.0.0.0";
      MEMOS_PORT = "5230";
      MEMOS_DATA = memos-data-dir;
      MEMOS_DRIVER = "sqlite";
      MEMOS_INSTANCE_URL = "http://localhost:5230";
    };

    networking.firewall.allowedTCPPorts = [ 5230 ];
    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = memos-data-dir;
          # Same permission and groups as the services.memos module sets. To ensure the persisted directory is created with the correct owner and permissions.
          mode = "750";
          user = "memos";
          group = "memos";
        }
      ];
    };
  };
}
