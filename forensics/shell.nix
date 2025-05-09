{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils, ... }:
let
  sources = [ ];

  packages = with pkgs; [ ];

in pkgs.mkShell {
  name = "forensics";
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Forensics"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
