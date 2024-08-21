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

    emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";

    nur.url = "github:nix-community/NUR";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For deleting OS on boot except specified dirs
    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };

  outputs = {nixpkgs, nur, ...}@inputs:
  let
    system = "x86_64-linux";
    # Fetch packages from given system
    pkgsFor = system: inputs.nixpkgs.legacyPackages.${system};
    pkgs = pkgsFor system;
    nurNoPkgs = import nur { 
      nurpkgs = pkgs; 
      pkgs = null; 
    };
    lib = nixpkgs.lib;
    kylib = import ./kylib {inherit inputs lib nur pkgs nurNoPkgs;};
  in {
      # Define systems here!
      nixosConfigurations = {
        strawberry = kylib.mkSystem ./hosts/strawberry/configuration.nix;
      };

      # Define home configs here!
      homeConfigurations = {
        "kyle@strawberry" = kylib.mkHome {
          inherit system; 
          config = ./home/strawberry.nix;
        };
      };

      modules = {
        nixos.default = ./modules/nixos;
        home-manager.default = ./modules/home-manager;
      };

      devShells.${system}.default = pkgs.mkShell {
        name = "dev-shell";
      };
    };
}
