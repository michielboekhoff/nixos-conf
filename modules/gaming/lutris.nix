{ config, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.gaming;
in {

  options = {
    modules.gaming.lutris.enable = mkBoolOpt false;
  };

  config = mkIf cfg.lutris.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
