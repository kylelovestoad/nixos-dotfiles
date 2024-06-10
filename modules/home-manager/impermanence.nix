{kylib, inputs, config, ...}: kylib.createModule config {

  category = "home-impermanence";

  imports = [  
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  config = {

    home.persistence."/persist/home" = {
      allowOther = true;
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