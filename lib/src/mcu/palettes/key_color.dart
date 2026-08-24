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
import 'package:flex_seed_scheme/src/mcu/hct/hct.dart';

/// Key color is a color that represents the hue and chroma of a tonal palette.
class KeyColor {
  /// Creates a key color from a [hue] and a [requestedChroma].
  KeyColor(this.hue, this.requestedChroma);

  /// The used hue of the key color.
  final double hue;

  /// The requested chroma of the key color.
  final double requestedChroma;

  /// Cache that maps tone to max chroma, for this key color's hue, to avoid
  /// duplicated HCT calculation.
  final Map<int, double> _chromaCache = <int, double>{};
  final double _maxChromaValue = 200.0;

  /// Creates the key color [Hct].
  ///
  /// The key color is the first tone, starting from T50, matching the given
  /// hue and chroma.
  Hct create() {
    // Pivot around T50 because T50 has the most chroma available, on
    // average. Thus it is most likely to have a direct answer.
    const int pivotTone = 50;
    const int toneStepSize = 1;
    // Epsilon to accept values slightly higher than the requested chroma.
    const double epsilon = 0.01;

    // Binary search to find the tone that can provide a chroma that is closest
    // to the requested chroma.
    int lowerTone = 0;
    int upperTone = 100;
    while (lowerTone < upperTone) {
      final int midTone = (lowerTone + upperTone) ~/ 2;
      final bool isAscending = _maxChroma(midTone) < _maxChroma(midTone + toneStepSize);
      final bool sufficientChroma = _maxChroma(midTone) >= requestedChroma - epsilon;

      if (sufficientChroma) {
        // Either range [lowerTone, midTone] or [midTone, upperTone] has
        // the answer, so search in the range that is closer the pivot tone.
        if ((lowerTone - pivotTone).abs() < (upperTone - pivotTone).abs()) {
          upperTone = midTone;
        } else {
          if (lowerTone == midTone) {
            return Hct.from(hue, requestedChroma, lowerTone.toDouble());
          }
          lowerTone = midTone;
        }
      } else {
        // As there is no sufficient chroma in the midTone, follow the direction
        // to the chroma peak.
        if (isAscending) {
          lowerTone = midTone + toneStepSize;
        } else {
          // Keep midTone for potential chroma peak.
          upperTone = midTone;
        }
      }
    }

    return Hct.from(hue, requestedChroma, lowerTone.toDouble());
  }

  // Find the maximum chroma for a given tone
  double _maxChroma(int tone) {
    return _chromaCache.putIfAbsent(tone, () {
      return Hct.from(hue, _maxChromaValue, tone.toDouble()).chroma;
    });
  }
}
