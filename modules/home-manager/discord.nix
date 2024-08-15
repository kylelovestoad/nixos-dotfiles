{pkgs, kylib, lib, config, ... }: (cfg: {

  config = {
    home.packages = with pkgs; [
      vesktop

      # Fallback discord
      discord
    ];
  };
})

