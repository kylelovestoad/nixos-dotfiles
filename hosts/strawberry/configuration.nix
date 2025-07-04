# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  users.extraGroups.vboxusers.members = [ "kyle" ];

  networking.hostName = "strawberry"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Fixes github-desktop
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Configure X11
  services = {
    ratbagd.enable = true;
    resolved.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      xkb = {
        variant = "";
        layout = "us";
      };
    };
  };

  # programs.ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  services.fwupd.enable = true; # For viewing kde firmware security

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = false;
  };

  services.displayManager.sddm = {
    enable = true;
    # package = pkgs.kdePackages.sddm;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kyle = {
    isNormalUser = true;
    description = "kyle";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # packages = with pkgs; [];
  };

  #env variables (pam)
  environment.sessionVariables = { };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    home-manager
    git
    lshw
    pciutils
    alsa-oss # TODO fixes issues with minecraft make dedicated minecraft/prismlauncher config
    lm_sensors
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides =
        with pkgs;
        pkgs: {
          olympus = callPackage ../packages/olympus/olympus.nix { };
        };
    };
  };

  services.udev.packages = with pkgs; [
    mouse_m908
    android-udev-rules
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs = {
    ssh.startAgent = true;
    nix-ld.enable = true;
  };

  # Modules
  # plasma5.enable = true;
  plasma6.enable = true;
  # gnome.enable = true;
  # cosmic.enable = true;
  # impermanence.enable = true;
  catppuccin-theme.enable = true;
  gaming.enable = true;
  wireshark.enable = true;
  wireshark.users = [ "kyle" ];
  virtualising.enable = true;
  virtualising.users = [ "kyle" ];
  fish.enable = true;
  fish.users = [ "kyle" ];
  ollama.enable = true;
}
