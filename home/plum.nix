{
  lib,
  pkgs,
  config,
  ...
}: let 
   nix_dir = "${config.home.homeDirectory}"/.nix;
in
{

  imports = [ ];

  home.username = "kdrichards";
  home.homeDirectory = "/home/kdrichards";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    nerdfonts
    figlet

    # Rust stuff since it isn't installed
    cargo-deny
    cargo-edit
    cargo-watch
    cargo
    rustc
  ];

  

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.profileExtra = ''
      nix-user-chroot ${nix_dir} bash -lc 'fastfetch'

      nix-user-chroot ${nix_dir} bash -lc 'figlet -f slant kylelovestoad'

      nix-user-chroot ${nix_dir} bash -lc 'fish'
    '';
  };

  fish.enable = lib.mkForce true;
}