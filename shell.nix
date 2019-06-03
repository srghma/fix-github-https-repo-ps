{
  pkgs ? import ./nix/pkgs.nix
}:

with pkgs;

# TODO:
# npm install purty purescript-language-server

stdenv.mkDerivation {
  name = "myenv";
  buildInputs = [
    yarn
    easy-purescript-nix.purs
    easy-purescript-nix.purp
    easy-purescript-nix.spago
    easy-purescript-nix.psc-package
    easy-purescript-nix.psc-package2nix
  ];
}
