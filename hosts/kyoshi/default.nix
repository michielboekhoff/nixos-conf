{ pkgs, config, lib, ... }:

let
  cfg = config.dotfiles;
  gcloud = pkgs.local.google-cloud-sdk.override {
    #with-numpy = true;
  };
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
        extensions = [
          pkgs.vscode-extensions.hashicorp.terraform
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
          {
            name = "vscode-bicep";
            publisher = "ms-azuretools";
            version = "0.15.31";
            sha256 = "sha256-+GTaGFgevAPlMjMXFTuhTvP0hwBAnP1HY5NRU7dCkPw=";
          }
          {
            name = "vscode-dotnet-runtime";
            publisher = "ms-dotnettools";
            version = "1.6.0";
            sha256 = "sha256-A3m5IvPKgmF2Dix1/bHFGcrJYriYsFgRagkZNcWf/RA=";
          }
					{
						name = "html-preview-vscode";
						publisher = "george-alisson";
						version = "0.2.5";
						sha256 = "sha256-1kjhNLFRUashPYko5F7p8gNwe+heT4wKAPZiJsTqgdg=";
					}
					{
						name = "liveserver";
						publisher = "ritwickdey";
						version = "5.7.9";
						sha256 = "sha256-w0CYSEOdltwMFzm5ZhOxSrxqQ1y4+gLfB8L+EFFgzDc=";
					}
					{
						name = "copilot";
						publisher = "GitHub";
						version = "1.89.156";
						sha256 = "sha256-BJnYd9D3bWrZI8UETnAua8ngVjZJ7EXB1UrZAjVnx1E=";
					}
          pkgs.vscode-extensions.ms-dotnettools.csharp
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
