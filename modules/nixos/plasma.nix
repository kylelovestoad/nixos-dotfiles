{pkgs, inputs, config, ...}: (cfg: {
  config = {
    services = {
      desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasma";
    };
  };
})