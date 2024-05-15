# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: 

{
  imports = [
    ./impermanence.nix
    ./jetbrains.nix
  ];
 
  # TODO
  # ./vscode.nix
  # ./firefox.nix
  
  home-impermanence.enable = lib.mkForce false;
  # Set our default options for each value
  jetbrains.enable = lib.mkForce false;
  jetbrains.impermanence = lib.mkIf config.impermanence.enable true;
  
}