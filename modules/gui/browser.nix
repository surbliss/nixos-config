{ config, ... }:
{
  flake.modules.nixos.gui =
    { pkgs, ... }:
    let
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

    };

  perSystem =
    { inputs', ... }:
    {
      packages.zen-browser-twilight = inputs'.zen-browser.packages.twilight;
    };

}
