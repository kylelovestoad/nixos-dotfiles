{lib, config, pkgs, ...}: (cfg: {
  config = {

    home.packages = with pkgs; [
      gnomeExtensions.tray-icons-reloaded
      liberation_ttf
      gnome.cheese
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false; # enables user extensions
          enabled-extensions = [
            # Put UUIDs of extensions that you want to enable here.
            # If the extension you want to enable is packaged in nixpkgs,
            # you can easily get its UUID by accessing its extensionUuid
            pkgs.gnomeExtensions.tray-icons-reloaded.extensionUuid
          ];
        };
      };
    };
  };
})