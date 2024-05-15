# Contains all nixos modules which can be toggled on and off
{lib, ...}: {
  imports = [
    ./impermanence.nix
  ];

  test.sysimpermanence.enable = lib.mkForce false;

}