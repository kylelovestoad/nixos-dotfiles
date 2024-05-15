{lib, kylib, inputs, config, ...}: let 
  # cfg = config.sys-impermanence;
  modulePath = ["sys-impermanence"];
  # TODO try appending result of setAttrByPath to config and options (effectively extending a)
in {
  imports = [  
    inputs.impermanence.nixosModules.impermanence
  ];

  # TODO make persistence function to clear on boot

  options = {
    ${lib.setAttrByPath modulePath {}}.enable = lib.mkEnableOption "Enable impermanence";
  };
  
  config = lib.mkIf (kylib.extendAttrByPath config modulePath).enable {
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