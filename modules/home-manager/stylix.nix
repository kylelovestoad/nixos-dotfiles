{kylib, inputs, config, pkgs, lib, ...}: kylib.mkModule config "stylix.homeManager" (cfg: {

  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  # UNUSED For now, this module might have a use later
  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.cursor.package = pkgs.catppuccin-cursors.mochaMauve;
    stylix.autoEnable = true;
    # stylix.targets.vscode.enable = false;
    stylix.image = ../../assets/firewatch.jpg;
  };
})