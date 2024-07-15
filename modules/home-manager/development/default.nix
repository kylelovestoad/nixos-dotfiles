{lib, config, ...}: {

  imports = [
    ./jetbrains.nix
    ./vscode.nix
  ];

  jetbrains.impermanence = lib.mkIf config.impermanence.homeManager.enable true;

  vscode.enable = true;

  vscode.catppuccin = lib.mkIf config.catppuccin.homeManager.enable true;
}