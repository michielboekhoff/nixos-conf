self: super:

let
  mkStudio = opts:
    super.callPackage (import ./common.nix opts) {
      fontsConf = super.makeFontsConf { fontDirectories = [ ]; };
      inherit (super.gnome2) GConf gnome_vfs;
      inherit (super) buildFHSUserEnv;
    };
  betaVersion = {
    version = "2020.3.1.23";
    sha256Hash = "UxelXWRQmMIuecNDP1UIk8uv1q5TpSeHerHTslZsshs=";
  };
in {
  androidStudioPackages.beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });
}
