{ pkgs, config, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  modules.editors = {
   emacs.enable = true; 
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
