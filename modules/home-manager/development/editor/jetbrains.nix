{pkgs, lib, config, inputs, ... }: (cfg: {

  options = {
    impermanence = lib.mkEnableOption "impermanence for projects/configs";
  };

  config = {

    # Load our jetbrains tools and IDEs
    home.packages = with pkgs; let 
      plugins-lib = inputs.nix-jetbrains-plugins.lib."${system}";

      globals = [] ++ (if config.catppuccin-theme.enable then [
        "nix-idea"
        "com.github.catppuccin.jetbrains"
        "com.github.catppuccin.jetbrains_icons"
      ] else []);
    in [
      jetbrains.gateway

      # Plugins and ides
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "clion" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "goland" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "pycharm-professional" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "rider" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "rust-rover" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "webstorm" ([] ++ globals))
      (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "writerside" [])
    ];
      #
    # Let default project folders and config directories persist
    home.persistence."/persist/home/${config.home.username}" = lib.mkIf cfg.impermanence {
      allowOther = true;
      directories = [
        ".local/share/Jetbrains"
        ".config/Jetbrains"
        ".cache/Jetbrains"
        "CLionProjects"
        "GolandProjects"
        "IdeaProjects"
        "PycharmProjects"
        "RiderProjects"
        "RustroverProjects"
        "WebstormProjects"
      ];
    };
  };
})