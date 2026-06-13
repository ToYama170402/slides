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
        fontPaths = [
            "${pkgs.inter}"
            "${pkgs.texlivePackages.haranoaji}"
        ];
      in
      {
        packages."git" = typix.lib.${system}.buildTypstProject {
          src = ./git/.;
          typstSource = "main.typ";
          unstable_typstPackages = [
            {
              name = "fletcher";
              version = "0.5.8";
              hash = "sha256-kKVp5WN/EbHEz2GCTkr8i8DRiAdqlr4R7EW6drElgWk=";
            }
            {
              name = "cetz";
              version = "0.3.4";
              hash = "sha256-5w3UYRUSdi4hCvAjrp9HslzrUw7BhgDdeCiDRHGvqd4=";
            }
            {
              name = "oxifmt";
              version = "0.2.1";
              hash = "sha256-8PNPa9TGFybMZ1uuJwb5ET0WGIInmIgg8h24BmdfxlU=";
            }
            {
              name = "touying";
              version = "0.7.4";
              hash = "sha256-G7Z+7o6SQjRa63DCLXcSNAtzohrk4Kljk4pSb4rJfeU=";
            }
            {
              name = "uniwarn";
              version = "0.1.1";
              hash = "sha256-alpI7IgUJfjxDy6KXlPGX2N9KMEHPms/pbxXHRJrmZw=";
            }
            {
              name = "codly";
              version = "1.3.0";
              hash = "sha256-WcqvySmSYpWW+TmZT7TgPFtbEHA+bP5ggKPll0B8fHk=";
            }
            {
              name = "codly-languages";
              version = "0.1.1";
              hash  = "sha256-TSp3unFhn3NSaWhWYZb/i3rD4OolbNZNTdQeBxJ4Jfs=";
            }
          ];
          fontPaths = fontPaths;
        };

        devShells.default = typix.lib.${system}.devShell {
          fontPaths = fontPaths;
        };

        formatter = pkgs.nixfmt;
      }
    );
}
