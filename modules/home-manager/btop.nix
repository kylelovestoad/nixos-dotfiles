{kylib, config, lib, ...}: kylib.mkModule config "btop" (cfg: { 
  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
})