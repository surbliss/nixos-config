# Modules
## Philosophy
Every file in `modules/` is a stand-alone file that can work on its own.
That is, no file in `modules/` is allowed to depend on another file in `modules/`.
Top-level functionality that all modules are allowed to depend on and utilize is defined in the `configuration/` folder.

## Module-groupings:
`desktop/`: Desktop configuration, including UI, window-manager, cursor, ui-services, etc. Could consider combining this with `system/` (but keep the flake-parts desktop/system split)
`system/`: Core system configuration, like audio, udev-rules, inputs, core services, etc.
`programs/`: Any applications that can be run, either cli tools or GUI applications.
  Includes `tools/` for background-stuff other programs might rely on, and `langs/` for programming-language installations.



## Specialized packages
To define custom packages (say, through some flake input), add a `perSystem` attribute to the file. As an example:
```nix
perSystem =
  { inputs', ... }:
  {
    packages.zen-browser-twilight = inputs'.zen-browser.packages.twilight;
  };
```
Here, `inputs'` is the `inputs` of the flake, with the given system preselected.
So, the above expands to
```nix
inputs.zen-browser.packages.<system>.twilight
```
To access _flake_ parameters with system selected, use `self'`.


## Referencing specialized packages
Use `moduleWithSystem`, which adds an extra parameter to a module function, consisting of `perSystem` parameters.
For example,
```nix
flake.modules.nixos.gui = moduleWithSystem (
  { self', ... }: # perSystem
  { pkgs, lib, ... }:
  {
    ...
  }
```
The second parameter consists of standard module-args, while the first can contain any `perSystem` arg (see [flake.parts/module-arguments](https://flake.parts/module-arguments.html)).
Thus, `self'` or `config` can be used to access custom packages, with system pre-selected (as above).

_NOTE:_ For the most part `self'` and `config` can be used interchangeably, when accessing pre-defined fields such as `packages`.
I choose the convention to use `self'` where possible, as is stated on [flake.parts/cheat-sheet](https://flake.parts/cheat-sheet):
  > The self' parameter is derived from the flake self, which may benefit from evaluation caching in the future.

