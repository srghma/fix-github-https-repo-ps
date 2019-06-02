{ pkgs ? import <nixpkgs> {} }:

let
  # src = pkgs.fetchFromGitHub (
  #   builtins.fromJSON (
  #     builtins.readFile ./revision.json
  #   )
  # );

  src = /home/srghma/projects/easy-purescript-nix/default.nix;
in
  import src { inherit pkgs; }
