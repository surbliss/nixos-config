{
  description = "Custom flake for templates";

  outputs = { self }: {
    templates.minimal = {
      path = ./minimal;
      description = "Minimal development shell";
      welcomeText = ''
        Minimal development shell
        ==========================
        1. Add packages to shell.nix
        2. Create an .envrc file containing "use flake" and run `direnv allow` for automatic shell-entering
      '';
    };
    templates.haskell = {
      path = ./haskell;
      description = "Haskell flake";
      welcomeText = ''
        Minimal development shell
        ==========================
        1. Add packages to shell.nix
        2. Create an .envrc file containing "use flake" and run `direnv allow` for automatic shell-entering
        3. Edit/rename the .cabal file for the project
      '';
    };

    templates.default = self.templates.minimal;
  };
}
