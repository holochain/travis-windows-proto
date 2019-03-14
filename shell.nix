let
 nixpkgs = import <nixpkgs> {};
in
with nixpkgs;
stdenv.mkDerivation rec {
 name = "travis-windows-proto";

 buildInputs = [
  travis
 ];
}
