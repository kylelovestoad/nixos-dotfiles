{lib, inputs, config, ...}: {
  imports = [  
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options = {
    impermanence.enable = lib.mkEnableOption "Enable impermanence";
  };

  config = lib.mkIf config.impermanence.enable {
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