{lib, pkgs, config, inputs, ...}: (cfg: {

  import = [
    inputs.NixVirt.homeManagerModules.NixVirt
  ];

  config = {
    programs.virt-manager.enable = true;

    virtualisation.libvirt.connections."qemu:///session".domains = [
      {
        definition = lib.domain.writeXML (lib.domain.templates.windows rec {
          name = "win10";
          uuid = "def734bb-e2ca-44ee-80f5-0ea0f2593aaa";
          memory = { count = 8; unit = "GiB"; };
          storage_vol = { pool = "MyPool"; volume = "${name}.qcow2"; };
          install_vol = /home/${config.home.username}/VM-Storage/Win11_23H2_EnglishInternational_x64v2.iso;
          nvram_path = /home/${config.home.username}/VM-Storage/${name}.nvram;
          virtio_net = true;
          virtio_drive = true;
          install_virtio = true;
        });
      }
    ];
  };
})