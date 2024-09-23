{lib, kylib, inputs, config, pkgs, ...}: (cfg: let 
  catppuccinJson = builtins.fromJSON (builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/palette/af11bc6d132d2e85cc192a9237f86fa9746c92c0/palette.json";
    sha256 = "sha256-AojVV7p4nm+1tSK9KN02YLwm14fkRr2pDRPUWYYkPeA=";
  }));
  
  loadCatppuccinTheme = name: catppuccinJson.${name};
in {

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options = {
    flavor = lib.mkOption { default = "mocha";};
    accent = lib.mkOption { default = "mauve";};
  };

  config = {

    lib = {
      inherit catppuccinJson loadCatppuccinTheme;
    };

    nixpkgs.overlays = lib.mkIf config.vscode.enable [inputs.catppuccin-vsc.overlays.default];

    programs.vscode = lib.mkIf config.vscode.enable {
      extensions = with pkgs.vscode-extensions; [
        (catppuccin.catppuccin-vsc.override {
          # Get the accent specified in the catppuccin module
          accent = cfg.accent;
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

      # Add these settings for better compatability with catppuccin
      userSettings = let 
        # HACK If this name were to ever change formatting there would most certainly be a problem
        flavorName = if cfg.flavor == "frappe" then "frappé" else cfg.flavor;
      in {
        # Flavor needs to be capitalized since that is how the names work in this instance
        "workbench.colorTheme" = "Catppuccin ${kylib.capitalize flavorName}";
        "workbench.iconTheme" = "catppuccin-${flavorName}";
        # Catppuccin uses a custom (and much nicer) title bar
        "window.titleBarStyle" = "custom";
      };
    };

    # Needs to be enabled manually
    programs.obs-studio.catppuccin = lib.mkIf config.programs.obs-studio.enable {
      enable = true;
      inherit (cfg) flavor;
    };

    # Needs to be enabled manually
    programs.freetube.catppuccin = lib.mkIf config.programs.freetube.enable {
      enable = true;
      inherit (cfg) flavor accent;
    };


    # vesktop
    # update quickCss.css because it applies immediately
    home.file.".config/vesktop/settings/quickCss.css".text = lib.mkIf config.discord.enable ''
      /* ${cfg.flavor} (${cfg.accent} accent)*/
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-${cfg.flavor}-${cfg.accent}.theme.css");
    '';

    home.packages = [
      # (pkgs.catppuccin-gtk.override {
      #   variant = cfg.flavor;
      #   accents = [ cfg.accent ];
      # })
    ] ++ (if config.plasma.enable then [ 
      # We just install the catppuccin kde package since it isn't supported by catppuccin nix module
      (pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      }) 
    ] else []);

    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        inherit (cfg) flavor accent;
        gnomeShellTheme = true;
        icon = {
          enable = true;
          inherit (cfg) flavor accent;
        };
      };
    };

    # enables catppuccin for all applications that support it and are installed
    catppuccin = {
      enable = true;
      inherit (cfg) flavor accent;
      pointerCursor.enable = true;
    };
  };
})