{
  lib,
  pkgs,
  ...
}:
{

  imports = [ ];

  home.username = "kdrichards";
  home.homeDirectory = "/home/kdrichards";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nix-direnv
    fastfetch
    nerdfonts
    figlet

    cargo-deny
    cargo-edit
    cargo-watch
    cargo
  ];

  fish.enable = lib.mkForce true;
}