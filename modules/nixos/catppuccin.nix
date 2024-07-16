{lib, kylib, inputs, config, pkgs, ...}: kylib.mkModule config "catppuccin.system" (cfg: {

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    # inputs.stylix.nixosModules.stylix
  ];

  config = lib.mkIf cfg.enable {
    catppuccin.enable = true;
    # stylix.enable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # stylix.cursor.package = pkgs.catppuccin-cursors.mochaMauve;
    # stylix.autoEnable = true;
  };
})