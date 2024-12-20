{lib, config, pkgs, ...}: (cfg: {
  config = lib.mkIf cfg.enable {

    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = (pkgs: with pkgs; [
          gamemode
        ]);
      };
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      # gamescopeSession.enable = true;
    }; 

    environment.systemPackages = with pkgs; [
      mangohud
      protonup
    ];

    programs.gamemode.enable = true;

    environment.sessionVariables = {
      GAMEMODERUNEXEC="nvidia-offload";
    };

  };
})