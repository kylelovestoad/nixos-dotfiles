{
  description = "kylelovestoad's nixos flake for building his systems";

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

    # For deleting OS on boot except specified dirs
    impermanence = {
      url = "github:nix-community/impermanence";
    };

  };

  outputs = {...}@inputs:
  let
    lib = import ./klib {inherit inputs;};
  in
    with lib; {
      # Define systems here!
      nixosConfigurations = {
        strawberry = mkSystem ./hosts/strawberry/configuration.nix;
      };

      # Define home configs here!
      homeConfigurations = {
        "kyle@strawberry" = mkHome {
          system = "x86_64-linux"; 
          config = ./home/strawberry.nix;
        };
      };

      modules = {
        nixos.default = ./modules/nixos;
        home-manager.default = ./modules/home-manager;
      };
    };
}
