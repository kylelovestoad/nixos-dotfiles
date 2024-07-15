# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: {
  imports = [
    ./catppuccin.nix
    ./impermanence.nix
    ./jetbrains.nix
    ./vscode.nix
  ];
 
  # TODO ./firefox.nix

  jetbrains.impermanence = lib.mkIf config.home-manager.impermanence.enable true;

  vscode.enable = true;

  vscode.catppuccin = lib.mkIf config.home-manager.catppuccin.enable true;
}
