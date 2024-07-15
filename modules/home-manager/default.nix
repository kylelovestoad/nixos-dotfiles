# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: {
  imports = [
    ./catppuccin.nix
    ./impermanence.nix
    ./jetbrains.nix
    ./vscode.nix
  ];
 
  # TODO ./firefox.nix

  jetbrains.impermanence = lib.mkIf config.impermanence.homeManager.enable true;

  vscode.enable = true;

  vscode.catppuccin = lib.mkIf config.catppuccin.homeManager.enable true;
}
