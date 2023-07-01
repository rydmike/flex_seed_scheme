import 'dart:math' as math;

import 'package:collection/collection.dart' show ListEquality;
import 'package:meta/meta.dart' show immutable;

import '../mcu/material_color_utilities.dart';

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
enum FlexPaletteType {
  /// Default common tones consisting of the 15 tones originally used in
  /// FlexSeedScheme.
  ///
  /// Original Material 3 color system included 13 tones
  /// 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100.
  ///
  /// FlexSeedScheme includes tones 5 and 98 in addition to these tones in its
  /// definition of common tones.
  common,

  /// Extended tones used in Material 3 revision for additional fidelity
  /// in surface colors. These were added during 1st half of 2023 to the
  /// Material 3 color system specification.
  ///
  /// The added tones 4, 6, 12, 17, 22 are for new dark mode surfaces in
  /// revised Material 3 dark surface colors. Likewise added tones
  /// 96, 94, 92, 87 are for light mode surfaces in the updated Material 3
  /// color system. For more information, see:
  /// https://m3.material.io/styles/color/the-color-system/color-roles
  extended,
}

/// A convenience class for retrieving colors that are constant in hue and
/// chroma, but vary in tone.
///
/// This is a modification of package material_color_utilities [TonalPalette]
/// made to also include the tones 98 and tone 5. This gives additional fidelity
/// and expression possibilities when using tones close to black and white.
///
/// This class can be instantiated in two ways:
///
/// 1. [of] From hue and chroma. (preferred)
/// 2. [fromList] From a fixed-size [FlexTonalPalette.commonSize] or
///    [FlexTonalPalette.extendedSize] list of int representing ARBG colors,
///    depending on if [FlexPaletteType.common] paletteType
///    [FlexPaletteType.extended]. Correctness (constant hue and chroma) of
///    the input is not enforced. [get] will only return the input colors,
///    corresponding to [commonTones] or [extendedTones].
@immutable
class FlexTonalPalette {
  // If modifying commonTones length, update commonSize to equal
  // commonTones.length. There is both a test and assert that fails if not done.

  /// Commonly-used tone values in a [FlexTonalPalette].
  ///
  /// Contains custom tones 5 and 98, in addition to the 13 tones included
  /// in the Material 3 guide tonal palette. The tone 98 used to exist in the
  /// [Web Material Theme Builder app](https://m3.material.io/theme-builder#/custom),
  /// but no longer does. It never existed in Flutter or
  /// [Material Color Utilities package](https://pub.dev/packages/material_color_utilities).
  /// Tone 5 is custom addition used in e.g. in [FlexTones.ultraContrast].
  ///
  /// Tone 98 provides optional tonal fidelity in the light and white end of the
  /// palette and tone 5 a more dark tone in the black end of the palette.
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
  /// [TonalPalette.commonTones.length]. Here we instead manually set it
  /// to compile time const of same const list length.
  ///
  /// Flutter SDK [TonalPalette] has 13 common tones and [FlexTonalPalette] 15.
  static const int commonSize = 15;

