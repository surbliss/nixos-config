### Helpful shorthands for nixos configuration
# NOTE: These commands require that `nh` is installed/enabled!
server := "angryluck@server-surface"

# List available recipes
[group("Info")]
list:
    # TODO: When updated to version 1.52.0: Replace `list` recipe with
    # set default-list := true
    just --list

[group("Installation")]
switch:
    nh os switch .

[group("Installation")]
test:
    nh os test .

[group("Installation")]
update:
    nix flake update # Updates `flake.lock` with newest package-versions

# Reinstall with updated packages on main machine (not server, do that manually)
[group("Installation")]
upgrade:
    nh os switch . --update

# Rebuild server
[group("Installation")]
server-switch:
    # Uses tailscale MagicDns to pick the correct device
    nh os switch .  --hostname server-surface --target-host {{ server }} --build-host {{ server }}

# Test rebuild on server
[group("Installation")]
server-test:
    # Uses tailscale MagicDns to pick the correct device
    nh os test .  --hostname server-surface --target-host {{ server }} --build-host {{ server }}

# Preserves _last 5 generations_ and _any generations from last 14 days_, and then performs garbage collection on the rest.
# But, since automatic garbage collect is enabled, this command should be redundant
[confirm("This will delete any generations before last 5, which are older than 14 days. Continue?")]
[group("Installation")]
clean:
    nh clean all --keep 5 --keep-since 14d

# Format _all_ code
[group("Edit")]
fmt:
    nix fmt

# Query for a list of mime/types, for setting new defaults.
# Combine with grep to find
[group("Info")]
mime:
    fd -H -L --color always -e desktop . /run/current-system/ ~/.nix-profile

# First-time installation, pass host-name as argument
# Also, remember to delete `/etc/nixos` afterwards!
[group("Installation")]
install host:
    sudo nixos-rebuild switch --flake .#{{ host }} --option experimental-features "nix-command flakes pipe-operators"

# Link dotfiles to ./dotfiles.
# Required for `mkOutOfStoreSymlink` alias used in configuration
[group("Installation")]
link-dotfiles:
    # -s = Symbolic link instead of hard link
    # -f = force (overwrite) any files. So, any file with name `.dotfiles` will be overwritten, but not an non-empty folder `.dotfiles/`
    # -n = When target is a symlink pointing to a directory, treat this symlink as a file instead of a folder to follow. Allows the target to be overwritten by the -f flag.
    # Together: Overwrite files/symlinks at the target location (not non-emtpy actual folders)
    ln -sfn "{{ justfile_directory() }}/dotfiles" ~/.dotfiles

alias feat := features
[group("Edit")]
features:
    hx features/

alias conf := configuration
[group("Edit")]
configuration:
    hx configuration/

# Check if flake-config is error-free
[group("Info")]
check:
    nix flake check

# Rekey encrypted secrets
[group("Edit")]
[working-directory("./configuration/secrets")]
rekey:
    agenix -r

# Shows what is taking up space.
# Use before garbage-cleaning
[group("Info")]
why-full:
    nix-store --gc --print-roots | sort

[group("Info")]
preview-clean:
    nh clean all --keep 5 --keep-since 14d --dry
