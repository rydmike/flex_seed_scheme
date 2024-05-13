// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:core';
import 'dart:math' as math;

import '../utils/color_utils.dart';
import '../utils/math_utils.dart';
import 'viewing_conditions.dart';

/// CAM16, a color appearance model. Colors are not just defined by their hex
/// code, but rather, a hex code and viewing conditions.
///
/// CAM16 instances also have coordinates in the CAM16-UCS space, called J*, a*,
/// b*, or jstar, astar, bstar in code. CAM16-UCS is included in the CAM16
/// specification, and should be used when measuring distances between colors.
///
/// In traditional color spaces, a color can be identified solely by the
/// observer's measurement of the color. Color appearance models such as CAM16
/// also use information about the environment where the color was
/// observed, known as the viewing conditions.
///
/// For example, white under the traditional assumption of a midday sun white
/// point is accurately measured as a slightly chromatic blue by CAM16.
/// (roughly, hue 203, chroma 3, lightness 100)
/// CAM16, a color appearance model. Colors are not just defined by their hex
/// code, but rather, a hex code and viewing conditions.
///
/// CAM16 instances also have coordinates in the CAM16-UCS space, called J*, a*,
/// b*, or jstar, astar, bstar in code. CAM16-UCS is included in the CAM16
/// specification, and should be used when measuring distances between colors.
///
/// In traditional color spaces, a color can be identified solely by the
/// observer's measurement of the color. Color appearance models such as CAM16
/// also use information about the environment where the color was
/// observed, known as the viewing conditions.
///
/// For example, white under the traditional assumption of a midday sun white
/// point is accurately measured as a slightly chromatic blue by CAM16.
/// (roughly, hue 203, chroma 3, lightness 100)
class Cam16 {
  /// Like red, orange, yellow, green, etc.
  final double hue;

  /// Informally, colorfulness / color intensity. Like saturation in HSL,
  /// except perceptually accurate.
  final double chroma;

  /// Lightness
  final double j;

  /// Brightness; ratio of lightness to white point's lightness
  final double q;

  /// Colorfulness
  final double m;

  /// Saturation; ratio of chroma to white point's chroma
  final double s;

  /// CAM16-UCS J coordinate
  final double jstar;

  /// CAM16-UCS a coordinate
  final double astar;

  /// CAM16-UCS b coordinate
  final double bstar;

  /// All of the CAM16 dimensions can be calculated from 3 of the dimensions, in
  /// the following combinations:
  ///     -  {j or q} and {c, m, or s} and hue
  ///     - jstar, astar, bstar
  /// Prefer using a static method that constructs from 3 of those dimensions.
  /// This constructor is intended for those methods to use to return all
  /// possible dimensions.
  Cam16(this.hue, this.chroma, this.j, this.q, this.m, this.s, this.jstar,
      this.astar, this.bstar);

  /// CAM16 instances also have coordinates in the CAM16-UCS space, called J*,
  /// a*, b*, or jstar, astar, bstar in code. CAM16-UCS is included in the CAM16
  /// specification, and should be used when measuring distances between colors.
  double distance(Cam16 other) {
    final double dJ = jstar - other.jstar;
    final double dA = astar - other.astar;
    final double dB = bstar - other.bstar;
    final double dEPrime = math.sqrt(dJ * dJ + dA * dA + dB * dB);
    final double dE = 1.41 * math.pow(dEPrime, 0.63);
    return dE;
  }

  /// Convert [argb] to CAM16, assuming the color was viewed in default viewing
  /// conditions.
  static Cam16 fromInt(int argb) {
    return fromIntInViewingConditions(argb, ViewingConditions.sRgb);
  }

  /// Given [viewingConditions], convert [argb] to CAM16.
  static Cam16 fromIntInViewingConditions(
      int argb, ViewingConditions viewingConditions) {
    // Transform ARGB int to XYZ
    final List<double> xyz = ColorUtils.xyzFromArgb(argb);
    final double x = xyz[0];
    final double y = xyz[1];
    final double z = xyz[2];
    return fromXyzInViewingConditions(x, y, z, viewingConditions);
  }

