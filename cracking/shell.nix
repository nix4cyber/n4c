{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
  sources = [ ];

  packages = with pkgs; [ hashid cyberchef hashcat hashcat-utils john ];

in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Cracking"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
