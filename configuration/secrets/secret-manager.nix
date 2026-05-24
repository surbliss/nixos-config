{ inputs, moduleWithSystem, ... }:
{
  # agenix as secret-manager
  flake.modules.nixos.default = {
    imports = [ inputs.agenix.nixosModules.default ];

    age.secrets = {
      KU_PASSWORD.file = ./KU_PASSWORD.age;
      KU_MAIL.file = ./KU_MAIL.age;
      # Rememeber to set 'owner = "invidious"' in module using these;
      INVIDIOUS_SETTINGS.file = ./INVIDIOUS_SETTINGS.age;
      INVIDIOUS_COMPANION_ENV.file = ./INVIDIOUS_COMPANION_ENV.age;
      KITCHENOWL_ENV.file = ./KITCHENOWL_ENV.age;
    };
  };

  flake.modules.homeManager.default = moduleWithSystem (
    { inputs', ... }:
    { ... }:
    {
      imports = [ inputs.agenix.homeManagerModules.default ];
      home.packages = [ inputs'.agenix.packages.default ];
      # No user-specific secrets yet
    }
  );
}
