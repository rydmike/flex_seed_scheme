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
import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/foundation.dart';

import '../mcu/hct/hct.dart';

// ignore_for_file: comment_references

/// Enum used to select tones included in produced FlexTonalPalette.
///
/// When using type [FlexPaletteType.common] the chroma of high tones, >= 90,
/// is limited to maximum 40. This keeps the chromacity of tones 90 to 100,
/// lower than 40.
/// If the source color use more chromacity than 40, there may be a sudden jump
/// in chroma reduction at tone 90. This is the standard behavior for the
/// original Material 3 tonal palette computation. The [FlexPaletteType.common]
/// is intended  to be used when there is a need to follow strict M3's
/// original palette design.
///
/// When using the [FlexPaletteType.extended] type tones, there are not only
/// the new tones, but the chroma limit of tones >= 90 is also removed.
/// This increases fidelity of higher tone when high chromacity is used.
///
/// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
/// should be avoided and extended tones used instead. The common tones are
/// kept for backwards compatibility and for cases where the original M3
/// palette is needed. The [FlexPaletteType.extended] is the new default
/// for all [FlexTones].
enum FlexPaletteType {
  /// Common tones consisting of the 15 tones originally used in
  /// FlexSeedScheme.
  ///
  /// Original Material 3 color system included only 13 tones
  /// 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100.
  /// These are still used as common tone in Material Color Utilities (MCU)
  /// package TonalPalette class.
  ///
  /// FlexSeedScheme includes tones 5 and 98 in addition to these tones in its
  /// definition of common tones.
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  common,

  /// Extended tones used in Material 3 revision for additional fidelity
  /// in surface colors. These were added during 1st half of 2023 to the
  /// Material 3 color system specification.
  ///
  /// The added tones 2, 4, 6, 12, 17, 22, 24 are for new dark mode surfaces in
  /// revised Material 3 dark surface colors. Likewise added tones
  /// 98, 97, 96, 94, 92, 87 are for light mode surfaces in the updated
  /// Material-3 color system. For more information, see:
  /// https://m3.material.io/styles/color/the-color-system/color-roles
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  extended,
}

/// A convenience class for retrieving colors that are constant in hue and
/// chroma, but vary in tone.
///
/// This class can be instantiated in two ways:
/// 1. [of] From hue and chroma. (preferred)
/// 2. [fromList] From a fixed-size ([FlexTonalPalette.commonSize]) list of ints
/// representing ARBG colors. Correctness (constant hue and chroma) of the input
/// is not enforced. [get] will only return the input colors, corresponding to
/// [commonTones]. This also initializes the key color to black.
@immutable
class FlexTonalPalette {
  /// Commonly-used tone values.
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  static const List<int> commonTones = <int>[
    0,
    5,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    95,
    98,
    99,
    100,
  ];

  // If modifying commonTones length, update commonSize to equal
  // commonTones.length. There is a test and assert that fails if you did not.

  /// Number of tones in [commonTones].
  ///
  /// In original implementation package material_color_utilities this is
  /// defined as well, presumably for improved efficiency, there it is set to
  /// [FlexTonalPalette.commonTones.length]. Here we instead manually set it
  /// to compile time const of same const list length.
  ///
  /// Flutter SDK [TonalPalette] has 13 common tones and [FlexTonalPalette] 15.
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  static const int commonSize = 15;

  /// Extended one values in a [FlexTonalPalette].
  ///
  /// Contains custom tones 2, 5 and 97 in addition to the 13 tones included
  /// in the Material 3 guide tonal palette.
  ///
  /// The added tones 4, 6, 12, 17, 22 and 24 are for new dark mode surfaces
  /// in revised Material 3 dark surface colors. Likewise added tones
  /// 98, 96, 94, 92, 87 are for light mode surfaces in the updated Material 3
  /// color system. For more information, see:
  /// https://m3.material.io/styles/color/the-color-system/color-roles
  /// The additional tones in the Material 3 specification appeared during later
  /// part of first half of 2023.
  ///
  /// Tones 2, 5, and 97 are not in old or new M3 spec, but FlexSeedScheme
  /// includes them to enable even more fidelity in dark and light tones.
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  static const List<int> extendedTones = <int>[
    0,
    2,
    4,
    5,
    6,
    10,
    12,
    17,
    20,
    22,
    24,
    30,
    40,
    50,
    60,
    70,
    80,
    87,
    90,
    92,
    94,
    95,
    96,
    97,
    98,
    99,
    100,
  ];

