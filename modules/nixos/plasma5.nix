{pkgs, inputs, config, ...}: (cfg: {
  config = {
    services = {
      xserver.desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasma";
    };
  };
})