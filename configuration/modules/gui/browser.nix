{ config, ... }:
{
  flake.modules.nixos.gui =
    { pkgs, lib, ... }:
    let
      inherit (lib) mkDefault;
      custom = config.flake.packages.${pkgs.system};
    in
    {
      # Settings for chromium, doesn't install the package
      programs.chromium = {
        enable = true;
        extensions = [
          "epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock orign
        ];
        defaultSearchProviderEnabled = true;
        defaultSearchProviderSearchURL = "https://www.startpage.com/do/search?query=eurKey";
      };

      environment.systemPackages = with pkgs; [
        ungoogled-chromium
        custom.zen-browser-twilight
        qutebrowser
      ];

      xdg.mime = {
        enable = true;
        defaultApplications =
          let
            browser = [
              # Zen
              "zen-twilight.desktop" # Should be correct
              "zen_twilight.desktop"
              "zen.desktop"
              "zen-browser.desktop"
              # Firefox
              "firefox.desktop"
              "org.mozilla.firefox.desktop"
              "mozilla-firefox.desktop"
              "firefox-esr.desktop"
              "firefox-developer-edition.desktop"
              "firefox-nightly.desktop"
              # Chrome
              "chromium-browser.desktop"
              "chromium.desktop"
            ];
          in
          {
            "text/html" = browser;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/ftp" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/unknown" = browser;

            "application/pdf" = mkDefault browser;

            "video/mp4" = mkDefault browser;
            "video/webm" = mkDefault browser;
            "video/ogg" = mkDefault browser;
            "video/x-matroska" = mkDefault browser;
            "video/quicktime" = mkDefault browser;

            "image/jpeg" = mkDefault browser;
            "image/png" = mkDefault browser;
            "image/gif" = mkDefault browser;
            "image/svg+xml" = mkDefault browser;
            "image/webp" = mkDefault browser;
            "image/tiff" = mkDefault browser;
            "image/bmp" = mkDefault browser;
          };

      };

    };

  perSystem =
    { inputs', ... }:
    {
      packages.zen-browser-twilight = inputs'.zen-browser.packages.twilight;
    };

}
