{pkgs, inputs, ...}: (cfg: {

  config = {
    nixpkgs.overlays = [
      inputs.emacs-overlay.overlays.default
      inputs.emacs-overlay.overlays.emacs
      inputs.emacs-overlay.overlays.package
    ];

    environment.systemPackages = with pkgs; [
      symbola
    ];

    services.emacs = {
      enable = true;
      package = pkgs.emacs-git; # replace with emacs-gtk, or a version provided by the community overlay if desired.
    };
  };
})