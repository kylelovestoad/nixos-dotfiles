{lib, config, ...}: {

  imports = [
    ./jetbrains.nix
    ./vscode.nix
  ];

  jetbrains.impermanence = lib.mkIf config.impermanence.homeManager.enable true;

  vscode.enable = true;
}