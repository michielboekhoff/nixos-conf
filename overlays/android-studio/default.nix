self: super:

let
  mkStudio = opts:
    super.callPackage (import ./common.nix opts) {
      fontsConf = super.makeFontsConf { fontDirectories = [ ]; };
      inherit (super.gnome2) GConf gnome_vfs;
      inherit (super) buildFHSUserEnv;
    };
  betaVersion = {
    version = "2020.3.1.20";
    sha256Hash = "0swcsjx29ar4b0c8yhbynshqdn2sv94ga58h2nrc99927vp17g85";
  };
in {
  androidStudioPackages.beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });
}
