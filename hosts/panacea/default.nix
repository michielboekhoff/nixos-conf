{ pkgs, config, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  home-manager.users.michiel = import ./home.nix;

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  modules = {
    editors = {
      emacs.enable = true;
    };

    shell = {
      zsh.enable = true;
    };
  };
}
