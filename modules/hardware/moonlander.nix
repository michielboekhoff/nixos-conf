{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.moonlander;
in {
  options.modules.hardware.moonlander = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    hardware.keyboard.zsa.enable = true;
    environment.systemPackages = with pkgs; [ wally-cli ];
  };
}
