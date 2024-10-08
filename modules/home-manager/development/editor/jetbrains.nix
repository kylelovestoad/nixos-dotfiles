{pkgs, lib, config, ... }: (cfg: {

  options = {
    impermanence = lib.mkEnableOption "impermanence for projects/configs";
  };

  config = {

    # Load our jetbrains tools and IDEs
    home.packages = with pkgs; let 
      globals = [
        "nixidea"
      ];
    in [
      jetbrains-toolbox
      jetbrains.gateway
      # Plugins and ides
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ([] ++ globals))
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ([] ++ globals)) 
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate ([] ++ globals)) 
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-professional ([] ++ globals)) 
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rust-rover ([] ++ globals))
      (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm ([] ++ globals))
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
        "RustroverProjects"
        "WebstormProjects"
      ];
    };
  };
})