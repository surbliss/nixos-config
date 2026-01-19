{
  description = "Custom flake for templates";

  outputs =
    { self }:
    {
      templates.minimal = {
        path = ./minimal;
        description = "Minimal development shell";
        welcomeText = ''
          Minimal development shell
          ==========================
          1. Add packages to default.nix
          2. Run `direnv allow` for automatic shell-entering
        '';
      };

      templates.default = self.templates.minimal;
    };
}
