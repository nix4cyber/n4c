{
  pkgs ? import <nixpkgs> {config = {allowUnfree = false;};},
  utils,
  ...
}: let
  sources = [];

  packages = with pkgs; [];
in
  pkgs.mkShell {
    nativeBuildInputs = packages;

    shellHook = ''
      ${utils.printHeader "Reverse"}
      ${utils.linkSources sources}
      ${utils.printPackageList packages}
    '';
  }
