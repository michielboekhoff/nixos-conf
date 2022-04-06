{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
with lib.types;
let cfg = config.modules.hardware.printing;
in {
  options.modules.hardware.printing = {
    enable  = mkBoolOpt false;
    drivers = mkOpt (types.listOf types.package) [];
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable  = true;
      drivers = cfg.drivers;
    };
  };
}
