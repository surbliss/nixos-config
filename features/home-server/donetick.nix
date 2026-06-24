{ inputs, self, ... }: {
  flake.modules.nixos.home-server =
    { config, ... }:
    let
      inherit (config.age) secrets;
      donetick-pkg = inputs.donetick;
    in
    {
      systemd.services.donetick = {
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        description = "Donetick is an open-source, user-friendly app designed to help you organize tasks and chores effectively. featuring customizable options to help you and others stay organized";
        restartTriggers = [
          (builtins.hashFile "sha256" "${self}/configuration/secrets/DONETICK_ENV.age")
        ];
        environment = {
          DT_ENV = "selfhosted";
          DT_OAUTH2_CLIENT_ID = "c3783228-eeff-4e11-ab23-6e549d67d03f";
          DT_OAUTH2_REDIRECT_URL = "https://server-surface.quagga-toad.ts.net:2022/auth/oauth2";
          DT_OAUTH2_AUTH_URL = "https://server-surface.quagga-toad.ts.net:1412/authorize";
          DT_OAUTH2_TOKEN_URL = "https://server-surface.quagga-toad.ts.net:1412/api/oidc/token";
          DT_OAUTH2_USER_INFO_URL = "https://server-surface.quagga-toad.ts.net:1412/api/oidc/userinfo";
          DT_OAUTH2_NAME = "PocketID";
          DT_SQLITE_PATH = "/var/lib/donetick/donetick.db";

        };
        serviceConfig = {
          Type = "simple";
          DynamicUser = true;
          WorkingDirectory = "${donetick-pkg}";
          StateDirectory = "donetick";
          ExecStart = "${donetick-pkg}/donetick";
          Restart = "always";
          # Sets DT_JWT_SECRET and DT_OAUTH2_CLIENT_SECRET
          EnvironmentFile = secrets.DONETICK_ENV.path;
        };
      };

      services.caddy.virtualHosts."server-surface.quagga-toad.ts.net:2022".extraConfig =
        ''
          reverse_proxy localhost:2021
        '';

      preservation.preserveAt."/persistent" = {
        directories = [ "/var/lib/private/donetick" ];
      };
    };
}
