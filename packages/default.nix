# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  olympus = pkgs.callPackage ./olympus/olympus.nix { };

  twinejs = pkgs.callPackage ./twinejs/twinejs.nix { };

}