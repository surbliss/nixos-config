{
  # treefmt config, run with `nix run .#formatter`
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-tree.override {
        settings = {
          formatter.nixfmt = {
            options = [
              "--width=80"
              "--strict"
              "--verify"
            ];
          };
        };
      };
    };
}
