# This file was generated by Psc-Package2Nix
# You will not want to edit this file.
# To change the contents of this file, first fork Psc-Package2Nix
# And edit the $file_template

{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {

    "console" = pkgs.stdenv.mkDerivation {
      name = "console";
      version = "v4.2.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-console.git";
        rev = "v4.2.0";
        sha256 = "1b2nykdq1dzaqyra5pi8cvvz4dsbbkg57a2c88yi931ynm19nnw6";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "effect" = pkgs.stdenv.mkDerivation {
      name = "effect";
      version = "v2.0.1";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-effect.git";
        rev = "v2.0.1";
        sha256 = "1vqw5wrdxzh1ww6z7271xr4kg4mx0r3k3mwg18dmgmzj11wbn2wh";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "prelude" = pkgs.stdenv.mkDerivation {
      name = "prelude";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-prelude.git";
        rev = "v4.1.0";
        sha256 = "1pwqhsba4xyywfflma5rfqzqac1vmybwq7p3wkm4wsackvbn34h5";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };
};

in {
  inherit inputs;

  set = "psc-0.12.3";
  source = "https://github.com/purescript/package-sets.git";
}
