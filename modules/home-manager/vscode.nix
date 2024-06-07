{kylib, lib, pkgs, config} @ args: kylib.createModule config rec {
  
  category = "vscode";
  
  config = {

    programs.vscode = {
      enabled = true;

      extensions = with pkgs.vscode-extensions; [
        jackmacwindows.vscode-computercraft
        jackmacwindows.craftos-pc
        k--kato.intellij-idea-keybindings

        # For nix
        jnoortheen.nix-ide
        mkhl.direnv

        # Theming uses catppuccin mocha
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        gruntfuggly.todo-tree
        eamodio.gitlens
        sumneko.lua
        christian-kohler.path-intellisense
      ];
    };
  };

}