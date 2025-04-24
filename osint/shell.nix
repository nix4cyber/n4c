{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
  sources = [ ];

  packages = with pkgs; [
    holehe
    sherlock
    exiftool
    theharvester
    curl
    instaloader
    recon-ng
    trufflehog
  ];
in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "OSINT"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
