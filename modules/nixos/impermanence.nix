{lib, kylib, inputs, config, ...}: kylib.createModule config {

  category = "sys-impermanence";

  imports = [  
    inputs.impermanence.nixosModules.impermanence
  ];

  # TODO make persistence function to clear on boot
  
  config = {
    fileSystems."/persist".neededForBoot = true;
    
    environment.persistence = {
      
      "/persist" = let 
        users = lib.attrValues config.users.users;
        homes = map (user: user.home) (users);
      in {
        hideMounts = true;
        directories = homes;
      };

      "/persist/system" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/log/"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          # Add all user home dirs to the persistence!
        ];
        files = [
          "/etc/machine-id"
        ];
      };
    };
  };
}