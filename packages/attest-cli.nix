{ buildGoModule, lib }:

let rev = "438163620a3ea8595e8da549948896327d6952b1";
in buildGoModule rec {
  pname = "attest-cli";
  version = rev;

  # Using fetchGit here because the repo is private
  src = fetchGit {
    url = "git@github.com:Attest/attest-cli.git";
    rev = "${version}";
  };

  vendorSha256 = "sha256-myu6EVk5kBMlhSVnLZrHSYVtEXccLjBecjjsYSIYinw=";
}
