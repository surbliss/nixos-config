# Helpful shorthands for nixos configuration


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
