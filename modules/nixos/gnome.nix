{lib, config, pkgs, ...}: (cfg: {
  config = {
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gparted
    ];
  };  
})