{lib, inputs, config, ...}: (cfg: {

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    # inputs.stylix.nixosModules.stylix
  ];

  options = {
    flavor = lib.mkOption { default = "mocha";};
    accent = lib.mkOption { default = "mauve";};
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;
    };

    catppuccin.sddm = {
      enable = config.services.displayManager.sddm.enable && config.plasma6.enable;
      inherit (cfg) flavor;
    };

    catppuccin.grub = {
      enable = true;
      inherit (cfg) flavor;
    };

    catppuccin.tty = {
      enable = true;
      inherit (cfg) flavor;
    };

    # stylix.enable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # stylix.cursor.package = pkgs.catppuccin-cursors.mochaMauve;
    # stylix.autoEnable = true;
  };
})