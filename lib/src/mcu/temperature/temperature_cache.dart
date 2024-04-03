// Copyright 2022 Google LLC
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

import 'dart:math' as math;

import '../material_color_utilities.dart';

/// Design utilities using color temperature theory.
///
/// Analogous colors, complementary color, and cache to efficiently, lazily,
/// generate data for calculations when needed.
class TemperatureCache {
  /// TemperatureCache default constructor.
  TemperatureCache(this.input);

  /// Hct input value.
  final Hct input;

  List<Hct> _hctsByTemp = <Hct>[];
  List<Hct> _hctsByHue = <Hct>[];
  Map<Hct, double> _tempsByHct = <Hct, double>{};
  double _inputRelativeTemperature = -1.0;
  Hct? _complement;

  /// Get warmest HCT color.
  Hct get warmest => hctsByTemp.last;

  /// Get coldest HCT color.
  Hct get coldest => hctsByTemp.first;

  /// A set of colors with differing hues, equidistant in temperature.
  ///
  /// In art, this is usually described as a set of 5 colors on a color wheel
  /// divided into 12 sections. This method allows provision of either of those
  /// values.
  ///
  /// Behavior is undefined when [count] or [divisions] is 0.
  /// When divisions < count, colors repeat.
  ///
  /// [count] The number of colors to return, includes the input color.
  /// [divisions] The number of divisions on the color wheel.
  List<Hct> analogous({int count = 5, int divisions = 12}) {
    final int startHue = input.hue.round();
    final Hct startHct = hctsByHue[startHue];
    double lastTemp = relativeTemperature(startHct);
    final List<Hct> allColors = <Hct>[startHct];

    double absoluteTotalTempDelta = 0.0;
    for (int i = 0; i < 360; i++) {
      final int hue = MathUtils.sanitizeDegreesInt(startHue + i);
      final Hct hct = hctsByHue[hue];
      final double temp = relativeTemperature(hct);
      final double tempDelta = (temp - lastTemp).abs();
      lastTemp = temp;
      absoluteTotalTempDelta += tempDelta;
    }
    int hueAddend = 1;
    final double tempStep = absoluteTotalTempDelta / divisions;
    double totalTempDelta = 0.0;
    lastTemp = relativeTemperature(startHct);
    while (allColors.length < divisions) {
      final int hue = MathUtils.sanitizeDegreesInt(startHue + hueAddend);
      final Hct hct = hctsByHue[hue];
      final double temp = relativeTemperature(hct);
      final double tempDelta = (temp - lastTemp).abs();
      totalTempDelta += tempDelta;

      final double desiredTotalTempDeltaForIndex = allColors.length * tempStep;
      bool indexSatisfied = totalTempDelta >= desiredTotalTempDeltaForIndex;
      int indexAddend = 1;
      // Keep adding this hue to the answers until its temperature is
      // insufficient. This ensures consistent behavior when there aren't
      // [divisions] discrete steps between 0 and 360 in hue with [tempStep]
      // delta in temperature between them.
      //
      // For example, white and black have no analogues: there are no other
      // colors at T100/T0. Therefore, they should just be added to the array
      // as answers.
      while (indexSatisfied && allColors.length < divisions) {
        allColors.add(hct);
        final double desiredTotalTempDeltaForIndex =
            (allColors.length + indexAddend) * tempStep;
        indexSatisfied = totalTempDelta >= desiredTotalTempDeltaForIndex;
        indexAddend++;
      }
      lastTemp = temp;
      hueAddend++;
      if (hueAddend > 360) {
        // coverage:ignore-start
        while (allColors.length < divisions) {
          allColors.add(hct);
        }
        // coverage:ignore-end
        break;
      }
    }

    final List<Hct> answers = <Hct>[input];

    // First, generate analogues from rotating counter-clockwise.
    final int increaseHueCount = ((count - 1) / 2.0).floor();
    for (int i = 1; i < (increaseHueCount + 1); i++) {
      int index = 0 - i;
      while (index < 0) {
        index = allColors.length + index;
      }
      if (index >= allColors.length) {
        index = index % allColors.length; // coverage:ignore-line
      }
      answers.insert(0, allColors[index]);
    }

    // Second, generate analogues from rotating clockwise.
    final int decreaseHueCount = count - increaseHueCount - 1;
    for (int i = 1; i < (decreaseHueCount + 1); i++) {
      int index = i;
      while (index < 0) {
        index = allColors.length + index; // coverage:ignore-line
      }
      if (index >= allColors.length) {
        index = index % allColors.length; // coverage:ignore-line
      }
      answers.add(allColors[index]);
    }

    return answers;
  }

