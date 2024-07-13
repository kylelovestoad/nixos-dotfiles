# Contains all nixos modules which can be toggled on and off
{lib, ...}: {
  imports = [
    ./catppuccin.nix
    ./impermanence.nix
  ];
}