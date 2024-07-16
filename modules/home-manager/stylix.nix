{kylib, inputs, config, pkgs, ...}: kylib.mkModule config "stylix.homeManager" (cfg: {

  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config = {
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.cursor.package = pkgs.catppuccin-cursors.mochaMauve;
    stylix.autoEnable = true;
    # stylix.targets.vscode.enable = false;
    stylix.image = ../../assets/firewatch.jpg;
  };
})