{lib, inputs, ...}: let
  kylib = (import ./default.nix) {inherit inputs lib;};
  outputs = inputs.self.outputs;
in rec {
  ######################################
  # LIBRARY FOR BASIC HELPER FUNCTIONS #
  ######################################

  # Fetch packages from given system
  pkgsFor = system: inputs.nixpkgs.legacyPackages.${system};

  # Create a nix system by providing a configuration.nix to start from
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs kylib;
      };
      modules = [
        config
        outputs.modules.nixos.default
      ];
    };

  # Create a nix home for home-manager to manage by providing a system type and config file to start from
  mkHome = {system, config}: 
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor system;
      extraSpecialArgs = {
        inherit inputs outputs kylib;
      };
      # Main home-manager configuration file
      modules = [
        config
        outputs.modules.home-manager.default
      ];
    };

  # Capitalizes the first character of the string given
  capitalize = str: lib.concatStrings [
    # Take the first char of the string, capitalizing it
    (lib.toUpper (builtins.substring 0 1 str)) 
    # Second part is from char 1 to the end of the string
    (builtins.substring 1 (builtins.stringLength str) str) 
  ];

  # Helper function for pathToDotString
  pathToDotString' = list: index: let 
    length = builtins.length list;
  in 
  # First we start by creating our first element in the path. This one will not have a prepended dot
  if index == 0 then "${builtins.elemAt list index}" + pathToDotString' list (index + 1)
  # Then for every element that is not the last, add it with a dot prepended which forms the pattern "first.next.next.next" 
  else if index + 1 != length then ".${builtins.elemAt list index}" + pathToDotString' list (index + 1)
  # For the last element, we don't call the function again to prevent any more recursions (This would cause an error)
  else ".${builtins.elemAt list index}";

  # Just calls pathToDotString' starting at index 0
  # Converts a list to a dotpath such that for example ["a" "b" "c"] becomes "a.b.c"
  pathToDotString = list: pathToDotString' list 0;

  # Matches all consecutive chars that aren't a dot, meaning it gets all strings between the dots
  dotStringToPath = str: lib.splitString "." str;

  # configPathFromDotString = str: baseConfig: lib.getAttrFromPath (dotStringToPath str) baseConfig;

  mkModule = updateArgs@{path, name, defaultOptions, configPredicate}: moduleArgs@{pkgs, ...}: let

    categoryPath = dotStringToPath updateArgs.name;

    # This gets the path to the user defined config
    cfg = moduleArgs.config.${name};

    module = (builtins.import path) moduleArgs cfg;

    # Don't mess with existing options
    combinedOptions = updateArgs.defaultOptions // (module.options or {});

    # Map the options with the attrPath.
    combinedOptionsWithPath = lib.setAttrByPath categoryPath combinedOptions; 

  in {
    imports = module.imports or [];
    options = combinedOptionsWithPath;
    config = updateArgs.configPredicate (module.config or {});
  };

  filesInRecursive' = path: list: lib.mapAttrsToList (fname: type: let
    newPath = (path + "/${fname}");
  in
    (if type == "directory" then (filesInRecursive' newPath list) else newPath)
  ) 
  (builtins.readDir path);

  filesInRecursive = path: lib.flatten (filesInRecursive' path []);

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
    
  applyModules = path: excluded: applyFunc: let 
    files = filesInRecursive path;
    filteredFiles = builtins.filter (file: 
      builtins.any (exclusion: file != exclusion) excluded) 
      files;
  in
    builtins.map 
    (file: let
      name = fileNameOf file;
      applyAttrs = applyFunc name; 
    in mkModule {
      inherit (applyAttrs) defaultOptions configPredicate;
      inherit name;
      path = file;
    })
    filteredFiles;
}