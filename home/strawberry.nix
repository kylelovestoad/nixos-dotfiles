{
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:
{

  imports = [ ];

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

  nix.gc.automatic = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      # packageOverrides = with pkgs; pkgs: { olympus = callPackage ../packages/olympus/olympus.nix { }; };
    };
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

    libreoffice
    imhex

    ncdu
    nil
    jq
    nix-direnv
    nix-prefetch
    fastfetch

    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

    parsec-bin
    #  thunderbird
    signal-desktop
    mpv

    wineWowPackages.stable
    winetricks

    peek
    piper
    prismlauncher # Make this part of a future minecraft module
    nix-direnv

    github-desktop
    # Fixes github desktop?
    xdg-utils

    logisim-evolution

    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils

    mouse_m908

    obsidian
    # olympus

    teams-for-linux

    nixfmt-rfc-style
    linux-manual
    man-pages
    man-pages-posix

    remmina

    pkgs-unstable.freetube

    imhex

    spotify

    # Fixes android phone not mounting
    kdePackages.kio-extras

    android-tools

    love

    inputs.nix-software-center.packages.${system}.nix-software-center

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
    ssh.addKeysToAgent = "yes";
    direnv.enable = true;
    git.enable = true;
    home-manager.enable = true;
  };

  # dconf.settings = {
  #  "/org/gnome/desktop/interface" = {
  #     monospace-font-name = "Inter";
  #   };
  # };

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

  services.gpg-agent.enable = true;

  programs.gpg.enable = true;

  home.sessionVariables = {
    # ENVVARS
  };

  jetbrains.enable = lib.mkForce true;
  jetbrains.clion = lib.mkForce true;
  jetbrains.idea = lib.mkForce true;
  # jetbrains.goland = lib.mkForce true;
  jetbrains.pycharm = lib.mkForce true;
  jetbrains.rider = lib.mkForce true;
  jetbrains.rustrover = lib.mkForce true;
  # jetbrains.webstorm = lib.mkForce true;

  # impermanence.enable = lib.mkForce true;

  vscode.enable = lib.mkForce true;
  vscode.extensions = lib.mkForce true;

  catppuccin-theme.enable = lib.mkForce true;

  btop.enable = lib.mkForce true;
  kitty.enable = lib.mkForce true;
  discord.enable = lib.mkForce true;

  mpv.enable = lib.mkForce true;
  firefox.enable = lib.mkForce true;

  emacs.enable = lib.mkForce true;
  # stylix-theming.enable = lib.mkForce true;

  cargo.enable = lib.mkForce true;
  obs.enable = lib.mkForce true;

  plasma.enable = lib.mkForce true;
  # gnome.enable = lib.mkForce true;

  fish.enable = lib.mkForce true;
  bat.enable = lib.mkForce true;
}
