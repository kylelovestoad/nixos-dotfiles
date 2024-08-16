{pkgs, kylib, lib, config, ...}: (cfg: {
  config = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };
})