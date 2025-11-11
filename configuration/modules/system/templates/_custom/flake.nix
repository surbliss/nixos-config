{
  description = "Custom flake for templates";

  outputs =
    { self }:
    {
      templates.minimal = {
        path = ./minimal;
        description = "Minamal dev-shell";
        welcomeText = ''
          Personal minamal dev-shell
          ==========================
          - Remember to run `direnv allow`.
          - Edit default.nix to add packages.
          - Make jj repo with `jj git init`
        '';
      };

      templates.default = self.templates.minimal;
    };
}
