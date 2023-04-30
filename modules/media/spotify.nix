{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.media.spotify;
in {
  options.modules.media.spotify = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
