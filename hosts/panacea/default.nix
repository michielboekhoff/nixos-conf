{ pkgs, config, lib, ... }:

let cfg = config.dotfiles;
in {
  imports = [ ./configuration.nix ./hardware-configuration.nix ];

  home-manager.users.michiel = import ./home.nix {
    inherit lib;
    inherit pkgs;
    config = cfg;
  };

  environment = {
    systemPackages = with pkgs; [
      google-cloud-sdk
      kubectl
      kubectx
      teams
      zoom-us
      google-chrome
      hexchat
      discord
      ssm-session-manager-plugin
    ];

    shellAliases = {
      github = "cd ~/git/github.com";
      gitroot = "cd ~/git";
    };
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # To use the Yubikey as a smart card
  services.pcscd.enable = true;

  programs.steam.enable = true;

  modules = {
    editors = {
      emacs = {
        enable = true;
        daemon = true;
      };
      intellij.enable = true;
      vim.enable = true;
      android-studio.enable = true;
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

    shell = { zsh.enable = true; };

    gaming = { lutris.enable = true; };

    torrent = { qbittorrent.enable = true; };

    dev = {
      terraform.enable = true;
      aws.enable = true;
    };

    media = { spotify.enable = true; };
  };
}
