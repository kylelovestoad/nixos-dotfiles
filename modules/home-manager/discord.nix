{pkgs, kylib, lib, config, ... }: kylib.mkModule config "discord" (cfg: {

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
    ];
  };
})

