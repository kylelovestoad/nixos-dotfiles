{lib, inputs, config, ...}: let 
  cfg = config.sys-impermanence;
in {
  imports = [  
    inputs.impermanence.nixosModules.impermanence
  ];

  # TODO make persistence function to clear on boot

  options = {
    sys-impermanence.enable = lib.mkEnableOption "Enable impermanence";
  };
  
  config = lib.mkIf cfg.enable {
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