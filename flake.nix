{
  description = "kylelovestoad's nix flake for building nix-based systems";

  inputs = {

    # Define our choice of nixpkgs and home-manager repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For catpuccin theming
    catppuccin.url = "github:catppuccin/nix";

    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";

    nur.url = "github:nix-community/NUR";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager/plasma-5";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";

    # For deleting OS on boot except specified dirs
    impermanence = {
      url = "github:nix-community/impermanence/63f4d0443e32b0dd7189001ee1894066765d18a5";
    };

    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nur,
      ...
    }@inputs:
    let

      inherit (self) outputs;
      system = "x86_64-linux";
      # Fetch packages from given system
      pkgsFor =
        pkgs: system:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
        };

      pkgs = pkgsFor nixpkgs system;
      pkgs-unstable = pkgsFor nixpkgs-unstable system;

      nurNoPkgs = import nur {
        nurpkgs = pkgs;
        pkgs = null;
      };

      lib = nixpkgs.lib // home-manager.lib;
      kylib = import ./kylib { inherit lib; };

      # Create a nix system by providing a configuration.nix to start from
      mkSystem =
        config:
        lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-unstable kylib;
          };
          modules = [
            config
            outputs.modules.nixos.default
          ];
        };

      # Create a nix home for home-manager to manage by providing a system type and config file to start from
      mkHome =
        { system, config }:
        lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit
              inputs
              pkgs-unstable
              nurNoPkgs
              kylib
              ;
          };
          # Main home-manager configuration file
          modules = [
            config
            outputs.modules.home-manager.default
          ];
        };
    in
    {
      inherit lib;
      # Define systems here!
      nixosConfigurations = {
        strawberry = mkSystem ./hosts/strawberry/configuration.nix;
      };

      # Define home configs here!
      homeConfigurations = {
        "kyle@strawberry" = mkHome {
          inherit system;
          config = ./home/strawberry.nix;
        };

        "kdrichards@plum" = mkHome {
          inherit system;
          config = ./home/plum.nix;
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
