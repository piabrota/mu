# The mu drawing: む (*mu*), the hiragana, brushed in its three strokes, in the standard order.
# The shape of piabrota/nix-os' drawing: pirsig's logo is the kanji 無 and nix-os' is 无; this
# repository writes the same sound with no meaning of its own, in kana.
#
# Each stroke is a brush line through hand-placed points with a width at each point: the first
# stops firmly, the second comes down, ties its small loop on the left, runs along the bottom and
# rises, and the third is a short falling dot.
{ lib, pen }:
let
  # The three strokes of む, in writing order, in a 0–100 box: [x y brush width at that point].
  strokes = [
    # 1 the short horizontal, rising a little, stopped at the end
    [
      [ 14.0 31.0 5.0 ]
      [ 20.0 30.0 4.2 ]
      [ 38.0 28.4 3.2 ]
      [ 52.0 27.0 3.6 ]
      [ 57.0 27.2 5.0 ]
    ]
    # 2 down, the small loop to the left, on down, along the bottom, and up to the right
    [
      [ 35.0 11.0 6.0 ]
      [ 35.6 18.0 5.4 ]
      [ 35.4 34.0 4.6 ]
      [ 35.0 49.0 4.4 ]
      [ 31.0 55.6 3.8 ]
      [ 22.4 56.4 3.2 ]
      [ 20.6 49.6 3.0 ]
      [ 27.6 45.6 3.2 ]
      [ 35.0 50.6 3.8 ]
      [ 36.6 60.0 4.6 ]
      [ 36.0 72.0 5.4 ]
      [ 40.0 83.0 5.6 ]
      [ 51.0 88.0 5.0 ]
      [ 65.0 86.0 4.2 ]
      [ 74.0 76.0 3.6 ]
      [ 77.4 63.0 3.0 ]
      [ 71.0 66.0 1.4 ]
    ]
    # 3 the short falling dot, on the upper right
    [
      [ 68.0 26.0 4.0 ]
      [ 74.0 31.0 5.4 ]
      [ 79.0 37.0 6.2 ]
      [ 81.0 41.0 3.4 ]
    ]
  ];

  # The canvas, square, with the kana in its middle: the 0–100 box scaled by `scale` about its
  # point (48, 50). The widths of `strokes` are times `weight`, how heavy the brush is.
  side = 240.0;
  scale = 2.2;
  weight = 2.2;
  place = p: [
    (pen.fma (builtins.elemAt p 0 - 48.0) scale (side / 2.0))
    (pen.fma (builtins.elemAt p 1 - 50.0) scale (side / 2.0))
  ];
in
{
  inherit strokes;

  drawing = pen.drawing {
    w = side;
    h = side;
    label = "む (mu) brushed in its three strokes";
    desc = "Drawn from the Desmos expressions of mu.desmos.json: cubic Béziers through hand-placed points, each piece at its brush width.";
    marks = lib.concatMap
      (s: pen.brush (map place s) (map (p: builtins.elemAt p 2 * weight) s))
      strokes;
  };
}
