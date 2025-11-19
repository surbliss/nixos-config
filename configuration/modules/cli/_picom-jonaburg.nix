{
  lib,
  stdenv,
  fetchFromGitHub,
  asciidoctor,
  asciidoc,
  docbook_xml_dtd_45,
  docbook_xsl,
  makeWrapper,
  meson,
  ninja,
  pkg-config,
  pcre,
  dbus,
  libconfig,
  libdrm,
  libev,
  libGL,
  libepoxy,
  libxdg_basedir,
  libxml2,
  libxslt,
  pcre2,
  pixman,
  uthash,
  xorg,
}:
stdenv.mkDerivation {
  # MUST be run with --experimental-backend(s)
  pname = "picom-jonaburg";
  version = "8";

  meta =
    ### Good syntax for something static like this, bad for packages that
    ### change a lot
    let
      inherit (lib.platforms) linux;
      inherit (lib.licenses) mpl20 mit;
    in
    {
      description = "A compositor for X11 (fork of picom with animation support)";
      homepage = "https://github.com/jonaburg/picom";
      license = [
        mpl20
        mit
      ];
      platforms = linux;
    };

  src = fetchFromGitHub {
    owner = "jonaburg";
    repo = "picom";
    rev = "65ad706ab8e1d1a8f302624039431950f6d4fb89";
    hash = "sha256-UKqMHUP6X3exG7obhuRPgXWPmwBeaGaqNYNtcBcimNQ=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    asciidoctor
    asciidoc # Program a2x missing
    docbook_xml_dtd_45
    docbook_xsl
    makeWrapper
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    pcre.dev # libpcre missing error
    dbus
    libconfig
    libdrm
    libev
    libGL
    libepoxy
    xorg.libX11
    xorg.libxcb
    libxdg_basedir
    xorg.libXext
    libxml2
    libxslt
    pcre2
    pixman
    uthash
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilrenderutil
    xorg.xorgproto
  ];

  mesonFlags = [ "-Dwith_docs=true" ];
}
