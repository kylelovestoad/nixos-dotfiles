# Contains all nixos modules which can be toggled on and off
{...}: {
  imports = [
    ./catppuccin.nix
    ./impermanence.nix
  ];
}