{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
  sources = [ ];

  packages = with pkgs; [ ];

in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Example"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
