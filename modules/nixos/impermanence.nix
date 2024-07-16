{lib, kylib, inputs, config, ...}: kylib.mkModule config "impermanence.system" (cfg: {

  imports = [  
    inputs.impermanence.nixosModules.impermanence
  ];

  # TODO make persistence function to clear on boot
  
  config = {

    programs.fuse.userAllowOther = true;

    fileSystems."/persist".neededForBoot = true;
    
    environment.persistence = {
      
      "/persist/system" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
        ];
        # files = [
        #   "/etc/machine-id"
        # ];
      };
    };
  };
})