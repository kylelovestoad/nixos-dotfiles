{lib, kylib, inputs, config, ...}: let 
  category = "sys-impermanence";
in kylib.mkModule config category (cfg: {

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
          # TODO Add all user home dirs to the persistence!
        ];
        # files = [
        #   "/etc/machine-id"
        # ];
      };
    };
  };
})