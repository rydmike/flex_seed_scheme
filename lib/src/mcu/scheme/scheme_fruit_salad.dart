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

/// A playful theme - the source color's hue does not appear in the theme.
class SchemeFruitSalad extends DynamicScheme {
  /// Default SchemeFruitSalad constructor.
  SchemeFruitSalad({
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
          variant: Variant.fruitSalad,
          primaryPalette: TonalPalette.of(
            MathUtils.sanitizeDegreesDouble(sourceColorHct.hue - 50.0),
            respectMonochromeSeed && isPrimaryMonochrome ? 0 : 48.0,
          ),
          secondaryPalette: TonalPalette.of(
            MathUtils.sanitizeDegreesDouble(
                (secondarySourceColorHct?.hue ?? sourceColorHct.hue) - 50.0),
            respectMonochromeSeed && isSecondaryMonochrome ? 0 : 36.0,
          ),
          tertiaryPalette: TonalPalette.of(
            tertiarySourceColorHct?.hue ?? sourceColorHct.hue,
            respectMonochromeSeed && isTertiaryMonochrome ? 0 : 36.0,
          ),
          neutralPalette: TonalPalette.of(
            neutralSourceColorHct?.hue ?? sourceColorHct.hue,
            respectMonochromeSeed && isNeutralMonochrome ? 0 : 10.0,
          ),
          neutralVariantPalette: TonalPalette.of(
            neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
            respectMonochromeSeed && isNeutralVariantMonochrome ? 0 : 16.0,
          ),
          customErrorPalette: errorSourceColorHct == null
              ? null
              : TonalPalette.of(
                  errorSourceColorHct.hue,
                  respectMonochromeSeed && isErrorMonochrome
                      ? 0
                      : errorSourceColorHct.chroma),
        );
}
