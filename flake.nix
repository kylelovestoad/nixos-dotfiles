{
  description = "kylelovestoad's nixos flake for building nix-based systems";

  inputs = {

    # Define our choice of nixpkgs and home-manager repos
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For catpuccin theming
    catppuccin.url = "github:catppuccin/nix";

    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz"; 

    # UNUSED For now, this might have a use later
    stylix.url = "github:danth/stylix";

    # home-manager-unstable = {
    #   url = "github:nix-community/home-manager/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For deleting OS on boot except specified dirs
    impermanence = {
      url = "github:nix-community/impermanence";
    };

  };

  outputs = {nixpkgs, ...}@inputs:
  let
    lib = nixpkgs.lib;
    kylib = import ./kylib {inherit inputs lib;};
  in
    with kylib; {
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