  /// Given color expressed in XYZ and viewed in [viewingConditions], convert to
  /// CAM16.
  static Cam16 fromXyzInViewingConditions(
      double x, double y, double z, ViewingConditions viewingConditions) {
    // Transform XYZ to 'cone'/'rgb' responses

    final double rC = 0.401288 * x + 0.650173 * y - 0.051461 * z;
    final double gC = -0.250268 * x + 1.204414 * y + 0.045854 * z;
    final double bC = -0.002079 * x + 0.048952 * y + 0.953127 * z;

    // Discount illuminant
    final double rD = viewingConditions.rgbD[0] * rC;
    final double gD = viewingConditions.rgbD[1] * gC;
    final double bD = viewingConditions.rgbD[2] * bC;

    // chromatic adaptation
    final double rAF =
        math.pow(viewingConditions.fl * rD.abs() / 100.0, 0.42).toDouble();
    final double gAF =
        math.pow(viewingConditions.fl * gD.abs() / 100.0, 0.42).toDouble();
    final double bAF =
        math.pow(viewingConditions.fl * bD.abs() / 100.0, 0.42).toDouble();
    final double rA = MathUtils.signum(rD) * 400.0 * rAF / (rAF + 27.13);
    final double gA = MathUtils.signum(gD) * 400.0 * gAF / (gAF + 27.13);
    final double bA = MathUtils.signum(bD) * 400.0 * bAF / (bAF + 27.13);

    // redness-greenness
    final double a = (11.0 * rA + -12.0 * gA + bA) / 11.0;
    // yellowness-blueness
    final double b = (rA + gA - 2.0 * bA) / 9.0;

    // auxiliary components
    final double u = (20.0 * rA + 20.0 * gA + 21.0 * bA) / 20.0;
    final double p2 = (40.0 * rA + 20.0 * gA + bA) / 20.0;

    // hue
    final double atan2 = math.atan2(b, a);
    final double atanDegrees = atan2 * 180.0 / math.pi;
    final double hue = atanDegrees < 0
        ? atanDegrees + 360.0
        : atanDegrees >= 360
            ? atanDegrees - 360 // coverage:ignore-line
            : atanDegrees;
    final double hueRadians = hue * math.pi / 180.0;
    assert(hue >= 0 && hue < 360, 'hue was really $hue');

    // achromatic response to color
    final double ac = p2 * viewingConditions.nbb;

    // CAM16 lightness and brightness
    final double J = 100.0 *
        math.pow(ac / viewingConditions.aw,
            viewingConditions.c * viewingConditions.z);
    final double Q = (4.0 / viewingConditions.c) *
        math.sqrt(J / 100.0) *
        (viewingConditions.aw + 4.0) *
        (viewingConditions.fLRoot);

    final double huePrime = (hue < 20.14) ? hue + 360 : hue;
    final double eHue =
        (1.0 / 4.0) * (math.cos(huePrime * math.pi / 180.0 + 2.0) + 3.8);
    final double p1 =
        50000.0 / 13.0 * eHue * viewingConditions.nC * viewingConditions.ncb;
    final double t = p1 * math.sqrt(a * a + b * b) / (u + 0.305);
    final num alpha = math.pow(t, 0.9) *
        math.pow(
            1.64 - math.pow(0.29, viewingConditions.backgroundYTowhitePointY),
            0.73);
    // CAM16 chroma, colorfulness, chroma
    final double C = alpha * math.sqrt(J / 100.0);
    final double M = C * viewingConditions.fLRoot;
    final double s = 50.0 *
        math.sqrt((alpha * viewingConditions.c) / (viewingConditions.aw + 4.0));

    // CAM16-UCS components
    final double jstar = (1.0 + 100.0 * 0.007) * J / (1.0 + 0.007 * J);
    final double mstar = math.log(1.0 + 0.0228 * M) / 0.0228;
    final double astar = mstar * math.cos(hueRadians);
    final double bstar = mstar * math.sin(hueRadians);
    return Cam16(hue, C, J, Q, M, s, jstar, astar, bstar);
  }

  /// Create a CAM16 color from lightness [j], chroma [c], and hue [h],
  /// assuming the color was viewed in default viewing conditions.
  static Cam16 fromJch(double j, double c, double h) {
    return fromJchInViewingConditions(j, c, h, ViewingConditions.sRgb);
  }

  /// Create a CAM16 color from lightness [j], chroma [C], and hue [h],
  /// in [viewingConditions].
  static Cam16 fromJchInViewingConditions(
      double J, double C, double h, ViewingConditions viewingConditions) {
    final double Q = (4.0 / viewingConditions.c) *
        math.sqrt(J / 100.0) *
        (viewingConditions.aw + 4.0) *
        (viewingConditions.fLRoot);
    final double M = C * viewingConditions.fLRoot;
    final double alpha = C / math.sqrt(J / 100.0);
    final double s = 50.0 *
        math.sqrt((alpha * viewingConditions.c) / (viewingConditions.aw + 4.0));

    final double hueRadians = h * math.pi / 180.0;
    final double jstar = (1.0 + 100.0 * 0.007) * J / (1.0 + 0.007 * J);
    final double mstar = 1.0 / 0.0228 * math.log(1.0 + 0.0228 * M);
    final double astar = mstar * math.cos(hueRadians);
    final double bstar = mstar * math.sin(hueRadians);
    return Cam16(h, C, J, Q, M, s, jstar, astar, bstar);
  }

