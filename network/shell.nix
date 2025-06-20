{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils, ... }:
let
  sources = [
    (pkgs.fetchFromGitHub {
      owner = "nix4cyber";
      repo = "wordlists";
      rev = "main";
      sha256 = "sha256-ci2JtBAhqCYPbMDJWiZkQeqn1grLyNn+ZEVmSLhxOQE=";
    })
  ];

  packages = with pkgs; [
    aircrack-ng
    hashcat
    hcxdumptool
    hcxtools
    tcpdump
    masscan
    nmap
    wireshark
    tshark
  ];

in pkgs.mkShell {
  name = "network";
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Network"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
