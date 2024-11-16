{lib, kylib, pkgs, config, inputs, ...}: let 
  nixvirt = inputs.nixvirt;
in (cfg: {

  imports = [
    nixvirt.nixosModules.default
  ];

  options = {
    users = lib.mkOption { default = []; };
  };

  config = {
    programs.virt-manager.enable = true;

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
    };

    users.users = kylib.addGroupsToUsers [ "libvirtd" ] cfg.users;
  };
})