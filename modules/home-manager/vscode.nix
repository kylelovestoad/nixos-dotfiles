{kylib, lib, pkgs, config, ...}: kylib.mkModule config "vscode" (cfg: {

  options = {
    extensions = lib.mkEnableOption "extensions for vscode";
  };

  config = {

    home.packages  = with pkgs; [ vscode ];

    programs.vscode = lib.mkIf cfg.extensions {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        jackmacwindows.vscode-computercraft
        jackmacwindows.craftos-pc
        k--kato.intellij-idea-keybindings

        # For nix
        jnoortheen.nix-ide
        mkhl.direnv

        # Theming uses catppuccin
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        gruntfuggly.todo-tree
        eamodio.gitlens
        sumneko.lua
        christian-kohler.path-intellisense
      ];
    };
  };

})