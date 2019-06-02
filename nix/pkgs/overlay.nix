pkgs: pkgsOld:
{
  hies                = pkgs.callPackage ./hie-nix {};
  gitignore           = pkgs.callPackage ./nix-gitignore {};
  easy-purescript-nix = pkgs.callPackage ./easy-purescript-nix {};
}
