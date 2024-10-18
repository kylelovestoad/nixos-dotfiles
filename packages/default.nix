# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  olympus = with pkgs; pkgs.callPackage ./olympus/olympus.nix { 
    buildLuarocksPackage = luajitPackages.buildLuarocksPackage;
    luaAtLeast = luajitPackages.luaAtLeast;
    luaOlder = luajitPackages.luaOlder;
  };

  twinejs = pkgs.callPackage ./twinejs/twinejs.nix { };

}