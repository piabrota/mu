{
  description = "mu, the piabrota company chart: its drawings, in pure Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      each = nixpkgs.lib.genAttrs systems;
      drawing = import ./drawings { inherit (nixpkgs) lib; };
    in
    {
      # The README drawings: eye.svg, mu.svg, mu.desmos.json and mu-check.svg.
      packages = each (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          mu-art = pkgs.linkFarm "mu-art" [
            { name = "eye.svg"; path = pkgs.writeText "eye.svg" drawing.eye; }
            { name = "mu.svg"; path = pkgs.writeText "mu.svg" drawing.svg; }
            { name = "mu.desmos.json"; path = pkgs.writeText "mu.desmos.json" drawing.desmos; }
            { name = "mu-check.svg"; path = pkgs.writeText "mu-check.svg" drawing.checkSvg; }
          ];
        });

      # The drawing's tests pass and the committed files are its output (scripts/drawing.sh).
      checks = each (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          drawing = pkgs.runCommand "mu-art-check" { } ''
            ${pkgs.lib.concatMapStrings (f: "echo 'failed: ${f.name}' >&2\n") drawing.failures}
            ${pkgs.lib.optionalString (drawing.failures != [ ]) "exit 1"}
            art=${self.packages.${system}.mu-art}
            diff -u ${./docs/drawings/eye.svg} $art/eye.svg || { echo 'run scripts/drawing.sh' >&2; exit 1; }
            diff -u ${./docs/drawings/mu.svg} $art/mu.svg || { echo 'run scripts/drawing.sh' >&2; exit 1; }
            diff -u ${./docs/drawings/mu.desmos.json} $art/mu.desmos.json || { echo 'run scripts/drawing.sh' >&2; exit 1; }
            touch $out
          '';
        });
    };
}
