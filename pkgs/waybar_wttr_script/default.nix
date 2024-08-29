{ pkgs ? import (fetchTarball {
  name = "nixpkgs-unstable-a6292e34000dc93d43bccf78338770c1c5ec8a99";
  url = "https://github.com/NixOS/nixpkgs/archive/a6292e34000dc93d43bccf78338770c1c5ec8a99.tar.gz";
  sha256 = "14zcfxizxjmvqxywaljpa716ig6j7ndymfys51fzs8c0iw1lcnin";
})  {}, lib ? pkgs.lib, stdenv ? pkgs.stdenv, ...}:
with pkgs;
stdenv.mkDerivation {
  name = "waybar_wttr_script";
  buildInputs = [ (pkgs.python3.withPackages (p: [ p.requests ])) ];
  unpackPhase = ":";
  installPhase = "install -m755 -D ${./wttr.py} $out/bin/wttr";
}
