{ moduleWithSystem, ... }:
let
  module =
    { self', ... }: # perSystem
    { pkgs, lib, ... }:
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
        self'.packages.zen-browser-twilight
        qutebrowser
      ];

      xdg.mime = {
        enable = true;
        defaultApplications =
          let
            inherit (lib) mkDefault;
            browser = [
              # Zen
              "zen-twilight.desktop" # Should be the correct version
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

            # mkDefault, as there might be better candidates
            # mkForce does not work for mime-types
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
in
{
  flake.modules.nixos.gui = moduleWithSystem module;

  perSystem =
    { inputs', ... }:
    {
      packages.zen-browser-twilight = inputs'.zen-browser.packages.twilight;
    };

}
