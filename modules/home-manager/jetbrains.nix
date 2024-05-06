{pkgs,  ... }:

{
  home.packages = with pkgs; [
    jetbrains.clion
    jetbrains.gateway
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.rust-rover
    jetbrains.webstorm
  ]

}