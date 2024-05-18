{pkgs, kylib, lib, config, ... }: kylib.createModule config {

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


    home.persistence."/perist/home/kyle" = lib.mkIf config.jetbrains.impermanence {
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