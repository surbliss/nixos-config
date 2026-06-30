{ pkgs, ... }: {
  devshells.default = {
    packages = with pkgs; [ hello ];

    env = [
      {
        name = "IS_NIX_SHELL";
        value = true;
      }
    ];

    commands = [
      {
        name = "hello";
        help = "Print hello";
        command = "echo hello";
      }
    ];
  };
}
