{ stdenv, lib, fetchurl, zlib, icu, autoPatchelfHook, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "bicep";
  version = "v0.16.2";

  src = fetchurl {
		url = "https://github.com/Azure/bicep/releases/download/${version}/bicep-linux-x64";
		sha256 = "sha256-3XVr0d5rSbV+GNWNqDNSowhoSuqgDgyhylldzi3d0OE=";
  };

	nativeBuildInputs = [ stdenv.cc.cc.lib zlib autoPatchelfHook makeWrapper icu ];

	dontStrip = true;
	phases = "installPhase fixupPhase";
	installPhase = let libraryPath = lib.makeLibraryPath [ icu ]; in ''
		runHook preInstall
		mkdir -p $out/bin
		cp $src $out/bin/bicep
		chmod +x $out/bin/bicep

		wrapProgram "$out/bin/bicep" \
			--prefix LD_LIBRARY_PATH : ${libraryPath}

		runHook postInstall
	'';
}
