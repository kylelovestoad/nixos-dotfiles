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
        "git"
        "Music"
        "nixos"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
      ];
    };
  };
}