  // If modifying extendedTones length, update extendedSize to equal
  // extendedTones.length. There is a test and assert that fails if you did not.

  /// Number of tones in [extendedTones].
  ///
  /// In original implementation package material_color_utilities this is
  /// defined as well, presumably for improved efficiency, but there it is set
  /// to [FlexTonalPalette.commonTones.length]. Here we instead manually set it
  /// to compile time const of same const list length.
  ///
  /// Flutter SDK [TonalPalette] has 13 tones, [FlexTonalPalette] extended 27.
  ///
  /// Starting from Flutter 3.22 and FlexSeedScheme 2.0.0 the common tones
  /// should be avoided and extended tones used instead. The common tones are
  /// kept for backwards compatibility and for cases where the original M3
  /// palette is needed. The [FlexPaletteType.extended] is the new default
  /// for all [FlexTones].
  static const int extendedSize = 27;

  /// The hue of the palette.
  final double hue;

  /// The chroma of the palette.
  final double chroma;

  /// The used palette type.
  final FlexPaletteType _paletteType;

  /// The key color of the palette.
  final Hct keyColor;

  /// A cache containing keys-value pairs where:
  /// - keys are integers that represent tones, and
  /// - values are colors in ARGB format.
  final Map<int, int> _cache;

  /// Whether the palette was created from the cache or not.
  final bool _isFromCache;

