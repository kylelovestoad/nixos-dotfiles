{lib, ...}: rec {

  ######################################
  # LIBRARY FOR BASIC HELPER FUNCTIONS #
  ######################################

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

  filesInRecursive' = path: list: lib.mapAttrsToList (fname: type: let
    newPath = (path + "/${fname}");
  in
    (if type == "directory" then (filesInRecursive' newPath list) else newPath)
  ) 
  (builtins.readDir path);

  filesInRecursive = path: lib.flatten (filesInRecursive' path []);

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
    
  listToAttrsWithValue = list: value: builtins.listToAttrs (builtins.map (name: { inherit name value; }) list);

  addGroupsToUsers = addedGroups: users: listToAttrsWithValue users { extraGroups = addedGroups; };

  ### Module functions ###

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

  applyModules = path: excluded: applyFunc: let 
    files = filesInRecursive path;
    filteredFiles = builtins.filter (file: 
      builtins.any (exclusion: file != exclusion && lib.hasSuffix ".nix" file) excluded) 
      files;
  in
    builtins.map 
    (file: let
      name = fileNameOf file;
      applyAttrs = applyFunc name; 
    # moduleArgs parameter is unused as they are passed to the mkModule functions when modules are evaluated
    # since the unfinished functions are added to imports, this works 
    in mkModule {
      inherit (applyAttrs) defaultOptions configPredicate;
      inherit name;
      path = file;
    })
    filteredFiles;
}