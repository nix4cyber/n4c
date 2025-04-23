{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
  sources = [
    (pkgs.fetchFromGitHub {
      owner = "bryanmcnulty";
      repo = "ctf-wordlists";
      rev = "main";
      sha256 = "sha256-nquxaghw6ayX2FM0RpAXEUF+0WXntKzNxmCLckiGWyQ=";
    })
  ];

  packages = with pkgs; [ aircrack-ng ];

in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Wifi"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
