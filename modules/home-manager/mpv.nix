{kylib, config, lib, ...}: kylib.mkModule config "mpv" (cfg: {
  config = lib.mkif cfg.enable {
    programs.mpv = { 
      enable = true;
    };
  };
})