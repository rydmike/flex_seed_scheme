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

import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';
import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../utils/math_utils.dart';

/// A Dynamic Color theme that is intentionally detached from the input color.
class SchemeExpressive extends DynamicScheme {
  /// SchemeExpressive default constructor.
  SchemeExpressive({
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
          variant: Variant.expressive,
          primaryPalette: TonalPalette.of(
            MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 240.0),
            respectMonochromeSeed && isPrimaryMonochrome ? 0 : 40.0,
          ),
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
              (neutralSourceColorHct?.hue ?? sourceColorHct.hue) + 15.0,
              respectMonochromeSeed && isNeutralMonochrome ? 0 : 8.0),
          neutralVariantPalette: TonalPalette.of(
              (neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue) + 15.0,
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
    21,
    51,
    121,
    151,
    191,
    271,
    321,
    360
  ];

  /// Hue rotations of the Secondary [TonalPalette], corresponding to the
  /// breakpoints in [hues].
  static final List<double> secondaryRotations = <double>[
    45,
    95,
    45,
    20,
    45,
    90,
    45,
    45,
    45
  ];

  /// Hue rotations of the Tertiary [TonalPalette], corresponding to the
  /// breakpoints in [hues].
  static final List<double> tertiaryRotations = <double>[
    120,
    120,
    20,
    45,
    20,
    15,
    20,
    120,
    120
  ];
}
