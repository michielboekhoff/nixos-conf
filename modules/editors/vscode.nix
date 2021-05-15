{ lib, config, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.vscode;
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "terraform";
        publisher = "Hashicorp";
        version = "2.10.2";
        sha256 = "P+cHNkZMaZi4vSicgaHFlePuO9NyjMTm+g9qufyUczo=";
      }
    ];
  };
in {
  options.modules.editors.vscode = {
    enable = mkBoolOpt false;
    extensions = mkOption {
      default = [];
      type = with types; listOf either package attrs;
      example = [
        {
          name = "code-runner";
          publisher = "formulahendry";
          version = "0.6.33";
          sha256 = "166ia73vrcl5c9hm4q1a73qdn56m0jc7flfsk5p5q41na9f10lb0";
        }
      ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode-with-extensions ];
  };
}
