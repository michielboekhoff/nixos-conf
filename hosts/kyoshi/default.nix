{ pkgs, config, lib, ... }:

let
  cfg = config.dotfiles;
in {
  imports = [ ./configuration.nix ./hardware-configuration.nix ];

  home-manager.users.michiel = import ./home.nix {
    inherit lib;
    inherit pkgs;
    config = cfg;
  };

  environment = {
    systemPackages = with pkgs; [
      kubectl
      kubectx
      google-chrome
			firefox
      discord
      ssm-session-manager-plugin
      xclip
      vim
			nil
			plasma-nm
      my.protoc-gen-go-json
			my.bicep
    ];

    shellAliases = {
      github = "cd ~/git/github.com";
      gitroot = "cd ~/git";
    };
  };

  # To use the Yubikey as a smart card
  services.pcscd.enable = true;
	services.plex.enable = true;

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
				enableInsiders = true;
        extensions = with pkgs; [
          vscode-marketplace.hashicorp.terraform
					vscode-marketplace.ms-azuretools.vscode-docker
					vscode-marketplace.ms-python.python
					vscode-marketplace.mkhl.direnv
					vscode-marketplace.ms-dotnettools.vscode-dotnet-runtime
					vscode-marketplace.github.copilot
					vscode-marketplace.ms-vscode-remote.remote-containers
					vscode-marketplace.vscodevim.vim
					vscode-marketplace.editorconfig.editorconfig
					vscode-marketplace.graphql.vscode-graphql
					vscode-marketplace.graphql.vscode-graphql-syntax
					vscode-marketplace.ms-azuretools.vscode-azurefunctions

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
