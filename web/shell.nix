{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; }; }, utils }:
let
  sources = [
    (pkgs.fetchFromGitHub {
      owner = "susukin0";
      repo = "gobuster-wordlist";
      rev = "main";
      sha256 = "sha256-4soBZLuIUXf9tBSzvgmeA5GFI9unfql55ZAmSIzemL0=";
    })

    (pkgs.fetchFromGitHub {
      owner = "bryanmcnulty";
      repo = "ctf-wordlists";
      rev = "main";
      sha256 = "sha256-nquxaghw6ayX2FM0RpAXEUF+0WXntKzNxmCLckiGWyQ=";
    })
  ];

  packages = with pkgs; [
    gobuster
    dirb
    whois
    sqlmap
    burpsuite
    katana
    jq
    httrack
    ffuf
    subfinder
  ];
in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Web"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
