{ config, pkgs, lib, ... }: {

  imports = [];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    aseprite
    eyedropper
    godot_4 # TODO Game dev module?
    kate
    
    libreoffice
    lunarvim
    ncdu
    nil
    jq
    nix-direnv
    nix-prefetch
    fastfetch
    nerdfonts
    parsec-bin
  #  thunderbird
    signal-desktop
    mpv

    wineWowPackages.stable
    winetricks

    peek
    piper
    prismlauncher # Make this part of a module
    nix-direnv
    kdialog
    mangohud
    github-desktop
    # Fixes github desktop?
    xdg-utils

    logisim-evolution

    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils

    kdePackages.kmail
    kdePackages.kmail-account-wizard

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    direnv.enable = true;
    git.enable = true;
    home-manager.enable = true;
    # TODO fix obs studio
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };  
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kyle/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    EDITOR = "lvim";
  };

  jetbrains.enable = lib.mkForce true;
  impermanence.homeManager.enable = lib.mkForce true;

  vscode.enable = lib.mkForce true;
  vscode.extensions = lib.mkForce true;

  catppuccin.homeManager.enable = lib.mkForce true;

  btop.enable = lib.mkForce true;
  kitty.enable = lib.mkForce true;
  discord.enable = lib.mkForce true;

  mpv.enable = lib.mkForce true;
  firefox.enable = lib.mkForce true;
  # stylix.homeManager.enable = lib.mkForce true;
}
