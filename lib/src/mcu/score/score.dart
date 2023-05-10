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
import '../material_color_utilities.dart';
import '../utils/math_utils.dart';

class _ArgbAndScore implements Comparable<_ArgbAndScore> {
  int argb;
  double score;

  _ArgbAndScore(this.argb, this.score);

  @override
  int compareTo(_ArgbAndScore other) {
    // coverage:ignore-start
    if (score > other.score) {
      return -1;
    } else if (score == other.score) {
      return 0;
    } else {
      return 1;
    }
    // coverage:ignore-end
  }
}

/// Given a large set of colors, remove colors that are unsuitable for a UI
/// theme, and rank the rest based on suitability.
///
/// Enables use of a high cluster count for image quantization, thus ensuring
/// colors aren't muddied, while curating the high cluster count to a much
///  smaller number of appropriate choices.
class Score {
  static const double _targetChroma = 48.0;
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
  ///
  /// The list returned is of length <= [desired]. The recommended color is the
  /// first item, the least suitable is the last. There will always be at least
  /// one color returned. If all the input colors were not suitable for a theme,
  /// a default fallback color will be provided, Google Blue. The default
  /// number of colors returned is 4, simply because thats the # of colors
  /// display in Android 12's wallpaper picker.
  static List<int> score(Map<int, int> colorsToPopulation,
      {int desired = 4, bool filter = true}) {
    double populationSum = 0.0;
    for (final int population in colorsToPopulation.values) {
      populationSum += population;
    }

    // Turn the count of each color into a proportion by dividing by the total
    // count. Also, fill a cache of CAM16 colors representing each color, and
    // record the proportion of colors for each CAM16 hue.
    final Map<int, double> argbToRawProportion = <int, double>{};
    final Map<int, Hct> argbToHct = <int, Hct>{};
    final List<double> hueProportions = List<double>.filled(360, 0.0);
    for (final int color in colorsToPopulation.keys) {
      final int population = colorsToPopulation[color]!;
      final double proportion = population / populationSum;
      argbToRawProportion[color] = proportion;

      final Hct hct = Hct.fromInt(color);
      argbToHct[color] = hct;

      final int hue = hct.hue.floor();
      hueProportions[hue] += proportion;
    }

    // Determine the proportion of the colors around each color, by summing the
    // proportions around each color's hue.
    final Map<int, double> argbToHueProportion = <int, double>{};
    for (final MapEntry<int, Hct> entry in argbToHct.entries) {
      final int color = entry.key;
      final Hct cam = entry.value;
      final int hue = cam.hue.round();

      double excitedProportion = 0.0;
      for (int i = hue - 15; i < hue + 15; i++) {
        final int neighborHue = MathUtils.sanitizeDegreesInt(i);
        excitedProportion += hueProportions[neighborHue];
      }
      argbToHueProportion[color] = excitedProportion;
    }

    // Remove colors that are unsuitable, ex. very dark or unchromatic colors.
    // Also, remove colors that are very similar in hue.
    final List<int> filteredColors = filter
        ? _filter(argbToHueProportion, argbToHct)
        : argbToHueProportion.keys.toList();

    // Score the colors by their proportion, as well as how chromatic they are.
    final Map<int, double> argbToScore = <int, double>{};
    for (final int color in filteredColors) {
      final Hct cam = argbToHct[color]!;
      final double proportion = argbToHueProportion[color]!;

      final double proportionScore = proportion * 100.0 * _weightProportion;

      final double chromaWeight =
          cam.chroma < _targetChroma ? _weightChromaBelow : _weightChromaAbove;
      final double chromaScore = (cam.chroma - _targetChroma) * chromaWeight;

      final double score = proportionScore + chromaScore;
      argbToScore[color] = score;
    }

    final List<List<num>> argbAndScoreSorted = argbToScore.entries
        .map((MapEntry<int, double> entry) => <num>[entry.key, entry.value])
        .toList(growable: false);
    argbAndScoreSorted
        .sort((List<num> a, List<num> b) => a[1].compareTo(b[1]) * -1);
    final List<num> argbsScoreSorted =
        argbAndScoreSorted.map((List<num> e) => e[0]).toList(growable: false);
    final Map<num, double> finalColorsToScore = <num, double>{};
    for (double differenceDegrees = 90.0;
        differenceDegrees >= 15.0;
        differenceDegrees--) {
      finalColorsToScore.clear();
      for (final num color in argbsScoreSorted) {
        bool duplicateHue = false;
        final Hct cam = argbToHct[color]!;
        for (final num alreadyChosenColor in finalColorsToScore.keys) {
          final Hct alreadyChosenCam = argbToHct[alreadyChosenColor]!;
          if (MathUtils.differenceDegrees(cam.hue, alreadyChosenCam.hue) <
              differenceDegrees) {
            duplicateHue = true;
            break;
          }
        }
        if (!duplicateHue) {
          finalColorsToScore[color] = argbToScore[color]!;
        }
      }
      if (finalColorsToScore.length >= desired) {
        break;
      }
    }

    // Ensure the list of colors returned is sorted such that the first in the
    // list is the most suitable, and the last is the least suitable.
    final List<_ArgbAndScore> colorsByScoreDescending = finalColorsToScore
        .entries
        .map((MapEntry<num, double> entry) =>
            _ArgbAndScore(entry.key.toInt(), entry.value))
        .toList();
    colorsByScoreDescending.sort();

    // Ensure that at least one color is returned.
    if (colorsByScoreDescending.isEmpty) {
      return <int>[0xff4285F4]; // Google Blue
    }
    return colorsByScoreDescending.map((_ArgbAndScore e) => e.argb).toList();
  }

  /// Remove any colors that are completely inappropriate choices for a theme
  /// colors, colors that are virtually grayscale, or whose hue represents
  /// a very small portion of the image.
  static List<int> _filter(
      Map<int, double> colorsToExcitedProportion, Map<int, Hct> argbToHct) {
    final List<int> filtered = <int>[];
    for (final MapEntry<int, Hct> entry in argbToHct.entries) {
      final int color = entry.key;
      final Hct cam = entry.value;
      final double proportion = colorsToExcitedProportion[color]!;

      if (cam.chroma >= _cutoffChroma &&
          proportion > _cutoffExcitedProportion) {
        filtered.add(color);
      }
    }
    return filtered;
  }

  /// argbToProportion.
  static Map<int, double> argbToProportion(Map<int, int> argbToCount) {
    final double totalPopulation =
        argbToCount.values.reduce((int a, int b) => a + b).floorToDouble();
    final Map<int, Hct> argbToHct = argbToCount
        .map((int key, int value) => MapEntry<int, Hct>(key, Hct.fromInt(key)));
    final List<double> hueProportions = List<double>.filled(360, 0.0);
    for (final int argb in argbToHct.keys) {
      final Hct cam = argbToHct[argb]!;
      final int hue = cam.hue.floor();
      hueProportions[hue] += argbToCount[argb]! / totalPopulation;
    }

    // Determine the proportion of the colors around each color, by summing the
    // proportions around each color's hue.
    final Map<int, double> intToProportion = <int, double>{};
    for (final MapEntry<int, Hct> entry in argbToHct.entries) {
      final int argb = entry.key;
      final Hct cam = entry.value;
      final int hue = cam.hue.round();

      double excitedProportion = 0.0;
      for (int i = hue - 15; i < hue + 15; i++) {
        final int neighborHue = MathUtils.sanitizeDegreesInt(i);
        excitedProportion += hueProportions[neighborHue];
      }
      intToProportion[argb] = excitedProportion;
    }
    return intToProportion;
  }
}
