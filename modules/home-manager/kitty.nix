{kylib, config, lib, ...}: (cfg: { 
  config = {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
    };
  };
})