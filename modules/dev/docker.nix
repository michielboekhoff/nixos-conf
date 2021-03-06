{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.docker;
in {
  options.modules.dev.docker = {
    enable = mkBoolOpt false;
    docker-compose = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${config.user.name}.extraGroups = [ "docker" ];
    environment.systemPackages = with pkgs; mkIf cfg.docker-compose [ docker-compose ];
  };
}
