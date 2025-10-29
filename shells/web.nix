{
  pkgs ? import <nixpkgs> {config = {allowUnfree = true;};},
  utils,
  ...
}: let
  sources = [
    (pkgs.fetchFromGitHub {
      owner = "susukin0";
      repo = "gobuster-wordlist";
      rev = "main";
      sha256 = "sha256-4soBZLuIUXf9tBSzvgmeA5GFI9unfql55ZAmSIzemL0=";
    })
    (pkgs.fetchFromGitHub {
      owner = "nix4cyber";
      repo = "wordlists";
      rev = "main";
      sha256 = "sha256-ci2JtBAhqCYPbMDJWiZkQeqn1grLyNn+ZEVmSLhxOQE=";
    })
  ];

  packages = with pkgs; [
    gobuster
    dirb
    whois
    sqlmap
    # freerdp
    # lftp
    # iredis
    # smbmap
    # smbclient-ng
    # mysql84
    # responder
    # awscli
    katana
    jq
    httrack
    ffuf
    subfinder
  ];
in
  pkgs.mkShell {
    name = "web";
    nativeBuildInputs = packages;

    shellHook = ''
      ${utils.printHeader "Web"}
      ${utils.linkSources sources}
      ${utils.printPackageList packages}
    '';
  }
