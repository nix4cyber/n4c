{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
  sources = [ ];
  packages = with pkgs; [ binwalk exiftool foremost exif ];

in pkgs.mkShell {
  name = "stegano";
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Stegano"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
