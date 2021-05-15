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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source ${./p10k.zsh}
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.2.0";
          sha256 = "1gfyrgn23zpwv1vj37gf28hf5z0ka0w5qm6286a7qixwv7ijnrx9";
        };
      }
    ];
  };
}