  /// Extended one values in a [FlexTonalPalette].
  ///
  /// Contains custom tones 5 and 98, in addition to the 13 tones included
  /// in the Material 3 guide tonal palette. The tone 98 used to exist in the
  /// [Web Material Theme Builder app](https://m3.material.io/theme-builder#/custom),
  /// but no longer does. It never existed in Flutter or
  /// [Material Color Utilities package](https://pub.dev/packages/material_color_utilities).
  /// Tone 5 is custom addition used in e.g. in [FlexTones.ultraContrast].
  ///
  /// The added tones 4, 6, 12, 17, 22 are for new dark mode surfaces in
  /// revised Material 3 dark surface colors. Likewise added tones
  /// 97, 96, 94, 92, 87 are for light mode surfaces in the updated Material 3
  /// color system. For more information, see:
  /// https://m3.material.io/styles/color/the-color-system/color-roles
  /// The additional tones in the Material 3 specification appeared during later
  /// pert of first half of 2023.
  ///
  /// Tones 5, 97, and 98 are not in old or new M3 spec, but FlexSeedScheme
  /// includes them to enable even more fidelity in dark and even more so in
  /// the light tones.
  ///
  /// Tone 98 provides optional tonal fidelity in the light and white end of the
  /// palette and tone 5 a more dark tone in the black end of the palette.
  static const List<int> extendedTones = <int>[
    0,
    4,
    5,
    6,
    10,
    12,
    17,
    20,
    22,
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
  /// to [TonalPalette.commonTones.length]. Here we instead manually set it
  /// to compile time const of same const list length.
  ///
  /// Flutter SDK [TonalPalette] has 13 tones, [FlexTonalPalette] extended 25.
  static const int extendedSize = 25;

  final double? _hue;
  final double? _chroma;
  final FlexPaletteType _paletteType;
  final Map<int, int> _cache;

  FlexTonalPalette._fromHueAndChroma(
    double hue,
    double chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : _cache = <int, int>{},
        _hue = hue,
        _chroma = chroma,
        _paletteType = paletteType;

  const FlexTonalPalette._fromCache(
    Map<int, int> cache, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : _cache = cache,
        _hue = null,
        _chroma = null,
        _paletteType = paletteType;

  /// Create colors using [hue] and [chroma].
  static FlexTonalPalette of(
    double hue,
    double chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    return FlexTonalPalette._fromHueAndChroma(hue, chroma, paletteType);
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
    Map<int, int> cache;
    cache = <int, int>{};
    switch (paletteType) {
      case FlexPaletteType.common:
        commonTones.asMap().forEach(
            (int index, int toneValue) => cache[toneValue] = colors[index]);
      case FlexPaletteType.extended:
        extendedTones.asMap().forEach(
            (int index, int toneValue) => cache[toneValue] = colors[index]);
    }
    return FlexTonalPalette._fromCache(cache, paletteType);
  }

  /// Returns a fixed-size list of ARGB color ints for common tone values.
  ///
  /// Inverse of [fromList].
  List<int> get asList => _paletteType == FlexPaletteType.common
      ? commonTones.map(get).toList()
      : extendedTones.map(get).toList();

  /// Returns the ARGB representation of an HCT color.
  ///
  /// If the class was instantiated from [_hue] and [_chroma], will return the
  /// color with corresponding [tone].
  /// If the class was instantiated from a fixed-size list of color ints, [tone]
  /// must be in [commonTones] if palette type is [FlexPaletteType.common] and
  /// in [extendedTones] if palette type is [FlexPaletteType.extended].
  int get(int tone) {
    if (_hue == null || _chroma == null) {
      if (!_cache.containsKey(tone)) {
        throw ArgumentError.value(
          tone,
          'tone',
          'When a FlexTonalPalette is created with fromList using '
              '$_paletteType, tone must be one of '
              // ignore: lines_longer_than_80_chars
              '${_paletteType == FlexPaletteType.common ? commonTones : extendedTones}.',
        );
      } else {
        return _cache[tone]!;
      }
    }

    // If we are using `common` tonal palette type and the tone is larger or
    // equal to 90, allow maximum chroma value of 90, in other cases
    // use the actual chroma value.
    final double chroma =
        (tone >= 90.0) && _paletteType == FlexPaletteType.common
            ? math.min(_chroma!, 40.0)
            : _chroma!;
    return _cache.putIfAbsent(
        tone, () => Hct.from(_hue!, chroma, tone.toDouble()).toInt());
  }

  @override
  bool operator ==(Object other) {
    if (other is FlexTonalPalette) {
      if (_hue != null &&
          _chroma != null &&
          other._hue != null &&
          other._chroma != null) {
        // Both created with .of or .fromHct
        return _hue == other._hue &&
            _chroma == other._chroma &&
            _paletteType == other._paletteType;
      } else {
        return const ListEquality<int>().equals(asList, other.asList);
      }
    }
    return false;
  }

  @override
  int get hashCode {
    if (_hue != null && _chroma != null) {
      return Object.hash(_hue, _chroma, _paletteType);
    } else {
      return Object.hashAll(asList);
    }
  }

  @override
  String toString() {
    if (_hue != null && _chroma != null) {
      return 'FlexTonalPalette.of($_hue, $_chroma, $_paletteType)';
    } else {
      return 'FlexTonalPalette.fromList($_cache, $_paletteType)';
    }
  }
}
