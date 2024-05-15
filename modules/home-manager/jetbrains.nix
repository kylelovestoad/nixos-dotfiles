{pkgs, lib, config, ... }: let
  cfg = config.home-impermanence;
in {

  options = {
    jetbrains.enable = lib.mkEnableOption "Enable jetbrains apps";
    jetbrains.impermanence = lib.mkEnableOption "Enable impermanence for projects/configs";
  };

  config = lib.mkIf cfg.enable {

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