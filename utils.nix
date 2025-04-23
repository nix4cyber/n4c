_: {
  printHeader = title: ''
    echo -e "\e[90m---\e[0m"
    echo -e "\e[33m${title}:\n\e[0m"
  '';

  printPackage = pkg: ''echo -e "\e[1m\e[1;32m(+)\e[0m ${pkg.name}\e[0m"'';

  printPackageList = packages:
    if builtins.length packages > 0 then ''
      echo -e "\e[33mPackages:\e[0m"
      ${builtins.concatStringsSep "\n    "
      (map (pkg: ''echo -e "\e[1m\e[1;32m(+)\e[0m ${pkg.name}\e[0m"'')
        packages)}
      echo
    '' else
      "";

  linkSource = source:
    let
      sourceName = source.repo or (builtins.baseNameOf source.outPath);
      targetPath = "/tmp/${sourceName}";
    in ''
      if [ ! -e ${targetPath} ]; then
        ln -sf ${source} ${targetPath}
      fi
      echo -e "\e[1m\e[1;32m[+]\e[0m ${sourceName} \e[90madded to \e[0m'${targetPath}'\e[0m"
    '';

  linkSources = sources:
    if builtins.length sources > 0 then ''
      echo -e "\e[33mFiles:\e[0m"
      ${builtins.concatStringsSep "\n    " (map (source:
        let
          sourceName = source.repo or (builtins.baseNameOf source.outPath);
          targetPath = "/tmp/${sourceName}";
        in ''
          if [ ! -e ${targetPath} ]; then
            ln -sf ${source} ${targetPath}
          fi
          echo -e "\e[1m\e[1;32m[+]\e[0m ${sourceName} \e[90madded to \e[0m'${targetPath}'\e[0m"
        '') sources)}
      echo
    '' else
      "";
}
