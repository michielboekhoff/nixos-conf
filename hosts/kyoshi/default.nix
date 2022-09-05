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
     vim
   ];

   shellAliases = {
     github = "cd ~/git/github.com";
     gitroot = "cd ~/git";
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
           version = "2.23.0";
           sha256 = "sha256-3v2hEf/cEd7NiXfk7eJbmmdyiQJ7bWl9TuaN+y5k+e0=";
         }
         {
           name = "vscode-docker";
           publisher = "ms-azuretools";
           version = "1.22.1";
           sha256 = "sha256-okR1mmwg1ZEUfP924LTa98LxCenwDZ1BIS/FLt0wo8c=";
         }
         {
           name = "python";
           publisher = "ms-python";
           version = "2022.11.12011103";
           sha256 = "sha256-VGAMbg2Gwdi0PST+EdKMY5Cuw5GUMUJcZoN4SSSMOIk=";
         }
         {
           name = "direnv";
           publisher = "mkhl";
           version = "0.6.1";
           sha256 = "5/Tqpn/7byl+z2ATflgKV1+rhdqj+XMEZNbGwDmGwLQ=";
         }
       ];
     };
   };

   shell = {
     zsh.enable = true;
     kitty.enable = true;
   };

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

   hardware = {
     moonlander.enable = true;
     scanning.enable = true;
     printing = {
       enable = true;
       drivers = with pkgs; [ brgenml1cupswrapper brgenml1lpr ];
     };
   };
 };
}
