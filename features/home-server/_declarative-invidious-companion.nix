{
  perSystem =
    { pkgs, ... }:
    let
      version = pkgs.deno.version;
      denort = pkgs.stdenv.mkDerivation {
        pname = "denort";
        inherit version;

        nativeBuildInputs = with pkgs; [
          autoPatchelfHook
          unzip
        ];
        buildInputs = with pkgs; [ libgcc.lib ];

        src = pkgs.fetchurl {
          url = "https://dl.deno.land/release/v${version}/denort-x86_64-unknown-linux-gnu.zip";
          hash = "sha256-SrqlGhuewJd9O3zsVV7cYNMZiyeuG5eSodCYVhmUioQ=";
        };

        sourceRoot = ".";
        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          cp denort $out/bin
          runHook postInstall
        '';
      };
      companion-deps = pkgs.stdenv.mkDerivation {
        name = "companion-deps";
        src = pkgs.fetchFromGitHub {
          owner = "iv-org";
          repo = "invidious-companion";
          rev = "852f289";
          sha256 = "3Y+xCSiFeVyNymrLnypQqIIj1za4NEf/NeMnBmGEyBw=";
        };

        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = pkgs.lib.fakeSha256;

        buildInputs = [ pkgs.deno ];
        DENORT_BIN = "${denort}/bin/denort";

        installPhase = ''
          runHook preInstall
          export DENO_DIR=$out
          pwd; ls
          deno cache src/main.ts src/lib/helpers/youtubePlayerReq.ts src/lib/helpers/getFetchClient.ts --lock --frozen --vendor=true
          # --reload=https://esm.sh/@bufbuild/protobuf@2.0.0/denonext/wire.mjs
          rm $out/*cache_v2*
          runHook postInstall
        '';

      };
    in
    {
      packages.companion-deps = companion-deps;
    };
}
