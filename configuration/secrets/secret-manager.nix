{ inputs, moduleWithSystem, ... }:
{
  # agenix as secret-manager
  flake.modules.nixos.default = {
    imports = [ inputs.agenix.nixosModules.default ];

    age.secrets = {
      KU_PASSWORD.file = ./KU_PASSWORD.age;
      KU_MAIL.file = ./KU_MAIL.age;
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
