{lib, pkgs, config, ...}: (cfg: {

  options = {
    extensions = lib.mkEnableOption "extensions for vscode";
  };

  config = {

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium.fhs;

      extensions = with pkgs.vscode-extensions; [
        # Computercraft
        jackmacwindows.vscode-computercraft
        jackmacwindows.craftos-pc

        # Languages
        sumneko.lua # Lua
        rust-lang.rust-analyzer # Rust
        ms-vscode.cpptools # C/C++

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

      userSettings = {
        "window.zoomLevel" = 1;
        "nix.enableLanguageServer" = true;
        "window.titleBarStyle" = "custom";
        "telemetry.telemetryLevel" = "off";
        "gitlens.telemetry.enabled" = false;
        "todo-tree.general.tags" = [
          "BUG"
          "HACK"
          "FIXME"
          "TODO"
          "XXX"
          "[ ]"
          "[x]"
          # My added todo tags
          "UNUSED"
        ];
      };
    };
  };
})