{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.aws;
in {
  options.modules.dev.aws = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ awscli2 ]; };
}
