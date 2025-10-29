{
  pkgs ? import <nixpkgs> {config = {allowUnfree = false;};},
  utils,
  ...
}: let
  sources = [
    (pkgs.fetchFromGitHub {
      owner = "stealthsploit";
      repo = "OneRuleToRuleThemStill";
      rev = "main";
      sha256 = "sha256-h7MeymIXS/6wlPRt4lzsIEqOOssP0lDx9nQip65cwZw=";
    })
    (pkgs.fetchFromGitHub {
      owner = "nix4cyber";
      repo = "wordlists";
      rev = "main";
      sha256 = "sha256-ci2JtBAhqCYPbMDJWiZkQeqn1grLyNn+ZEVmSLhxOQE=";
    })
  ];

  packages = with pkgs; [
    haiti
    cyberchef
    hashcat
    hashcat-utils
    john
    thc-hydra
    medusa
    fcrackzip
    zip2hashcat
    rar2hashcat
    _7z2hashcat
  ];
in
  pkgs.mkShell {
    name = "cracking";
    nativeBuildInputs = packages;

    shellHook = ''
      ${utils.printHeader "Cracking"}
      ${utils.linkSources sources}
      ${utils.printPackageList packages}
    '';
  }
