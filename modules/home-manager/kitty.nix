{kylib, config, lib, pkgs, ...}: kylib.mkModule config "kitty" (cfg: { 
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
    };
  };
})