{ moduleWithSystem, lib, ... }:
let
  inherit (lib) mkDefault;
  browserMimes = [
    "helium.desktop"
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
  browserModule = { self', ... }: # perSystem
  { pkgs, ... }: {
    # Settings for chromium, doesn't install the package
    programs.chromium = {
      enable = true;
      extensions = [
        "epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock orign
      ];
    };

    # MAYBE: programs.firefox.enable, consider:
    home.packages = with pkgs; [
      self'.packages.zen-browser-twilight
      self'.packages.helium
      qutebrowser
      nyxt
    ];

    xdg.mime.enable = true;
    xdg.mimeApps.defaultApplications = {
      "text/html" = browserMimes;
      "x-scheme-handler/http" = browserMimes;
      "x-scheme-handler/ftp" = browserMimes;
      "x-scheme-handler/https" = browserMimes;
      "x-scheme-handler/about" = browserMimes;
      "x-scheme-handler/unknown" = browserMimes;

      "application/pdf" = mkDefault browserMimes;

      # mkDefault, as there might be better candidates
      # mkForce does not work for mime-types
      "video/mp4" = mkDefault browserMimes;
      "video/webm" = mkDefault browserMimes;
      "video/ogg" = mkDefault browserMimes;
      "video/x-matroska" = mkDefault browserMimes;
      "video/quicktime" = mkDefault browserMimes;

      "image/jpeg" = mkDefault browserMimes;
      "image/png" = mkDefault browserMimes;
      "image/gif" = mkDefault browserMimes;
      "image/svg+xml" = mkDefault browserMimes;
      "image/webp" = mkDefault browserMimes;
      "image/tiff" = mkDefault browserMimes;
      "image/bmp" = mkDefault browserMimes;
    };

  };

in
{

  flake.modules.homeManager.gui = moduleWithSystem browserModule;
  perSystem = { inputs', ... }: {
    packages.zen-browser-twilight = inputs'.zen-browser.packages.twilight;
    packages.helium = inputs'.helium.packages.default;
  };

}