  /// Create a CAM16 color from CAM16-UCS coordinates [jstar], [astar], [bstar].
  /// assuming the color was viewed in default viewing conditions.
  static Cam16 fromUcs(double jstar, double astar, double bstar) {
    return fromUcsInViewingConditions(
        jstar, astar, bstar, ViewingConditions.standard);
  }

  /// Create a CAM16 color from CAM16-UCS coordinates [jstar], [astar], [bstar].
  /// in [viewingConditions].
  static Cam16 fromUcsInViewingConditions(double jstar, double astar,
      double bstar, ViewingConditions viewingConditions) {
    final double a = astar;
    final double b = bstar;
    final double m = math.sqrt(a * a + b * b);
    final double M = (math.exp(m * 0.0228) - 1.0) / 0.0228;
    final double c = M / viewingConditions.fLRoot;
    double h = math.atan2(b, a) * (180.0 / math.pi);
    if (h < 0.0) {
      h += 360.0;
    }
    final double j = jstar / (1 - (jstar - 100) * 0.007);

    return Cam16.fromJchInViewingConditions(j, c, h, viewingConditions);
  }

  /// ARGB representation of color, assuming the color was viewed in default
  /// viewing conditions.
  int toInt() {
    return viewed(ViewingConditions.sRgb);
  }

  // Avoid allocations during conversion by pre-allocating an array.
  final List<double> _viewedArray = <double>[0, 0, 0];

  /// ARGB representation of a color, given the color was viewed in
  /// [viewingConditions]
  int viewed(ViewingConditions viewingConditions) {
    final List<double> xyz =
        xyzInViewingConditions(viewingConditions, array: _viewedArray);
    final int argb = ColorUtils.argbFromXyz(xyz[0], xyz[1], xyz[2]);
    return argb;
  }

  /// XYZ representation of CAM16 seen in [viewingConditions].
  List<double> xyzInViewingConditions(ViewingConditions viewingConditions,
      {List<double>? array}) {
    final double alpha =
        (chroma == 0.0 || j == 0.0) ? 0.0 : chroma / math.sqrt(j / 100.0);

    final num t = math.pow(
        alpha /
            math.pow(
                1.64 -
                    math.pow(0.29, viewingConditions.backgroundYTowhitePointY),
                0.73),
        1.0 / 0.9);
    final double hRad = hue * math.pi / 180.0;

    final double eHue = 0.25 * (math.cos(hRad + 2.0) + 3.8);
    final double ac = viewingConditions.aw *
        math.pow(j / 100.0, 1.0 / viewingConditions.c / viewingConditions.z);
    final double p1 =
        eHue * (50000.0 / 13.0) * viewingConditions.nC * viewingConditions.ncb;

    final double p2 = ac / viewingConditions.nbb;

    final double hSin = math.sin(hRad);
    final double hCos = math.cos(hRad);

    final double gamma = 23.0 *
        (p2 + 0.305) *
        t /
        (23.0 * p1 + 11 * t * hCos + 108.0 * t * hSin);
    final double a = gamma * hCos;
    final double b = gamma * hSin;
    final double rA = (460.0 * p2 + 451.0 * a + 288.0 * b) / 1403.0;
    final double gA = (460.0 * p2 - 891.0 * a - 261.0 * b) / 1403.0;
    final double bA = (460.0 * p2 - 220.0 * a - 6300.0 * b) / 1403.0;

    final num rCBase = math.max(0, (27.13 * rA.abs()) / (400.0 - rA.abs()));
    final double rC = MathUtils.signum(rA) *
        (100.0 / viewingConditions.fl) *
        math.pow(rCBase, 1.0 / 0.42);
    final num gCBase = math.max(0, (27.13 * gA.abs()) / (400.0 - gA.abs()));
    final double gC = MathUtils.signum(gA) *
        (100.0 / viewingConditions.fl) *
        math.pow(gCBase, 1.0 / 0.42);
    final num bCBase = math.max(0, (27.13 * bA.abs()) / (400.0 - bA.abs()));
    final double bC = MathUtils.signum(bA) *
        (100.0 / viewingConditions.fl) *
        math.pow(bCBase, 1.0 / 0.42);
    final double rF = rC / viewingConditions.rgbD[0];
    final double gF = gC / viewingConditions.rgbD[1];
    final double bF = bC / viewingConditions.rgbD[2];

    final double x = 1.86206786 * rF - 1.01125463 * gF + 0.14918677 * bF;
    final double y = 0.38752654 * rF + 0.62144744 * gF - 0.00897398 * bF;
    final double z = -0.01584150 * rF - 0.03412294 * gF + 1.04996444 * bF;

    if (array != null) {
      array[0] = x;
      array[1] = y;
      array[2] = z;
      return array;
    } else {
      return <double>[x, y, z];
    }
  }
}
