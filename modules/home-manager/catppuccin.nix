{lib, kylib, inputs, config, pkgs, ...}: kylib.mkModule config "catppuccin.homeManager" (cfg: {

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options = {
    flavor = lib.mkOption { default = "mocha";};
    accent = lib.mkOption { default = "mauve";};
  };

  config = lib.mkIf cfg.enable {

    nixpkgs.overlays = lib.mkIf config.vscode.enable [inputs.catppuccin-vsc.overlays.default];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions; lib.mkIf config.vscode.enable [
        (catppuccin.catppuccin-vsc.override {
          # Get the accent specified in the catppuccin module
          accent = config.catppuccin.homeManager.accent;
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = true;
          workbenchMode = "default";
          bracketMode = "rainbow";
          colorOverrides = {};
          customUIColors = {};
        })
        catppuccin.catppuccin-vsc-icons
      ];

      # We add these settings for better compatability with catppuccin
      userSettings = let 
        # HACK If this name were to ever change formatting there would most certainly be a problem
        flavorName = if cfg.flavor == "frappe" then "frappé" else cfg.flavor;
      in {
        # Flavor needs to be capitalized since that is how the names work 
        "workbench.colorTheme" = "Catppuccin ${kylib.capitalize flavorName}";
        # Catppuccin uses a custom (and much nicer) title bar
        "window.titleBarStyle" = "custom";
      };
    };

    # kitty
    programs.kitty.catppuccin = {
      enable = lib.mkIf config.kitty.enable true;
      inherit (cfg) flavor;
    };

    # btop
    programs.btop.catppuccin = {
      enable = lib.mkIf config.btop.enable true; 
      inherit (cfg) flavor;
    };

    # Discord
    home.file.".config/vesktop/settings/quickCss.css".text = lib.mkIf config.discord.enable ''
      /* ${cfg.flavor} (${cfg.accent} accent)*/
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-${cfg.flavor}.${cfg.accent}.css");
    '';

    home.packages = [ 
      # We just install the catppuccin kde package since it isn't supported by catppuccin nix module
      (pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      }) 
    ];

    catppuccin.enable = true;

    catppuccin.pointerCursor = {
      enable = true;
      inherit (cfg) flavor accent;
    };

    gtk.catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;

      icon = {
        enable = true;
        inherit (cfg) flavor accent;
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
        inherit (cfg) flavor accent;
      };
    };

  };
})