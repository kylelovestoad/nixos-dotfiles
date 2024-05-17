# Contains all nixos modules which can be toggled on and off
{lib, ...}: {
  imports = [
    ./impermanence.nix
  ];

  sys-impermanence.enable = lib.mkForce false;

}