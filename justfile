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
    fd --color always -e desktop . /run/current-system/sw/share/applications/ ~/.nix-profile/share/applications/

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

server:
    sudo nixos-rebuild switch --target angryluck@192.168.0.247
