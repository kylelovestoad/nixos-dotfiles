{pkgs, config, ...}: (cfg: {
  config = {
    programs.fish = {
      enable = true;
    };
  };
})