{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let configDir = config.configDir;
in {
  programs.gnome-terminal = {
    enable = true;
    themeVariant = "dark";
    profile = {
      "979d5d93-77ae-4b75-b534-4425738ae571" = {
        visibleName = "nixos";
        default = true;
      };
    };
  };
}
