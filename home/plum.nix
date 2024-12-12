{
  lib,
  pkgs,
  ...
}:
{

  imports = [ ];

  home.username = "kdrichards";
  home.homeDirectory = "/home/kdrichards";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      rustToolchain =
        let
          rust = prev.rust-bin;
        in
        if builtins.pathExists ./rust-toolchain.toml then
          rust.fromRustupToolchainFile ./rust-toolchain.toml
        else if builtins.pathExists ./rust-toolchain then
          rust.fromRustupToolchainFile ./rust-toolchain
        else
          rust.stable.latest.default.override {
            extensions = [ "rust-src" "rustfmt" ];
          };
    })
  ];

  home.packages = with pkgs; [
    nix-direnv
    fastfetch
    nerdfonts
    figlet

    rustToolchain
    openssl
    pkg-config
    cargo-deny
    cargo-edit
    cargo-watch
    rust-analyzer
  ];

  home.sessionVariables = {
    # Required by rust-analyzer
    RUST_SRC_PATH = "${pkgs.rustToolchain}/lib/rustlib/src/rust/library";
  };

  fish.enable = lib.mkForce true;
}