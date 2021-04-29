{ config, lib, pkgs, home-manager, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.zsh;
configDir = config.dotfiles.configDir;
in {
  options.modules.shell.zsh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        theme = "agnoster";
        enable = true;
      };
    };

    user.packages = with pkgs; [
      fzf
      nix-zsh-completions
    ];

    # Might want to do this - might be quite useful.
    # home.configFile = {
      #   # Write it recursively so other modules can write files to it
      #   "zsh" = { source = "${configDir}/zsh"; recursive = true; };
      # };
      #


  };
}
