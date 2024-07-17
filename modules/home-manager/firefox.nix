{kylib, config, lib, ...}: kylib.mkModule config "firefox" (cfg: { 
  config = lib.mkIf cfg.enable {
    # TODO
  };
})