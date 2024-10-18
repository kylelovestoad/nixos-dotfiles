{lib, inputs, nurNoPkgs, pkgs, ...}: (cfg: {

  imports = [
    nurNoPkgs.repos.rycee.hmModules.emacs-init
  ];

  config = {
    nixpkgs.overlays = [ (import inputs.emacs-overlay) ];

    # programs.emacs.init = {
    #   enable = true;
    # };

    
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
      extraConfig = ''
        (setq standard-indent 4)
      '';
    };
  };
})