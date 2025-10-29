{
  pkgs ? import <nixpkgs> {config = {allowUnfree = false;};},
  utils,
  inputs,
}: let
  sources = [];

  packages = with pkgs; [
    holehe
    ghunt
    sherlock
    exiftool
    theharvester
    curl
    instaloader
    trufflehog
    inputs.github-recon.defaultPackage.${pkgs.system}
  ];
in
  pkgs.mkShell {
    name = "osint";
    nativeBuildInputs = packages;

    shellHook = ''
      ${utils.printHeader "OSINT"}
      ${utils.linkSources sources}
      ${utils.printPackageList packages}
    '';
  }
