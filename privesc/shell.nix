{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils, ... }:
let
  sources = [ ];

  packages = with pkgs; [ ];

in pkgs.mkShell {
  name = "privesc";
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "PrivEsc"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
