{ buildGoModule, fetchFromGitHub, graphviz }:

let rev = "87002e6b0a85e6050fae6dda0b276efb53e56bbd";
in buildGoModule rec {
  pname = "terravision";
  version = rev;

  src = fetchFromGitHub {
    owner = "patrickchugh";
    repo = "terravision";
    rev = "${version}";
    sha256 = "sha256-eaHcikLQBcSSZn2ewPGSaJJINIR785uXIEUvpGjE+KA=";
  };

	nativeBuildInputs = [ graphviz ];

  vendorHash = "sha256-04IdEOdy25hAIu9wxl7ygk1Stk4rjDTBeXLr0McNMdk=";
}
