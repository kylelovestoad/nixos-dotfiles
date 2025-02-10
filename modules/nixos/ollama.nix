{lib, config, pkgs, ...}: (cfg: {
  config = {

    services.open-webui = {
      enable = true;
      port = 11404;
      environment = {
        # Disable authentication
        # WEBUI_AUTH = "False";
      };
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      # loadModels = [ "deepseek-r1" ];
    };
  };
})