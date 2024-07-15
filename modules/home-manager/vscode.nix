{kylib, lib, pkgs, config, inputs, ...}: kylib.mkModule config "vscode" (cfg: {

  options = {
    extensions = lib.mkEnableOption "extensions for vscode";
    catppuccin = lib.mkEnableOption "catppuccin theming";
  };

  config = {

    nixpkgs.overlays = if cfg.catppuccin then [inputs.catppuccin-vsc.overlays.default] else [];

    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; let 
        catppuccin-extensions = if cfg.catppuccin then [
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
        ] else [];
      in [
        # Computercraft
        jackmacwindows.vscode-computercraft
        jackmacwindows.craftos-pc

        # Lua dev
        sumneko.lua

        # For nix/nixpkgs
        jnoortheen.nix-ide
        mkhl.direnv
        editorconfig.editorconfig

        # More used to jetbrains bindings
        k--kato.intellij-idea-keybindings

        # QoL
        gruntfuggly.todo-tree
        christian-kohler.path-intellisense
        
        # Git & Github
        eamodio.gitlens
        github.vscode-pull-request-github
      ] ++ catppuccin-extensions;
    };
  };
})