{lib, kylib, pkgs, config, inputs, ...}: (cfg: {

  imports = [];

  options = {
    users = lib.mkOption { default = []; };
  };

  config = {
    programs.virt-manager.enable = true;

    # Fixes virtualbox issues where VM won't start due to KVM being enabled (?)
    boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

    virtualisation = { 
      libvirtd = {
        enable = true;
        qemu = {  
          package = pkgs.qemu_kvm;
          runAsRoot = false;
          # Necessary for Windows 11 
          swtpm.enable = true;
          # For UEFI booting
          ovmf = {
            enable = true;
            packages = [(pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd];
          };
        };
      };

      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };

        guest = {
          enable = true;
        };
      };

      docker.enable = true;
    };

    users.users = kylib.addGroupsToUsers [ "libvirtd" ] cfg.users;
  };
})