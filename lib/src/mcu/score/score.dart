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
import 'package:collection/collection.dart';

import '../material_color_utilities.dart';

class _ScoredHCT implements Comparable<_ScoredHCT> {
  Hct hct;
  double score;

  _ScoredHCT(this.hct, this.score);

  @override
  int compareTo(_ScoredHCT other) {
    if (score > other.score) {
      return -1;
    } else if (score == other.score) {
      return 0;
    } else {
      return 1;
    }
  }
}

/// Given a large set of colors, remove colors that are unsuitable for a UI
/// theme, and rank the rest based on suitability.
///
/// Enables use of a high cluster count for image quantization, thus ensuring
/// colors aren't muddied, while curating the high cluster count to a much
///  smaller number of appropriate choices.
class Score {
  static const double _targetChroma = 48.0; // A1 Chroma
  static const double _weightProportion = 0.7;
  static const double _weightChromaAbove = 0.3;
  static const double _weightChromaBelow = 0.1;
  static const double _cutoffChroma = 5.0;
  static const double _cutoffExcitedProportion = 0.01;

  /// Given a map with keys of colors and values of how often the color appears,
  /// rank the colors based on suitability for being used for a UI theme.
  ///
  /// [colorsToPopulation] is a map with keys of colors and values of often the
  /// color appears, usually from a source image.
  /// [desired] max count of colors to be returned in the list.
  /// [fallbackColorARGB] color to be returned if no other options available.
  /// [filter] whether to filter out undesireable combinations.
  ///
  /// The list returned is of length <= [desired]. The recommended color is the
  /// first item, the least suitable is the last. There will always be at least
  /// one color returned. If all the input colors were not suitable for a theme,
  /// a default fallback color will be provided, Google Blue. The default
  /// number of colors returned is 4, simply because that is the # of colors
  /// display in Android 12's wallpaper picker.
  static List<int> score(Map<int, int> colorsToPopulation,
      {int desired = 4,
      int fallbackColorARGB = 0xff4285F4,
      bool filter = true}) {
    // Get the HCT color for each Argb value, while finding the per hue count
    // and total count.
    final List<Hct> colorsHct = <Hct>[];
    final List<int> huePopulation = List<int>.filled(360, 0);
    int populationSum = 0;
    for (final MapEntry<int, int> entry in colorsToPopulation.entries) {
      final int argb = entry.key;
      final int population = entry.value;
      final Hct hct = Hct.fromInt(argb);
      colorsHct.add(hct);
      final int hue = hct.hue.floor();
      huePopulation[hue] += population;
      populationSum += population;
    }

    // Hues with more usage in neighboring 30 degree slice get a larger number.
    final List<double> hueExcitedProportions = List<double>.filled(360, 0.0);
    for (int hue = 0; hue < 360; hue++) {
      final double proportion = huePopulation[hue] / populationSum;
      for (int i = hue - 14; i < hue + 16; i++) {
        final int neighborHue = MathUtils.sanitizeDegreesInt(i);
        hueExcitedProportions[neighborHue] += proportion;
      }
    }

    // Scores each HCT color based on usage and chroma, while optionally
    // filtering out values that do not have enough chroma or usage.
    final List<_ScoredHCT> scoredHcts = <_ScoredHCT>[];
    for (final Hct hct in colorsHct) {
      final int hue = MathUtils.sanitizeDegreesInt(hct.hue.round());
      final double proportion = hueExcitedProportions[hue];
      if (filter &&
          (hct.chroma < _cutoffChroma ||
              proportion <= _cutoffExcitedProportion)) {
        continue;
      }

      final double proportionScore = proportion * 100.0 * _weightProportion;
      final double chromaWeight =
          hct.chroma < _targetChroma ? _weightChromaBelow : _weightChromaAbove;
      final double chromaScore = (hct.chroma - _targetChroma) * chromaWeight;
      final double score = proportionScore + chromaScore;
      scoredHcts.add(_ScoredHCT(hct, score));
    }
    // Sorted so that colors with higher scores come first.
    scoredHcts.sort();

    // Iterates through potential hue differences in degrees in order to select
    // the colors with the largest distribution of hues possible. Starting at
    // 90 degrees(maximum difference for 4 colors) then decreasing down to a
    // 15 degree minimum.
    final List<Hct> chosenColors = <Hct>[];
    for (int differenceDegrees = 90;
        differenceDegrees >= 15;
        differenceDegrees--) {
      chosenColors.clear();
      for (final _ScoredHCT entry in scoredHcts) {
        final Hct hct = entry.hct;
        final Hct? duplicateHue = chosenColors.firstWhereOrNull(
            (Hct chosenHct) =>
                MathUtils.differenceDegrees(hct.hue, chosenHct.hue) <
                differenceDegrees);
        if (duplicateHue == null) {
          chosenColors.add(hct);
        }
        if (chosenColors.length >= desired) break;
      }
      if (chosenColors.length >= desired) break;
    }
    final List<int> colors = <int>[];
    // Rydmike: If MCU devs do not hit test this, I'm not going to either.
    // coverage:ignore-start
    if (chosenColors.isEmpty) {
      colors.add(fallbackColorARGB);
    }
    // coverage:ignore-end
    for (final Hct chosenHct in chosenColors) {
      colors.add(chosenHct.toInt());
    }
    return colors;
  }
}
