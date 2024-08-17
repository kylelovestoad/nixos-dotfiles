{pkgs, lib, config, ...}: (cfg: let 
  addGroupsToUsers = addedGroups: users: builtins.mapAttrs (user: settings: 
    if (builtins.any (wiresharkUser: wiresharkUser == user)) then let 
      extraGroupsAttr = {
        extraGroups = settings.extraGroups ++ addedGroups;
      };
    in settings // extraGroupsAttr
    else settings
  ) config.users.users;
in {

  options = {
    users = lib.mkOption { default = []; };
  };

  config = {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };

    users.users = addGroupsToUsers ["wireshark"] config.users.users;
  };
})