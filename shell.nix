{
  pkgs ? import ./nix/nixpkgs/default.nix {}
}:

with pkgs;

stdenv.mkDerivation {
  name = "myenv";
  buildInputs = [ yarn purescript psc-package ];
}
