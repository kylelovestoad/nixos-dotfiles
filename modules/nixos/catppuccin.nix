{lib, kylib, inputs, config, ...}: kylib.mkModule config "nixos.catppuccin" (cfg: {

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config = lib.mkIf cfg.enable (let test = {
    ccatppuccin.enable = true;
  }; in builtins.trace test test);
})