# The README drawing, む, in pure Nix: `svg`, `desmos` and `checkSvg` are the files' text,
# `failures` the tests that failed (lib.runTests), empty when all pass.
{ lib }:
let
  pen = import ./pen.nix { inherit lib; };
  mu = import ./mu.nix { inherit lib pen; };
  near = a: b: (if a < b then b - a else a - b) < 1.0e-9;
  bz = [ [ 0.0 0.0 ] [ 10.0 30.0 ] [ 40.0 (-10.0) ] [ 50.0 20.0 ] ];
  inherit (builtins) elemAt;
  first = s: elemAt s 0;
  last = s: elemAt s (builtins.length s - 1);
  stroke = elemAt mu.strokes;
  col = k: p: elemAt p k;
in
{
  inherit (mu.drawing) svg desmos checkSvg;
  eye = import ./eye.nix;

  failures = lib.runTests {
    testNumbersAreShort = {
      expr = map pen.num [ 12.0 (-3.5) 0.1234 (-0.0001) ];
      expected = [ "12" "-3.5" "0.123" "0" ];
    };
    testAPolynomialReadsBack = {
      expr = let s = pen.poly [ 12.5 (-3.0) 0.0 0.25 ]; in [ s (pen.parsePoly s) ];
      expected = [ "12.5-3t+0.25t^{3}" [ 12.5 (-3.0) 0.0 0.25 ] ];
    };
    testAPartIsTheSameCurve = {
      expr = builtins.all
        (k:
          let
            s = k / 4.0;
            p = pen.at (pen.part bz 0.25 0.75) s;
            q = pen.at bz (0.5 * s + 0.25);
          in
          near (col 0 p) (col 0 q) && near (col 1 p) (col 1 q))
        (lib.range 0 4);
      expected = true;
    };
    testThePowerFormIsTheBezier = {
      # Midpoint of a cubic Bézier: (p0 + 3p1 + 3p2 + p3) / 8.
      expr = let cx = elemAt (pen.coeffs bz) 0; in
        near (pen.evalPoly cx 0.5) 25.0 && near (pen.evalPoly cx 1.0) 50.0;
      expected = true;
    };
    testMuHasItsThreeStrokesInOrder = {
      expr = [
        (builtins.length mu.strokes)
        # the second stroke starts above the first and ends below it
        (col 1 (first (stroke 1)) < col 1 (first (stroke 0)))
        (col 1 (last (stroke 1)) > col 1 (last (stroke 0)))
        # the dot sits on the right of the second stroke's start
        (col 0 (first (stroke 2)) > col 0 (first (stroke 1)))
      ];
      expected = [ 3 true true true ];
    };
    # Every Desmos expression, read back from its LaTeX, stays within 0.01 of its line.
    testTheDesmosFileIsTheDrawing = {
      expr = mu.drawing.worstSquared < 0.01 * 0.01;
      expected = true;
    };
  };
}
