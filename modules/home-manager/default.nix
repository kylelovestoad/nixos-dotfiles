# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: rec {
  imports = [
    ./impermanence.nix
    ./jetbrains.nix
    ./vscode.nix
  ];
 
  # TODO ./firefox.nix
  
  home-impermanence.enable = lib.mkForce false;
  # Set our default options for each value
  jetbrains.enable = lib.mkForce false;
  jetbrains.impermanence = kylib.mkIf home-impermanence.enable;

  vscode.enable = lib.mkForce false;
  vscode.extensions = lib.mkForce true;
}