{lib, kylib, inputs, config, ...}: kylib.mkModule config "catppuccin.system" (cfg: {

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    # inputs.stylix.nixosModules.stylix
  ];

  options = {
    flavor = lib.mkOption { default = "mocha";};
    accent = lib.mkOption { default = "mauve";};
  };

  config = lib.mkIf cfg.enable {
    catppuccin.enable = true;

    services.displayManager.sddm.catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;
    };

    boot.loader.grub.catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;
    };

    console.catppuccin = {
      enable = true;
      inherit (cfg) flavor;
    };

    # stylix.enable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # stylix.cursor.package = pkgs.catppuccin-cursors.mochaMauve;
    # stylix.autoEnable = true;
  };
})