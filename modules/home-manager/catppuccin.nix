{lib, kylib, inputs, config, ...}: kylib.mkModule config "home-catppuccin" (cfg: {

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin.enable = true;

    catppuccin.pointerCursor.enable = true;

    gtk.catppuccin.enable = true;

    gtk.catppuccin.icon.enable = true;

    qt.style.catppuccin.enable = true;

    qt.style.catppuccin.apply = true;
  };
})