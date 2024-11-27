# Home Manager dotfiles
*My personal Home Manger configuration for use on NixOS*
## Cautions:
1. Make sure to modify the `system = "x86_64-linux";` in `flake.nix` to match the
   actual architecture
2. XMonad configuration is in this repository, but xmonad is not started nor
   installed by Home Manager - do this in `configuration.nix` instead.

## TODOS:
- [ ] Merge with the system-configuration (`/etc/nixos/`)
