{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # rocq-core
        (coq.withPackages (
          p: with p; [
            ssprove
            vscoq-language-server
          ]
        ))
      ];
    };
}
