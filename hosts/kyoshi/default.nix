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
     discord
     ssm-session-manager-plugin
     xclip
     my.protoc-gen-go-json
     vim
   ];

   shellAliases = {
     github = "cd ~/git/github.com";
     gitroot = "cd ~/git";
     aws-login =
       "aws-google-auth -I C03163stn -S 533705401937 -R eu-west-1 -d 28800 --resolve-aliases --username michiel.boekhoff@askattest.com --profile sso --ask-role; export AWS_PROFILE=sso";
   };
 };

 # To use the Yubikey as a smart card
 services.pcscd.enable = true;

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
         {
           name = "python";
           publisher = "ms-python";
           version = "2022.5.10891003";
           sha256 = lib.fakeSha256;
         }
       ];
     };
   };

   shell = { zsh.enable = true; };

   torrent = { qbittorrent.enable = true; };

   dev = {
     terraform.enable = true;
     aws.enable = true;
     docker = {
       enable = true;
       docker-compose = true;
     };
   };

   media = { spotify.enable = true; };

   hardware.scanning.enable = true;
 };
}
