{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.terraform;
		terraformls = let
			version = "0.31.2";
			src = pkgs.fetchFromGitHub {
				owner = "hashicorp";
				repo = "terraform-ls";
				rev = "v${version}";
				sha256 = "sha256-VqyRD2G+5L79Wm4JrZ2/PC8VeT+j/p0d22ZO5hy1Pf0=";
			};
		in
			pkgs.terraform-ls.override {
				buildGoModule = args: pkgs.buildGoModule ( args // {
					inherit src version;
					vendorSha256 = "sha256-s881Wtds33Q/Rh6sH3lHWotX3eVVs9ogzJaOjtJ8s4U=";
					ldflags = [ "-s" "-w" ];
					doInstallCheck = false;
				});
			};
in {
  options.modules.dev.terraform = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ terraform terraformls ];
  };
}
