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

import 'dart:math' as math;

import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/cupertino.dart';

import '../material_color_utilities.dart';

/// A convenience class for retrieving colors that are constant in hue and
/// chroma, but vary in tone.
///
/// This class can be instantiated in two ways:
/// 1. [of] From hue and chroma. (preferred)
/// 2. [fromList] From a fixed-size ([TonalPalette.commonSize]) list of ints
/// representing ARBG colors. Correctness (constant hue and chroma) of the input
/// is not enforced. [get] will only return the input colors, corresponding to
/// [commonTones].
@immutable
class TonalPalette {
  /// Commonly-used tone values.
  static const List<int> commonTones = <int>[
    0,
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
    99,
    100,
  ];

  /// commonSize
  static final int commonSize = commonTones.length;

  final double? _hue;

  /// Get the hue.
  double get hue => _hue ?? 0.0;
  final double? _chroma;

  /// Get the chroma.
  double get chroma => _chroma ?? 0.0;
  final Map<int, int> _cache;

  TonalPalette._fromHueAndChroma(double hue, double chroma)
      : _cache = <int, int>{},
        _hue = hue,
        _chroma = chroma;

  const TonalPalette._fromCache(Map<int, int> cache)
      : _cache = cache,
        _hue = null,
        _chroma = null;

  /// Create colors using [hue] and [chroma].
  static TonalPalette of(double hue, double chroma) {
    return TonalPalette._fromHueAndChroma(hue, chroma);
  }

  /// Create a Tonal Palette from hue and chroma of [hct].
  static TonalPalette fromHct(Hct hct) {
    return TonalPalette._fromHueAndChroma(hct.hue, hct.chroma);
  }

  /// Create colors from a fixed-size list of ARGB color ints.
  ///
  /// Inverse of [TonalPalette.asList].
  static TonalPalette fromList(List<int> colors) {
    assert(colors.length == commonSize, 'Colors length must be $commonSize');
    final Map<int, int> cache = <int, int>{};
    commonTones.asMap().forEach(
        (int index, int toneValue) => cache[toneValue] = colors[index]);
    return TonalPalette._fromCache(cache);
  }

  /// Returns a fixed-size list of ARGB color ints for common tone values.
  ///
  /// Inverse of [fromList].
  // ignore: unnecessary_lambdas
  List<int> get asList => commonTones.map((int tone) => get(tone)).toList();

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
          'When a TonalPalette is created with fromList, tone must be one of '
              '$commonTones',
        );
      } else {
        return _cache[tone]!;
      }
    }
    final double chroma = (tone >= 90.0) ? math.min(_chroma!, 40.0) : _chroma!;
    return _cache.putIfAbsent(
        tone, () => Hct.from(_hue!, chroma, tone.toDouble()).toInt());
  }

  /// getHct.
  Hct getHct(double tone) {
    // coverage:ignore-start
    if (_hue == null || _chroma == null) {
      if (!_cache.containsKey(tone)) {
        throw ArgumentError.value(
          tone,
          'tone',
          'When a TonalPalette is created with fromList, tone must be one of '
              '$commonTones',
        );
      }
      // coverage:ignore-end
    }
    return Hct.from(_hue!, _chroma!, tone);
  }

  @override
  bool operator ==(Object other) {
    if (other is TonalPalette) {
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
      return 'TonalPalette.of($_hue, $_chroma)';
    } else {
      return 'TonalPalette.fromList($_cache)';
    }
  }
}
