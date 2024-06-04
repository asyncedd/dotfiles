{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "NewYork";
  version = "1.0";

  src = ./assets/NewYork.ttf;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype

    runHook postInstall
  '';
}
