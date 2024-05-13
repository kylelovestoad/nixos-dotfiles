# Contains all home manager modules which can be toggled on and off
{lib, config, ...}: 

{
  imports = lib.sourceFilesBySuffices ./modules/home-manager [ ".nix" ];
  # [
  #   ./impermanence.nix
  #   ./jetbrains.nix
  # ];

  # TODO
  # ./vscode.nix
  # ./firefox.nix
  
  impermanence.enable = lib.mkForce false;
  # Set our default options for each value
  jetbrains.enable = lib.mkForce false;
  jetbrains.impermanence = lib.mkIf config.impermanence.enable true;
  
}