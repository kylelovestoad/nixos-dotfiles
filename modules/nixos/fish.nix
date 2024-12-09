{kylib, lib, pkgs, config, ...}: (cfg: {
  options = {
    users = lib.mkOption { default = []; };
  };

  config = {
    programs.fish = {
      enable = true;
    };

    users.users = kylib.addPropertiesToUsers {
      useDefaultShell = true;
      shell = pkgs.fish;
    }
    cfg.users;
  };
})