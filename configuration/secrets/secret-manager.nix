{ inputs, moduleWithSystem, ... }: {
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
      POCKET_ID_ENCRYPTION_KEY.file = ./POCKET_ID_ENCRYPTION_KEY.age;
      VIKUNJA_ENV.file = ./VIKUNJA_ENV.age;
      PAPERLESS_ENV.file = ./PAPERLESS_ENV.age;
      TRILIUM_ENV.file = ./TRILIUM_ENV.age;
      DONETICK_ENV.file = ./DONETICK_ENV.age;
    };
  };

  flake.modules.homeManager.default = moduleWithSystem (
    { inputs', ... }: { ... }: {
      imports = [ inputs.agenix.homeManagerModules.default ];
      home.packages = [ inputs'.agenix.packages.default ];
      # No user-specific secrets yet
    }
  );
}
