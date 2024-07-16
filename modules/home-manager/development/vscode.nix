{kylib, lib, pkgs, config, inputs, ...}: kylib.mkModule config "vscode" (cfg: {

  options = {
    extensions = lib.mkEnableOption "extensions for vscode";
  };

  config = lib.mkIf cfg.enable {

    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
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
      ];
    };
  };
})