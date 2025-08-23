{
  # https://github.com/nix4cyber/n4c
  description = "nix4cyber";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    github-recon.url = "github:anotherhadi/github-recon";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    utils = import ./utils.nix {inherit pkgs;};

    # Automatically detect directories containing shell.nix files
    isDirectory = path: builtins.pathExists (path + "/shell.nix");

    # Get a list of all entries in the repo root
    allEntries = builtins.attrNames (builtins.readDir ./.);

    # Filter to only include directories that have a shell.nix file
    dirs = builtins.filter (dir:
      dir
      != "example"
      && builtins.pathExists (./. + "/${dir}/shell.nix")
      && builtins.isAttrs (builtins.readDir (./. + "/${dir}")))
    allEntries;

    loadShell = name: {
      inherit name;
      value = import ./${name}/shell.nix {inherit pkgs inputs utils;};
    };

    shells = builtins.listToAttrs (map loadShell dirs);
    allBuildInputs = builtins.concatLists (map (name:
      (import ./${name}/shell.nix {
        inherit pkgs inputs utils;
      }).nativeBuildInputs or [
      ])
    dirs);
    combineShellHooks = builtins.concatStringsSep "\n" (map (name: let
      shell = import ./${name}/shell.nix {inherit pkgs utils inputs;};
    in
      shell.shellHook or "")
    dirs);
  in {
    lib = {inherit utils;};
    devShells.${system} =
      shells
      // {
        all = pkgs.mkShell {
          nativeBuildInputs = allBuildInputs;
          shellHook = combineShellHooks;
        };
      };
  };
}
