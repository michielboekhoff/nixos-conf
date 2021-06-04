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
    teams
    hexchat
  ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  modules = {
    editors = {
      emacs.enable = true;
      intellij.enable = true;
      vscode = {
        enable = true;
        extensions = [
          {
            name = "terraform";
            publisher = "Hashicorp";
            version = "2.10.2";
            sha256 = "P+cHNkZMaZi4vSicgaHFlePuO9NyjMTm+g9qufyUczo=";
          }
          {
            name = "vscode-docker";
            publisher = "ms-azuretools";
            version = "1.12.1";
            sha256 = "cw2PyYDNG9mUNkKlYCfydi7OkAWSLHo6dS776YEQagU=";
          }
        ];
      };
    };

    shell = {
      zsh.enable = true;
    };

    gaming = {
      lutris.enable = true;
    };

    torrent = {
      qbittorrent.enable = true;
    };

    dev = {
      terraform.enable = true;
      aws.enable = true;
    };

    media = {
      spotify.enable = true;
    };
  };
}
