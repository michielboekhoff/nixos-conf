{ config, lib, pkgs, home-manager, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.kitty;
in {
  options.modules.shell.kitty = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    home-manager.users."${config.user.name}".programs.kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.nerdfonts;
        size = 12;
      };
      keybindings = {
        "kitty_mod+t" = "new_tab_with_cwd";
      };
    };
  };
}
