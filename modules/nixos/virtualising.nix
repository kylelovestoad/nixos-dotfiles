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
      libvirt = {
        connections."qemu:///system" = {
          domains = [
            {
              definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows rec {
                name = "win10";
                uuid = "4ec9575f-3fa2-4a25-9ffb-880732d82f17"; # Randomly generated
                memory = { count = 8; unit = "GiB"; };
                storage_vol = /persist/VM-Storage/${name}.qcow2;
                nvram_path = /persist/VM-Storage/${name}.nvram;
                virtio_net = true;
                virtio_drive = true;
                install_virtio = true;
              });
            }
          ];

          pool = [
            {
              definition = nixvirt.lib.domain.writeXML (nixvirt.lib.pool.getXML rec {
                name = "Pool";
                uuid = "650c5bbb-eebd-4cea-8a2f-36e1a75a8683";
                type = "dir";
                target = { path = "/persist/VM-Storage/${name}"; };
              });
            }
          ];
        };
      };
      
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