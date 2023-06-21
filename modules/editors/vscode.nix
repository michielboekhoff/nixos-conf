{ lib, config, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.vscode;
	insiders = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
		src = (builtins.fetchTarball {
			url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
			sha256 = "1cahkjzrih05yifc7dka75q1xmiy0jj777bhv0c687gbsd3lmxpc";
		});
		version = "latest";
	});
  vscode-with-extensions = exts:
    let extensionsPartition = builtins.partition (ext: ext ? src) exts;
        marketPlaceExts = extensionsPartition.wrong;
        nixPkgsExts = extensionsPartition.right;
    in pkgs.vscode-with-extensions.override {
      vscodeExtensions = (pkgs.vscode-utils.extensionsFromVscodeMarketplace marketPlaceExts) ++ nixPkgsExts;
    };
in {
  options.modules.editors.vscode = {
    enable = mkBoolOpt false;
		enableInsiders = mkBoolOpt false;
    extensions = mkOption {
      default = [ ];
      type = with types; listOf (either package attrs);
      example = [{
        name = "code-runner";
        publisher = "formulahendry";
        version = "0.6.33";
        sha256 = "1cahkjzrih05yifc7dka75q1xmiy0jj777bhv0c687gbsd3lmxpc";
      }];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = let 
			deps = lib.concatMap (el: el . deps or []) cfg.extensions;
			insider = if cfg.enableInsiders then [ insiders ] else [];
			in [ (vscode-with-extensions cfg.extensions) ] ++ deps ++ insider;
  };
}
