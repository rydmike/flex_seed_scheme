import 'dart:math' as math;

import 'package:collection/collection.dart' show ListEquality;
import 'package:meta/meta.dart' show immutable;

import '../mcu/material_color_utilities.dart';

// ignore_for_file: comment_references

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
/// 2. [fromList] From a fixed-size ([FlexTonalPalette.commonSize]) list of
///    int representing ARBG colors. Correctness (constant hue and chroma) of
///    the input is not enforced. [get] will only return the input colors,
///     corresponding to [commonTones].
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
  /// [FlexTonalPalette.commonTones.length]. Here we instead manually set it
  /// to compile time const of same const list length.
  ///
  /// Flutter SDK [TonalPalette] has 13 tones and [FlexTonalPalette] 15.
  static const int commonSize = 15;

  final double? _hue;
  final double? _chroma;
  final Map<int, int> _cache;

  FlexTonalPalette._fromHueAndChroma(double hue, double chroma)
      : _cache = <int, int>{},
        _hue = hue,
        _chroma = chroma;

  const FlexTonalPalette._fromCache(Map<int, int> cache)
      : _cache = cache,
        _hue = null,
        _chroma = null;

  /// Create colors using [hue] and [chroma].
  static FlexTonalPalette of(double hue, double chroma) {
    return FlexTonalPalette._fromHueAndChroma(hue, chroma);
  }

  /// Create colors from a fixed-size list of ARGB color ints.
  ///
  /// Inverse of [FlexTonalPalette.asList].
  static FlexTonalPalette fromList(List<int> colors) {
    assert(colors.length == commonSize, 'Length must be $commonSize');
    Map<int, int> cache;
    cache = <int, int>{};
    commonTones.asMap().forEach(
        (int index, int toneValue) => cache[toneValue] = colors[index]);
    return FlexTonalPalette._fromCache(cache);
  }

  /// Returns a fixed-size list of ARGB color ints for common tone values.
  ///
  /// Inverse of [fromList].
  List<int> get asList => commonTones.map(get).toList();

  /// Returns the ARGB representation of an HCT color.
  ///
  /// If the class was instantiated from [_hue] and [_chroma], will return the
  /// color with corresponding [tone].
  /// If the class was instantiated from a fixed-size list of color ints, [tone]
  /// must be in [commonTones].
  int get(int tone) {
    if (_hue == null || _chroma == null) {
      if (!_cache.containsKey(tone)) {
        throw ArgumentError.value(
          tone,
          'tone',
          'When a FlexTonalPalette is created with fromList, tone must be '
              'one of $commonTones',
        );
      } else {
        return _cache[tone]!;
      }
    }
    final double chroma = (tone >= 90.0) ? math.min(_chroma!, 40.0) : _chroma!;
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
        return _hue == other._hue && _chroma == other._chroma;
      } else {
        return const ListEquality<int>().equals(asList, other.asList);
      }
    }
    return false;
  }

  @override
  int get hashCode {
    if (_hue != null && _chroma != null) {
      return Object.hash(_hue, _chroma);
    } else {
      return Object.hashAll(asList);
    }
  }

  @override
  String toString() {
    if (_hue != null && _chroma != null) {
      return 'FlexTonalPalette.of($_hue, $_chroma)';
    } else {
      return 'FlexTonalPalette.fromList($_cache)';
    }
  }
}
