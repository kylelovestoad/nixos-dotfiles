{config, ... }:{

	
	# Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # boot.initrd.kernelModules = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
		# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # We have a GeForce RTX 4060 which is not in the legacy GPU list (https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/)
    # Therefore, the stable drivers should work.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      # reverseSync.enable = true;
    	offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			# sync.enable = true;

			# Make sure to use the correct Bus ID values for your system!
			nvidiaBusId = "PCI:1:0:0";
			intelBusId = "PCI:0:2:0";
		};
	};
}