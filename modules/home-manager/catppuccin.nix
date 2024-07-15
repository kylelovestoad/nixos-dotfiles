{lib, kylib, inputs, config, pkgs, ...}: kylib.mkModule config "home-manager.catppuccin" (cfg: {

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options = {
    flavor = lib.mkOption { default = "mocha";};
    accent = lib.mkOption { default = "mauve";};
  };

  config = lib.mkIf cfg.enable {
    
    # We just install the catppuccin kde package since it isn't supported by catppuccin nix module
    home.packages = [ 
      (pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      })
    ];

    catppuccin.enable = true;

    catppuccin.pointerCursor = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent; 
    };

    gtk.catppuccin = {
      enable = true;
      flavor = cfg.flavor;
      accent = cfg.accent;

      icon = {
        enable = true;
        flavor = cfg.flavor;
        accent = cfg.accent;
      };
    };

    qt = {
      # Qt has to be enabled for qt styles to be set
      enable = true;
      platformTheme.name = "kvantum";
      # Need to set style as kvantum since that is how the theme is applied
      style.name = "kvantum";

      style.catppuccin = {
        enable = true;
        # Applies the QT theme automatically with Kvantum
        apply = true;
      };
    };

  };
})