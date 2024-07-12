# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: {
  imports = [
    ./impermanence.nix
    ./jetbrains.nix
    ./vscode.nix
  ];
 
  # TODO ./firefox.nix

  jetbrains.impermanence = lib.mkIf config.home-impermanence.enable true;
  
  vscode.enable = true;
}
