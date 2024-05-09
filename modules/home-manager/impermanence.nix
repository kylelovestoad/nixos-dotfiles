{pkgs, lib, inputs, ...}: {
  imports = [  
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options = {
    impermanence.enable = lib.mkEnableOption "Enable impermanence";
  };

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
}