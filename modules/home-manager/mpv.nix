{kylib, config, lib, ...}: kylib.mkModule config "mpv" (cfg: {
  config = lib.mkIf cfg.enable {
    programs.mpv = { 
      enable = true;
    };
  };
})