{
  lib,
  inputs,
  pkgs,
  pkgs-unstable,
  config,
  ...
}:
(cfg: {

  config = {
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
      inputs.emacs-overlay.overlays.emacs
      inputs.emacs-overlay.overlays.package
    ];

    home.packages = with pkgs; [
      ## Emacs itself
      binutils # native-comp needs 'as', provided by this

      ## Doom dependencies
      git
      ripgrep
      gnutls # for TLS connectivity

      # :term vterm
      cmake
      libvterm
      libtool

      # markdown
      pandoc

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      (lib.mkIf (config.programs.gpg.enable) pinentry-emacs) # in-emacs gnupg prompts
      zstd # for undo-fu-session/undo-tree compression`
      # :checkers spell
      (aspellWithDicts (
        ds: with ds; [
          en
          en-computers
          en-science
        ]
      ))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :app everywhere
      xorg.xwininfo
      xdotool
      xclip

      symbola
    ];

    services.emacs = {
      client.enable = true;
      enable = true;
      package = pkgs.emacs-git; # replace with emacs-gtk, or a version provided by the community overlay if desired.
      defaultEditor = true;
    };
  };
})
