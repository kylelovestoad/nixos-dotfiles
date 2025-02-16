{ pkgs, config, ... }:
(cfg: {
  config = {
    programs.man.generateCaches = false;

    programs.fish = {
      enable = true;

      plugins = [ ];
    };
  };
})
