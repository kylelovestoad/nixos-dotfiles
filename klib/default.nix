{lib, inputs, ...}: let
  klib = (import ./default.nix) {inherit inputs lib;};
  outputs = inputs.self.outputs;
in
rec {
  ######################################
  # LIBRARY FOR BASIC HELPER FUNCTIONS #
  ######################################

  # Fetch packages from given system
  pkgsFor = system: inputs.nixpkgs.legacyPackages.${system};

  # Create a nix system by providing a configuration.nix to start from
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs klib;
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
        inherit inputs outputs klib;
      };
      # Main home-manager configuration file
      modules = [
        config
        outputs.modules.home-manager.default
      ];
    };

  # listfilesWithSuffixRecursive = 
  # {dir, suffix}: builtins.filter (filename: lib.hasSuffix suffix filename) (lib.filesystem.listFilesRecursive dir);
}