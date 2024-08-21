{pkgs, lib, kylib, config, ...}: (cfg: {

  options = {
    users = lib.mkOption { default = []; };
  };

  config = {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };

    users.users = kylib.addGroupsToUsers [ "wireshark" ] cfg.users;
  };
})