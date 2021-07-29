{ config, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.android-studio;
in {
  options.modules.editors.android-studio = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ androidStudioPackages.beta ];
  };
}
