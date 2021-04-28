{ pkgs, config, lib, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  modules.editors = {
   emacs.enable = true; 
  };
}
