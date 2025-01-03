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

// import 'package:material_color_utilities/hct/hct.dart';
// import 'package:material_color_utilities/palettes/tonal_palette.dart';
// import 'dynamic_scheme.dart';
// import 'variant.dart';

import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';
import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';

/// A Dynamic Color theme that maxes out colorfulness at each position in the
/// Primary [TonalPalette].
class SchemeVibrant extends DynamicScheme {
  /// SchemeVibrant default constructor.
  SchemeVibrant({
    required Hct sourceColorHct,
    required super.isDark,
    required super.contrastLevel,
    super.useExpressiveOnContainerColors,
    Hct? secondarySourceColorHct,
    Hct? tertiarySourceColorHct,
    Hct? neutralSourceColorHct,
    Hct? neutralVariantSourceColorHct,
    Hct? errorSourceColorHct,
    bool respectMonochromeSeed = false,
    bool isPrimaryMonochrome = false,
    bool isSecondaryMonochrome = false,
    bool isTertiaryMonochrome = false,
    bool isNeutralMonochrome = false,
    bool isNeutralVariantMonochrome = false,
    bool isErrorMonochrome = false,
  }) : super(
          sourceColorArgb: sourceColorHct.toInt(),
          variant: Variant.vibrant,
          primaryPalette: TonalPalette.of(sourceColorHct.hue,
              respectMonochromeSeed && isPrimaryMonochrome ? 0 : 200.0),
          secondaryPalette: TonalPalette.of(
            DynamicScheme.getRotatedHue(
                secondarySourceColorHct ?? sourceColorHct,
                hues,
                secondaryRotations),
            respectMonochromeSeed && isSecondaryMonochrome ? 0 : 24.0,
          ),
          tertiaryPalette: TonalPalette.of(
            DynamicScheme.getRotatedHue(
                tertiarySourceColorHct ?? sourceColorHct,
                hues,
                tertiaryRotations),
            respectMonochromeSeed && isTertiaryMonochrome ? 0 : 32.0,
          ),
          neutralPalette: TonalPalette.of(
              neutralSourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isNeutralMonochrome ? 0 : 10.0),
          neutralVariantPalette: TonalPalette.of(
              neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isNeutralVariantMonochrome ? 0 : 12.0),
          customErrorPalette: errorSourceColorHct == null
              ? null
              : TonalPalette.of(
                  errorSourceColorHct.hue,
                  respectMonochromeSeed && isErrorMonochrome
                      ? 0
                      : errorSourceColorHct.chroma),
        );

  /// Hues used at breakpoints such that designers can specify a hue rotation
  /// that occurs at a given break point.
  static final List<double> hues = <double>[
    0,
    41,
    61,
    101,
    131,
    181,
    251,
    301,
    360,
  ];

  /// Hue rotations of the Secondary [TonalPalette], corresponding to the
  /// breakpoints in [hues].
  static final List<double> secondaryRotations = <double>[
    18,
    15,
    10,
    12,
    15,
    18,
    15,
    12,
    12,
  ];

  /// Hue rotations of the Tertiary [TonalPalette], corresponding to the
  /// breakpoints in [hues].
  static final List<double> tertiaryRotations = <double>[
    35,
    30,
    20,
    25,
    30,
    35,
    30,
    25,
    25,
  ];
}
