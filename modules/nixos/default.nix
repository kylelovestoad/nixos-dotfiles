# Contains all nixos modules which can be toggled on and off
{lib, ...}: {
  imports = lib.sourceFilesBySuffices ./modules/nixos [ ".nix" ];

    # TODO 
    # ./impermanence.nix

}