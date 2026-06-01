# Helpful shorthands for nixos configuration
default:
    just --list


switch:
    sudo nixos-rebuild switch

test:
    sudo nixos-rebuild test


update:
    nix flake update


clean:
    sudo nix-collect-garbage --delete-older-than 14d

fmt:
    nix fmt

# Query for a list of mime/types, for setting new defaults.
# Combine with grep to find
mime:
    fd -H -L --color always -e desktop . /run/current-system/ ~/.nix-profile

home:
    home-manager switch
    # If not linked yet:
    # home-manager switch --flake .

pwd:
    echo {{justfile_directory()}}


install host:
    sudo nixos-rebuild switch --flake .#{{host}} --option experimental-features "nix-command flakes pipe-operators"
# Links entire directory, so no need to rerun when adding new files
link: link-home link-system link-dotfiles

# Both below use "" in case path contains folder with spaces in it

# Make sure ~/.config/home-manager does not exist first!
# Don't use if home-manager is installed as NixOS module
link-home:
    ln -s "{{justfile_directory()}}" ~/.config/home-manager

# Make sure /etc/nixos does not exist first!
link-system:
    sudo ln -s "{{justfile_directory()}}" /etc/nixos

link-dotfiles:
    ln -s "{{justfile_directory()}}/dotfiles" ~/.dotfiles

features:
    hx features/

feat: features

configuration:
    hx configuration/

conf: configuration

# NOTE: No sudo on the command itself, only remotely
server-surface-kbh:
    nixos-rebuild switch --flake .#server-surface --target-host angryluck@192.168.0.247 --ask-sudo-password

server-surface-thi:
    nixos-rebuild switch --flake .#server-surface --target-host angryluck@192.168.8.4 --ask-sudo-password


test-server-surface-kbh:
    nixos-rebuild test --flake .#server-surface --target-host angryluck@192.168.0.247 --ask-sudo-password

test-server-surface-thi:
    nixos-rebuild test --flake .#server-surface --target-host angryluck@192.168.8.4 --ask-sudo-password

server: server-surface-thi

test-server: test-server-surface-thi

check:
    nix flake check

[working-directory: "./configuration/secrets"]
rekey:
    agenix -r
