{ pkgs ? import <nixpkgs> { config = { allowUnfree = false; }; }, utils }:
let
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

  packages = with pkgs; [ hashid cyberchef hashcat hashcat-utils john ];

in pkgs.mkShell {
  nativeBuildInputs = packages;

  shellHook = ''
    ${utils.printHeader "Cracking"}
    ${utils.linkSources sources}
    ${utils.printPackageList packages}
  '';
}
