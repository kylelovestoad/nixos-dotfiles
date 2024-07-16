# Contains all home manager modules which can be toggled on and off
{kylib, lib, config, ...}: {
  imports = [
    ./development
    ./catppuccin.nix
    ./impermanence.nix
    # ./stylix.nix
  ];
 
  # TODO ./firefox.nix
}
