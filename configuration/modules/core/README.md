# Core
These are the configuration-files which _depend_ on the modules defined, and require them to function. E.g.:

- Setting up the flake-parts module system
- Declaring host-configurations (and modules they use)
- Declaring allowed unfree packages

Essentially, anything that doesn't go in `flake.modules.<class>.<module>` or `perSystem` goes in `core`.
