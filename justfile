# Helpful shorthands for nixos configuration
default: switch home


switch:
    sudo nixos-rebuild switch

test:
    sudo nixos-rebuild test


update:
    nix flake update


clean:
    sudo nix-collect-garbage --delete-older-than 14w

fmt:
    nix fmt

# Query for a list of mime/types, for setting new defaults.
# Combine with grep to find
mime:
    fd -e desktop . /run/current-system/sw/share/applications/

home:
    home-manager switch
    # If not linked yet:
    # home-manager switch --flake .

pwd:
    echo {{justfile_directory()}}


link: link-home link-system link-dotfiles

# Both below use "" in case path contains folder with spaces in it

# Make sure ~/.config/home-manager does not exist first!
link-home:
    ln -s "{{justfile_directory()}}" ~/.config/home-manager

# Make sure /etc/nixos does not exist first!
link-system:
    sudo ln -s "{{justfile_directory()}}" /etc/nixos

link-dotfiles:
    ln -s "{{justfile_directory()}}/dotfiles" ~/.dotfiles
