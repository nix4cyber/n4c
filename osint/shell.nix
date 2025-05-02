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
    trufflehog
  ];
in pkgs.mkShell {
  name = "osint";
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "OSINT"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
