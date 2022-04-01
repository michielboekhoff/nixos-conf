{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.scanning;
in {
  options.modules.hardware.scanning = {
    enable  = mkBoolOpt false;
    network = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.sane.enable = true;

    users.users.${config.user.name}.extraGroups = [ "scanner" "lp" ];
  };
}
