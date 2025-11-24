{ lib, ... }:
let
  mkHost =
    {
      hostname,
      hostSystem,
      moduleList,
      unfreePackages,
    }:
    { };

  # helper-function to retrieve modules, given string list
  getModules =
    cont: moduleList:
    moduleList
    |> map (name: cont.${name} or null)
    |> builtins.filter (m: m != null);

  hostConfig =
    { hostname, unfreePackages }:
    {

      # Make sure to name hardware-config correctly!
      imports = [ _generated-hardware-configs/${hostname}.nix ];
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      nixpkgs.config.allowUnfreePredicate =
        pkgName: builtins.elem (lib.getName pkgName) unfreePackages;
      networking.hostName = hostname;
    };

in
# Configurations for each host
[
  {
    hostname = "asus21";
    hostSystem = "x86_64-linux";
    moduleList = [
      "asus21"
      "angryluck"
      "cli"
      "desktop"
      "gui"
      "gaming"
      "system"
      "fonts"
    ];
  }
]
|> map mkHost
|> lib.attrsets.mergeAttrsList
