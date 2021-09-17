{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.podman;
in {
  options.modules.dev.podman = {
    enable = mkBoolOpt false;
    dockerCompat = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = cfg.dockerCompat;
      };
    };
  };
}
