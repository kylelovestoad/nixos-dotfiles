{pkgs, lib, config, inputs, ... }: (cfg: {

  options = {
    impermanence = lib.mkEnableOption "impermanence for projects/configs";
    clion = lib.mkEnableOption "clion";
    idea = lib.mkEnableOption "idea";
    goland = lib.mkEnableOption "goland";
    pycharm = lib.mkEnableOption "pycharm";
    rider = lib.mkEnableOption "rider";
    rustrover = lib.mkEnableOption "rover";
    webstorm = lib.mkEnableOption "webstorm";
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
      # jetbrains.gateway

      # Plugins and ides
      (lib.mkIf cfg.clion (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "clion" ([] ++ globals)))
      (lib.mkIf cfg.idea (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" ([] ++ globals)))
      (lib.mkIf cfg.goland (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "goland" ([] ++ globals)))
      (lib.mkIf cfg.pycharm (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "pycharm-professional" ([] ++ globals)))
      (lib.mkIf cfg.rider (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "rider" ([] ++ globals)))
      (lib.mkIf cfg.rustrover (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "rust-rover" ([] ++ globals)))
      (lib.mkIf cfg.webstorm (plugins-lib.buildIdeWithPlugins pkgs.jetbrains "webstorm" ([] ++ globals)))
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