{lib, kylib, inputs, config, ...}: kylib.mkModule config "home-manager.catppuccin" (cfg: {

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf cfg.enable (let test = {
    catppuccin.enable = true;

    catppuccin.pointerCursor.enable = true;

    gtk.catppuccin.enable = true;

    gtk.catppuccin.icon.enable = true;

    qt.style.catppuccin.enable = true;

    qt.style.catppuccin.apply = true;
  }; in builtins.trace test test);
})