  FlexTonalPalette._fromHct(
    Hct hct, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : _cache = <int, int>{},
        _paletteType = paletteType,
        hue = hct.hue,
        chroma = hct.chroma,
        keyColor = hct,
        _isFromCache = false;

  FlexTonalPalette._fromHueAndChroma(
    this.hue,
    this.chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : _cache = <int, int>{},
        _paletteType = paletteType,
        keyColor = createKeyColor(hue, chroma),
        _isFromCache = false;

  FlexTonalPalette._fromCache(
    Map<int, int> cache,
    this.hue,
    this.chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : _cache = cache,
        _paletteType = paletteType,
        keyColor = createKeyColor(hue, chroma),
        _isFromCache = true;

  /// Create colors using [hue] and [chroma].
  static FlexTonalPalette of(
    double hue,
    double chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    return FlexTonalPalette._fromHueAndChroma(hue, chroma, paletteType);
  }

  /// Create a Tonal Palette from hue and chroma of [hct].
  static FlexTonalPalette fromHct(
    Hct hct, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    return FlexTonalPalette._fromHct(hct, paletteType);
  }

  /// Create colors from a fixed-size list of ARGB color ints.
  ///
  /// Inverse of [FlexTonalPalette.asList].
  static FlexTonalPalette fromList(
    List<int> colors, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    assert(
        (colors.length == commonSize &&
                paletteType == FlexPaletteType.common) ||
            (colors.length == extendedSize &&
                paletteType == FlexPaletteType.extended),
        'Length must be $commonSize when using FlexPaletteType.common OR '
        'length must be $extendedSize when using FlexPaletteType.extended.');
    final Map<int, int> cache = <int, int>{};
    switch (paletteType) {
      case FlexPaletteType.common:
        commonTones.asMap().forEach(
            (int index, int toneValue) => cache[toneValue] = colors[index]);
      case FlexPaletteType.extended:
        extendedTones.asMap().forEach(
            (int index, int toneValue) => cache[toneValue] = colors[index]);
    }

    // Approximately deduces the original hue and chroma that generated this
    // list of colors.
    // Uses the hue and chroma of the provided color with the highest chroma.
    double bestHue = 0.0;
    double bestChroma = 0.0;
    for (final int argb in colors) {
      final Hct hct = Hct.fromInt(argb);

      // If the color is too close to white, its chroma may have been
      // affected by a known issue, so we ignore it.
      // https://github.com/material-foundation/material-color-utilities/issues/140
      if (hct.tone > 98.0) continue;

      if (hct.chroma > bestChroma) {
        bestHue = hct.hue;
        bestChroma = hct.chroma;
      }
    }
    return FlexTonalPalette._fromCache(cache, bestHue, bestChroma, paletteType);
  }

  /// Creates a key color from a [hue] and a [chroma].
  /// The key color is the first tone, starting from T50, matching the
  /// given hue and chroma. Key color [Hct].
  static Hct createKeyColor(double hue, double chroma) {
    const double startTone = 50.0;
    Hct smallestDeltaHct = Hct.from(hue, chroma, startTone);
    double smallestDelta = (smallestDeltaHct.chroma - chroma).abs();
    // Starting from T50, check T+/-delta to see if they match the requested
    // chroma.
    //
    // Starts from T50 because T50 has the most chroma available, on
    // average. Thus it is most likely to have a direct answer and minimize
    // iteration.
    for (double delta = 1.0; delta < 50.0; delta += 1.0) {
      // Termination condition rounding instead of minimizing delta to avoid
      // case where requested chroma is 16.51, and the closest chroma is 16.49.
      // Error is minimized, but when rounded and displayed, requested chroma
      // is 17, key color's chroma is 16.
      if (chroma.round() == smallestDeltaHct.chroma.round()) {
        return smallestDeltaHct;
      }

      final Hct hctAdd = Hct.from(hue, chroma, startTone + delta);
      final double hctAddDelta = (hctAdd.chroma - chroma).abs();
      if (hctAddDelta < smallestDelta) {
        smallestDelta = hctAddDelta;
        smallestDeltaHct = hctAdd;
      }

      final Hct hctSubtract = Hct.from(hue, chroma, startTone - delta);
      final double hctSubtractDelta = (hctSubtract.chroma - chroma).abs();
      if (hctSubtractDelta < smallestDelta) {
        smallestDelta = hctSubtractDelta;
        smallestDeltaHct = hctSubtract;
      }
    }

    return smallestDeltaHct;
  }

  /// Returns a fixed-size list of ARGB color ints for common tone values.
  ///
  /// Inverse of [fromList].
  List<int> get asList => _paletteType == FlexPaletteType.common
      ? commonTones.map(get).toList()
      : extendedTones.map(get).toList();

  /// Returns the ARGB representation of an HCT color at the given [tone].
  ///
  /// If the palette is constructed from a list of colors
  /// (i.e. using [fromList]), the color provided at construction is returned
  /// if possible; otherwise the result is generated from the deduced
  /// [hue] and [chroma].
  ///
  /// If the palette is constructed from a hue and chroma (i.e. using [of] or
  /// [fromHct]), the result is generated from the given [hue] and [chroma].
  int get(int tone) {
    return _cache.putIfAbsent(
      tone,
      () => Hct.from(hue, chroma, tone.toDouble()).toInt(),
    );
  }

  /// Returns the HCT color at the given [tone].
  ///
  /// If the palette is constructed from a list of colors
  /// (i.e. using [fromList]), the color provided at construction is returned
  /// if possible; otherwise the result is generated from the deduced
  /// [hue] and [chroma].
  ///
  /// If the palette is constructed from a hue and chroma (i.e. using [of] or
  /// [fromHct]), the result is generated from the given [hue] and [chroma].
  Hct getHct(double tone) {
    if (_cache.containsKey(tone)) {
      return Hct.fromInt(_cache[tone]!);
    } else {
      return Hct.from(hue, chroma, tone);
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is FlexTonalPalette) {
      if (!_isFromCache && !other._isFromCache) {
        // Both created with .of or .fromHct
        return hue == other.hue &&
            chroma == other.chroma &&
            _paletteType == other._paletteType;
      } else {
        return const ListEquality<int>().equals(asList, other.asList);
      }
    }
    return false;
  }

  @override
  int get hashCode {
    if (!_isFromCache) {
      return Object.hash(hue, chroma, _paletteType);
    } else {
      return Object.hashAll(asList);
    }
  }

  @override
  String toString() {
    if (!_isFromCache) {
      return 'FlexTonalPalette.of($hue, $chroma, $_paletteType)';
    } else {
      return 'FlexTonalPalette.fromList($asList, $_paletteType)';
    }
  }
}
