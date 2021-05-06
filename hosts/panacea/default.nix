{ pkgs, config, lib, ... }:

let cfg = config.dotfiles;
in {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  home-manager.users.michiel = import ./home.nix { config = cfg; lib = lib; pkgs = pkgs; };

  environment.systemPackages = with pkgs; [
    google-cloud-sdk
    kubectl
    kubectx
    conftest
    my.kube-linter
  ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  modules = {
    editors = {
      emacs.enable = true;
      intellij.enable = true;
    };

    shell = {
      zsh.enable = true;
    };

    gaming = {
      lutris.enable = true;
    };
  };
}
