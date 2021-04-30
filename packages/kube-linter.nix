{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "kube-linter";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "stackrox";
    repo = "kube-linter";
    rev = "${version}";
    sha256 = "M2WwnX6AiV/kmd6O38XRf7Ue+IcO368GTbSHXqdaNKo=";
  };

  modSha256 = "tydzqg8p2d514sdb34b2p6k1474nr1drrn3gay2cpyhrj5l51cj3";
  vendorSha256 = "Kbpw8vwzux3whk3XAyAEdMPpwHybHXdZ3NgvabgLhk4=";

  subPackages = [ "cmd/kube-linter" ];

  meta = with lib; {
    description = "KubeLinter is a static analysis tool that checks Kubernetes YAML files and Helm charts to ensure the applications represented in them adhere to best practices. ";
    homepage = "https://github.com/stackrox/kube-linter";
    license = licenses.asl20;
    maintainers = with maintainers; [ michielboekhoff ];
    platforms = platforms.linux;
  };
}
