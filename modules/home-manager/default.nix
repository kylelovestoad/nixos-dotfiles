# Contains all home manager modules which can be toggled on and off
{...}: {
  imports = [
    ./development

    ./btop.nix
    ./catppuccin.nix
    ./discord.nix
    ./impermanence.nix
    ./kitty.nix
    ./mpv.nix
    ./firefox.nix
    # ./stylix.nix
  ];
 
  # TODO ./firefox.nix
}
