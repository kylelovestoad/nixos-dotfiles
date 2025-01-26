{lib, inputs, config, ...}: (cfg: {
  imports = [
    {
      nix.settings = {
        substituters = [ "https://cosmic.cachix.org/" ];
        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
      };
    }
    inputs.nixos-cosmic.nixosModules.default
  ];

  config = {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true
  };
})