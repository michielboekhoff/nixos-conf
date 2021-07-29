{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware.system76.enableAll = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules =
    [ "dm-snapshot" "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.yubikeySupport = true;

  boot.initrd.luks.devices = {
    "nixos-enc" = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
      yubikey = {
        slot = 2;
        twoFactor = true;
        storage = { device = "/dev/nvme0n1p1"; };
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fdb17b05-f1e1-4c74-b578-057c6f0d5637";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C716-C5B4";
    fsType = "vfat";
  };

  fileSystems."/data" = {
    device = "/dev/sda1";
    fsType = "ntfs";
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  modules.hardware = { nvidia.enable = true; };
}
