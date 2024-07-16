{kylib, config, lib, pkgs, ...}: kylib.mkModule config "btop" (cfg: { 
  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
})