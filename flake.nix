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
    # The utils.nix file location remains unchanged
    utils = import ./shells/utils.nix {inherit pkgs;};

    # Read all entries in the ./shells directory
    allShellFiles = builtins.attrNames (builtins.readDir ./shells);

    # Filter to only include actual files ending with ".nix" (e.g., web.nix, forensics.nix)
    shellNames =
      builtins.filter (name:
        builtins.match ".*\\.nix" name
        != null
        && builtins.isPath (./shells + "/${name}")) # Ensure it's a file path
      
      allShellFiles;

    # Function to load a shell
    loadShell = filename: {
      # Use the filename (without the .nix extension) as the attribute name (e.g., "web" or "forensics")
      name = builtins.substring 0 (builtins.stringLength filename - 4) filename;
      # Import the shell file directly from ./shells
      value = import (./shells + "/${filename}") {inherit pkgs inputs utils;};
    };

    # Create the attribute set of all individual development shells
    shells =
      builtins.listToAttrs (map loadShell shellNames)
      // {
        dev = pkgs.mkShell {
          nativeBuildInputs = [pkgs.hugo pkgs.bun];
          shellHook =
            # bash
            ''
              [[ -f "package.json" ]] || { echo "You're not in the N4C root folder"; exit 1; }
              [[ -d "node_modules" ]] || ${pkgs.bun}/bin/bun install
              ${pkgs.bun}/bin/bun dev
              exit
            '';
        };
      };

    # Combine all nativeBuildInputs from every shell file
    allBuildInputs = builtins.concatLists (map (filename:
      (import (./shells + "/${filename}") {
        inherit pkgs inputs utils;
      }).nativeBuildInputs or [
      ])
    shellNames);

    # Combine all shellHook strings from every shell file
    combineShellHooks = builtins.concatStringsSep "\n" (map (filename: let
      shell = import (./shells + "/${filename}") {inherit pkgs utils inputs;};
    in
      shell.shellHook or "")
    shellNames);
  in {
    lib = {inherit utils;};
    devShells.${system} =
      shells
      // {
        # The combined "all" shell
        all = pkgs.mkShell {
          nativeBuildInputs = allBuildInputs;
          shellHook = combineShellHooks;
        };
        default = pkgs.mkShell {
          nativeBuildInputs = allBuildInputs;
          shellHook = combineShellHooks;
        };
      };
  };
}
