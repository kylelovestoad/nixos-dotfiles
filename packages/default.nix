# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  olympus = pkgs.callPackage ./olympus/olympus.nix { };
  acer-predator = pkgs.callPackage ./acer-predator-turbo-and-rgb-keyboard-linux-module/package.nix { kernel = pkgs.linux; };
}