{pkgs, ...}: (cfg: {
  config = {
    services.emacs = {
      enable = true;
      package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
    };
  };
})