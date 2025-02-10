{pkgs, inputs, config, ...}: (cfg: {
  config = {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.defaultSession = "plasma";
    };

    environment.systemPackages = with pkgs; [
      kdePackages.plasma-browser-integration
    ];
  };
})