{lib, config, pkgs, ...}: (cfg: {
  config = {
    services.ollama = {
      enable = true;
      port = 11404;
      package = pkgs.ollama-cuda;
      # loadModels = [ "deepseek-r1" ];
    };
  };
})