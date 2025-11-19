{
  # treefmt config, run with `nix run .#formatter`
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-tree.override {
        settings = {
          # on-unmatched = "info";

          # Configure nixfmt for .nix files
          formatter.nixfmt = {
            # command = "nixfmt";
            # includes = [ "*.nix" ];
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

#   settings = { /* additional treefmt config */ };
#   runtimeInputs = [ /* additional formatter packages */ ];
# }

#       pkgs.treefmt.withConfig {
#         runtimeInputs = [ pkgs.nixfmt-rfc-style ];

#         settings = {
#           # Log level for files treefmt won't format
#           on-unmatched = "info";

#           # Configure nixfmt for .nix files
#           formatter.nixfmt = {
#             command = "nixfmt";
#             includes = [ "*.nix" ];
#             options = [
#               "--width=80"
#               "--strict"
#               "--verify"
#             ];
#           };
#         };
#       };
#     };
# }
