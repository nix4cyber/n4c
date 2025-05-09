{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils, inputs
}:
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
    inputs.gh-recon.defaultPackage.${pkgs.system}
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
