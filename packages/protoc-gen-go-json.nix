{ buildGoModule, fetchFromGitHub }:

let rev = "8fbb6f3d729138a17d5a0019d8da40b39f434628";
in buildGoModule rec {
  pname = "protoc-gen-go-json";
  version = rev;

  src = fetchFromGitHub {
    owner = "mitchellh";
    repo = "protoc-gen-go-json";
    rev = "${version}";
    sha256 = "sha256-GPSVBqdCxfmDaNaNLXhKpwRJNYveDEI9UY1vOgn7GnU=";
  };

  vendorSha256 = "sha256-04IdEOdy25hAIu9wxl7ygk1Stk4rjDTBeXLr0McNMdk=";
}
