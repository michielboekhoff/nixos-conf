{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let configDir = config.dotfiles.configDir;
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

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      # {
      #   name = "powerlevel10k-config";
      #   src = lib.cleanSource "${configDir}/config/p10k/.p10k.zsh";
      #   file = "p10k.zsh";
      # }
    ];
  };
}
