{lib, inputs, config, ...}: let
  cfg = config.home-impermanence;
in {
  imports = [  
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options = {
    home-impermanence.enable = lib.mkEnableOption "Enable impermanence";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist/home" = {
      directories = [
        ".ssh"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"

        # Holds cloned git repos
        "git"
        # Place for editing this git repo
        "nixos-conf"
      ];
    };
  };
}