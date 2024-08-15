# Contains all nixos modules which can be toggled on and off
{lib, kylib, config, ...}: let
  excluded = [ 
    ./default.nix 
  ];
  foundModules = kylib.applyModules ./. excluded 
  (name: { 
    defaultOptions = {
      # Creates an enable option with the name as part of the description
      enable = lib.mkEnableOption "${name}.enable";
    };

    configPredicate = moduleConfig: lib.mkIf config.${name}.enable moduleConfig;
  });
in {
  imports = [] ++ foundModules;
}