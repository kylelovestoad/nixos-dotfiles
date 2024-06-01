{pkgs, config, libs, ... }:{

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.prime = {
    offload = {
			enable = true;
			enableOffloadCmd = true;
		};

		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:1:0:0";
		nvidiaBusId = "PCI:0:2:0";
	};
}