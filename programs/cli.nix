# Just return a list -- allows to pass them to home-manager for systems other
# than nixos
{ pkgs }:
### Terminal tools
## Idea: Config module, with 'packages' attribute!
with pkgs;
[
  git # Very important

  wget # Download stuff
  curl

  vim # Edit files
  ### Needed for neovim
  xclip # Manage clipboard
  xdotool
  ripgrep

  ## LSPs for neovim:

  harper

  lua-language-server
  stylua
  lua
  lua52Packages.tiktoken_core
  lynx

  ### Replaced by nixd
  # nil
  nixd
  nixfmt-rfc-style
  # For copilot
  luajitPackages.tiktoken_core

  ### To fix haskell-lsp for xmonad
  haskellPackages.fourmolu
  haskellPackages.hoogle
  haskellPackages.haskell-language-server

  # ccls
  clang-tools_19 # clangd + clang-format
  clang

  ltex-ls
  bash-language-server

  zoxide
  eza
  # nix-search-cli # Search nixpkgs

  # neofetch
  trash-cli
  fzf
  bc
  htop

  # cowsay

  zip
  unzip

  ### Not needed (should just be run with 'nix run' instead)
  # xcolor
  # killall
  # file

  xorg.xev
  xorg.xkill
  xorg.xprop

  texlive.combined.scheme-full

  time # time programs

  ### Programming languages and tools
  # C + RISC-V
  gcc14
  gnumake
  valgrind
  rars
  # jdk

  ### Nix helpers
  nix-prefetch
  nix-prefetch-git
  nix-prefetch-github

  mermaid-cli

  # Instead of cat
  bat

  # Get wifi-name (iwgetid -r)
  wirelesstools

]

# Might be useful later
### Citations
# zotero

### Don't think these are needed anymore
# SDL2
# SDL2_ttf
# SDL2_image
# SDL2_net
# SDL2_Pango
# SDL2_gfx
# SDL2_mixer
# SDL2_sound
# gtk3