  /// A color that complements the input color aesthetically.
  ///
  /// In art, this is usually described as being across the color wheel.
  /// History of this shows intent as a color that is just as cool-warm as the
  /// input color is warm-cool.
  Hct get complement {
    if (_complement != null) {
      return _complement!; // coverage:ignore-line
    }

    final double coldestHue = coldest.hue;
    final double coldestTemp = tempsByHct[coldest]!;

    final double warmestHue = warmest.hue;
    final double warmestTemp = tempsByHct[warmest]!;
    final double range = warmestTemp - coldestTemp;
    final bool startHueIsColdestToWarmest =
        isBetween(angle: input.hue, a: coldestHue, b: warmestHue);
    final double startHue =
        startHueIsColdestToWarmest ? warmestHue : coldestHue;
    final double endHue = startHueIsColdestToWarmest ? coldestHue : warmestHue;
    const double directionOfRotation = 1.0;
    double smallestError = 1000.0;
    Hct answer = hctsByHue[input.hue.round()];

    final double complementRelativeTemp = 1.0 - inputRelativeTemperature;
    // Find the color in the other section, closest to the inverse percentile
    // of the input color. This is the complement.
    for (double hueAddend = 0.0; hueAddend <= 360.0; hueAddend += 1.0) {
      final double hue = MathUtils.sanitizeDegreesDouble(
          startHue + directionOfRotation * hueAddend);
      if (!isBetween(angle: hue, a: startHue, b: endHue)) {
        continue;
      }
      final Hct possibleAnswer = hctsByHue[hue.round()];
      final double relativeTemp =
          (_tempsByHct[possibleAnswer]! - coldestTemp) / range;
      final double error = (complementRelativeTemp - relativeTemp).abs();
      if (error < smallestError) {
        smallestError = error;
        answer = possibleAnswer;
      }
    }
    _complement = answer;
    return _complement!;
  }

  /// Temperature relative to all colors with the same chroma and tone.
  /// Value on a scale from 0 to 1.
  double relativeTemperature(Hct hct) {
    final double range = tempsByHct[warmest]! - tempsByHct[coldest]!;
    final double differenceFromColdest =
        tempsByHct[hct]! - tempsByHct[coldest]!;
    // Handle when there's no difference in temperature between warmest and
    // coldest: for example, at T100, only one color is available, white.
    if (range == 0.0) {
      return 0.5;
    }
    return differenceFromColdest / range;
  }

  /// Relative temperature of the input color. See [relativeTemperature].
  double get inputRelativeTemperature {
    if (_inputRelativeTemperature >= 0.0) {
      return _inputRelativeTemperature; // coverage:ignore-line
    }
    final double coldestTemp = tempsByHct[coldest]!;
    final double range = tempsByHct[warmest]! - coldestTemp;
    final double differenceFromColdest = tempsByHct[input]! - coldestTemp;
    final double inputRelativeTemp =
        (range == 0.0) ? 0.5 : differenceFromColdest / range;
    // False positive, this is not doable, we need to update private cache.
    // ignore: join_return_with_assignment
    _inputRelativeTemperature = inputRelativeTemp;
    return _inputRelativeTemperature;
  }

