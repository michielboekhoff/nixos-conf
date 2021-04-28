{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors;
in {
  options.modules.editors = {
    default = mkOpt types.str "emacs";
  };

  config = mkIf (cfg.default != null) {
    environment.variables.EDITOR = cfg.default;
  };
}
