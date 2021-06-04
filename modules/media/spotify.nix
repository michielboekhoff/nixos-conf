{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.media.spotify;
in {
  options.modules.media.spotify = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # This is because of the following GitHub issue
      # caused by a libnss mismatch:
      # https://github.com/NixOS/nixpkgs/issues/78961
      (pkgs.spotify-unwrapped.override {
        nss = pkgs.nss;
      })
      spotify
    ];
  };
}
