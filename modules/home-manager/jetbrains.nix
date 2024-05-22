{pkgs, kylib, lib, config, ... } @ args: kylib.createModule config rec {

  category = "jetbrains";

  options = {
    impermanence = lib.mkEnableOption "impermanence for projects/configs";
  };

  config = {

    # Load our jetbrains tools and IDEs
    home.packages = with pkgs; [
      jetbrains-toolbox
      jetbrains.clion
      jetbrains.gateway
      jetbrains.goland
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.rust-rover
      jetbrains.webstorm
    ];
    # Let default project folders and config directories persist
    home.persistence."/perist/home/kyle" = kylib.mkIfWith (cfg: cfg.impermanence) args.config category {
      directories = [
        ".local/share/Jetbrains"
        ".config/Jetbrains"
        ".cache/Jetbrains"
        "ClionProjects"
        "GolandProjects"
        "IdeaProjects"
        "PycharmProjects"
        "RustroverProjects"
        "WebstormProjects"
      ];
    };
  };
}