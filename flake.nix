{
  description = "Typst Env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    typix.url = "github:loqusion/typix";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      typix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        typixPkg = typix.lib.${system};
        fontPaths = [
          "${pkgs.inter}"
          "${pkgs.texlivePackages.haranoaji}"
        ];

        slideDir = ./slides;
        allEntries = builtins.attrNames (builtins.readDir slideDir);
        typstDirs = builtins.filter (
          d: builtins.pathExists (toString slideDir + "/" + d + "/main.typ")
        ) allEntries;

        makePackage =
          d:
          typixPkg.buildTypstProject {
            src = slideDir + ("/" + d);
            typstSource = "main.typ";
            unstable_typstPackages = import ./typstPackage.nix;
            fontPaths = fontPaths;
          };

        slidePkgs = builtins.listToAttrs (
          map (d: {
            name = d;
            value = makePackage d;
          }) typstDirs
        );
      in
      {
        packages = slidePkgs;
        devShells.default = typix.lib.${system}.devShell {
          fontPaths = fontPaths;
        };

        formatter = pkgs.nixfmt;
      }
    );
}
