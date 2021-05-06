{ config, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors;
in {
  options = {
   modules.editors.intellij.enable = mkBoolOpt false;
  };

  config = mkIf cfg.intellij.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-community
    ];
  };
}
