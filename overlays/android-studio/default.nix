self: super:

let
  mkStudio = opts:
    super.callPackage (import ./common.nix opts) {
      fontsConf = super.makeFontsConf { fontDirectories = [ ]; };
      inherit (super.gnome2) GConf gnome_vfs;
      inherit (super) buildFHSUserEnv;
    };
  betaVersion = {
    version = "2020.3.1.22";
    sha256Hash = "Stt7mHbtelmuEt5cv+ekAuHAe+kVpKUWoy/vHTC0cnY=";
  };
in {
  androidStudioPackages.beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });
}
