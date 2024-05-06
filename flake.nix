{
  description = "Nixos config flake";

  inputs = {

    # Define our choice of nixpkgs and home-manager repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager-unstable = {
    #   url = "github:nix-community/home-manager/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    ... 
  }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      strawberry = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/strawberry/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "kyle@strawberry" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        # Main home-manager configuration file
        modules = [
          ./hosts/strawberry/home.nix
        ];
      };
    };
  };
}
