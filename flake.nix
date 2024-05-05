{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  }@inputs:
  let
    inherit (self) outputs;
  in
  {
    nixosConfigurations = {
      nixos = 
      let 
        system = "x86_64-linux"; 
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/laptop/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "kyle@nixos" = 
      let 
        system = "x86_64-linux"; 
      in
      home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs outputs;};
        # Main home-manager configuration file
        modules = [
          ./hosts/laptop/home.nix
        ];
      };
    };
  };
}
