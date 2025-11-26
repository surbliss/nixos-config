{ moduleWithSystem, ... }:
let
  java-module =
    # { self', ... }:
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk11
        # self'.packages.jdk15
        jetbrains.idea-ultimate
        ant
      ];
      home.sessionVariables = {
        # NOTE: Intellij complains about setting Java environment variables,
        # e.g. _JAVA_OPTIONS.

        # For jEdit to work! (Isabelle) (So should be set there...)
        _JAVA_AWT_WM_NONREPARENTING = 1;
      };
      programs.eclipse.enable = true;
    };

  jdk-15-package =
    {
      stdenv,
      fetchurl,
      autoPatchelfHook,
      makeWrapper,
      alsa-lib,
      freetype,
      fontconfig,
      xorg,
      zlib,
      cups,
    }:
    stdenv.mkDerivation rec {
      pname = "openjdk";
      version = "15.0.2";
      src = fetchurl {
        url = "https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz";
        sha256 = "91ac6fc353b6bf39d995572b700e37a20e119a87034eeb939a6f24356fbcd207";
      };
      nativeBuildInputs = [
        autoPatchelfHook
        makeWrapper
      ];
      buildInputs = [
        alsa-lib
        freetype
        fontconfig
        xorg.libX11
        xorg.libXext
        xorg.libXi
        xorg.libXrender
        xorg.libXtst
        zlib
        cups
      ];
      sourceRoot = ".";

      # postPatch = ''
      #   chmod +x configure
      #   patchShebangs --build configure
      # '';

      installPhase = ''
        mkdir -p $out/lib/openjdk
        cp -r jdk-${version}/* $out/lib/openjdk
      '';
      preFixup =
        # Set JAVA_HOME automatically.
        ''
          mkdir -p $out/nix-support
          cat <<EOF > $out/nix-support/setup-hook
          if [ -z "\''${JAVA_HOME-}" ]; then export JAVA_HOME=$out/lib/openjdk; fi
          EOF
        '';

      postFixup = ''
        autoPatchelf -- $out
      '';
      dontStrip = 1;
      meta = {
        description = "OpenJDK 15";
        platforms = [ "x86_64-linux" ];
      };
    };
in
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk11
        # self'.packages.jdk15
        jetbrains.idea-ultimate
        ant
      ];
      home.sessionVariables = {
        # NOTE: Intellij complains about setting Java environment variables,
        # e.g. _JAVA_OPTIONS.

        # For jEdit to work! (Isabelle) (So should be set there...)
        _JAVA_AWT_WM_NONREPARENTING = 1;
        JAVA_HOME = "${pkgs.jdk11}";
      };
      programs.eclipse.enable = true;
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.jdk15 = pkgs.callPackage jdk-15-package { };
    };
}
