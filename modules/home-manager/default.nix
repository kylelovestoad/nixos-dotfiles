# Contains all home manager modules which can be toggled on and off
{lib, config, kylib, ...}: let
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
  
  jetbrains.impermanence = lib.mkIf config.impermanence.enable true;
}