  /// HCTs for all hues, with the same chroma/tone as the input.
  /// Sorted from coldest first to warmest last.
  List<Hct> get hctsByTemp {
    if (_hctsByTemp.isNotEmpty) {
      return _hctsByTemp;
    }
    final List<Hct> hcts = List<Hct>.from(hctsByHue, growable: true);
    hcts.add(input);
    final Map<Hct, double> temperaturesByHct = tempsByHct;
    hcts.sort((Hct a, Hct b) =>
        temperaturesByHct[a]!.compareTo(temperaturesByHct[b]!));
    // False positive, this is not doable, we need to update private cache.
    // ignore: join_return_with_assignment
    _hctsByTemp = hcts;
    return _hctsByTemp;
  }

  /// A Map with keys of HCTs in [hctsByTemp], values of raw temperature.
  Map<Hct, double> get tempsByHct {
    if (_tempsByHct.isNotEmpty) {
      return _tempsByHct;
    }
    final List<Hct> allHcts = List<Hct>.from(hctsByHue)..add(input);
    final Map<Hct, double> temperaturesByHct = <Hct, double>{
      for (final Hct e in allHcts) e: rawTemperature(e)
    };
    // False positive, this is not doable, we need to update private cache.
    // ignore: join_return_with_assignment
    _tempsByHct = temperaturesByHct;
    return _tempsByHct;
  }

  /// HCTs for all hues, with the same chroma/tone as the input.
  /// Sorted ascending, hue 0 to 360.
  List<Hct> get hctsByHue {
    if (_hctsByHue.isNotEmpty) {
      return _hctsByHue;
    }
    final List<Hct> hcts = <Hct>[];
    for (double hue = 0.0; hue <= 360.0; hue += 1.0) {
      final Hct colorAtHue = Hct.from(hue, input.chroma, input.tone);
      hcts.add(colorAtHue);
    }
    // False positive, this is not doable, we need to update private cache.
    // ignore: join_return_with_assignment
    _hctsByHue = List<Hct>.from(hcts, growable: false);
    return _hctsByHue;
  }

  /// Determines if an angle is between two other angles, rotating clockwise.
  static bool isBetween(
      {required double angle, required double a, required double b}) {
    if (a < b) {
      return a <= angle && angle <= b;
    }
    return a <= angle || angle <= b;
  }

  /// Value representing cool-warm factor of a color.
  /// Values below 0 are considered cool, above, warm.
  ///
  /// Color science has researched emotion and harmony, which art uses to select
  /// colors. Warm-cool is the foundation of analogous and complementary colors.
  /// See:
  /// - Li-Chen Ou's Chapter 19 in Handbook of Color Psychology (2015).
  /// - Josef Albers' Interaction of Color chapters 19 and 21.
  ///
  /// Implementation of Ou, Woodcock and Wright's algorithm, which uses
  /// L*a*b*/LCH color space.
  /// Return value has these properties:
  /// - Values below 0 are cool, above 0 are warm.
  /// - Lower bound: -0.52 - (chroma ^ 1.07 / 20). L*a*b* chroma is infinite.
  ///   Assuming max of 130 chroma, -9.66.
  /// - Upper bound: -0.52 + (chroma ^ 1.07 / 20). L*a*b* chroma is infinite.
  ///   Assuming max of 130 chroma, 8.61.
  static double rawTemperature(Hct color) {
    final List<double> lab = ColorUtils.labFromArgb(color.toInt());
    final double hue = MathUtils.sanitizeDegreesDouble(
        math.atan2(lab[2], lab[1]) * 180.0 / math.pi);
    final double chroma = math.sqrt((lab[1] * lab[1]) + (lab[2] * lab[2]));
    final double temperature = -0.5 +
        0.02 *
            math.pow(chroma, 1.07) *
            math.cos(
              MathUtils.sanitizeDegreesDouble(hue - 50.0) * math.pi / 180.0,
            );
    return temperature;
  }
}
