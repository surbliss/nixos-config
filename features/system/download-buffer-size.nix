let
  size = 524288000;
in
{
  # After warning about too small buffer size -- increase it to 500 MB.
  # See https://github.com/NixOS/nix/issues/11728

  flake.modules.nixos.system = {
    nix.settings.download-buffer-size = size;
  };
  # NOTE: Don't set this in home-manager: You will get spammed direnv warnings about the option being ignored, as you are a restricted user
}
