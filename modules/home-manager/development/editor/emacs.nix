{lib, inputs, nurNoPkgs, ...}: (cfg: {

  imports = [
    nurNoPkgs.repos.rycee.hmModules.emacs-init
  ];

  config = {
    nixpkgs.overlays = [ (import inputs.emacs-overlay) ];

    # programs.emacs.init = {
    #   enable = true;
    # };
  };
})