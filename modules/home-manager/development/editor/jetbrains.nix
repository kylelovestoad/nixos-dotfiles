{pkgs-unstable, lib, config, ... }: (cfg: {

  options = {
    impermanence = lib.mkEnableOption "impermanence for projects/configs";
  };

  config = {

    # Load our jetbrains tools and IDEs
    home.packages = with pkgs-unstable; let 
      globals = [
        "nixidea"
      ];
    in [
      jetbrains-toolbox
      jetbrains.gateway
      # Plugins and ides
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.clion ([] ++ globals))
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.goland ([] ++ globals)) 
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.idea-ultimate ([] ++ globals)) 
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.pycharm-professional ([] ++ globals)) 
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.rider ([] ++ globals)) 
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.rust-rover ([] ++ globals))
      (pkgs-unstable.jetbrains.plugins.addPlugins pkgs-unstable.jetbrains.webstorm ([] ++ globals))
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
        # "RiderProjects"
        "RustroverProjects"
        "WebstormProjects"
      ];
    };
  };
})