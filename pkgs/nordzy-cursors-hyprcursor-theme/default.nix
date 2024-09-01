{ stdenvNoCC
, fetchgit
, lib
}:
stdenvNoCC.mkDerivation {
  pname = "nordzy-cursors-hyprcursor-theme";
  version = "1.0.0";
  src = fetchgit {
    url = "https://github.com/guillaumeboehm/Nordzy-cursors-hyprcursor";
    rev = "refs/tags/1.0.0";
    sparseCheckout = [ "themes" ];
    fetchSubmodules = true;
    hash = "sha256-NFxR0bQqZGDeiXxayKkC+g5l7WYe7ixgd7Pzj8IB3hM=";
  };
  installPhase = ''
    mkdir -p $out/share/icons
    for theme in themes/*
    do
      cp -r ''$theme $out/share/icons
    done
  '';

  meta = with lib; {
    description = "Cursor theme using the Nord color palette and based on Vimix and cz-Viator";
    homepage = "https://github.com/guillaumeboehm/Nordzy-cursors-hyprcursor";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
