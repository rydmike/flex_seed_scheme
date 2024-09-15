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

// TODO(rydmike): The original MCU doc for this states:
//  "A playful theme - the source color's hue does not appear in the theme."
// However, the hue actually matches the source hue and chroma is locked to 48.
// Not sure what is up with the original code doc, maybe report it.

/// A playful theme - the source color's chroma may not appear in the theme.
class SchemeRainbow extends DynamicScheme {
  /// Default SchemeRainbow constructor.
  SchemeRainbow({
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
    bool isErrorMonochrome = false,
  }) : super(
          sourceColorArgb: sourceColorHct.toInt(),
          variant: Variant.rainbow,
          primaryPalette: TonalPalette.of(
            sourceColorHct.hue,
            respectMonochromeSeed && isPrimaryMonochrome ? 0 : 48.0,
          ),
          secondaryPalette: secondarySourceColorHct != null
              ? TonalPalette.of(
                  secondarySourceColorHct.hue,
                  respectMonochromeSeed && isSecondaryMonochrome ? 0 : 16.0,
                )
              : TonalPalette.of(
                  sourceColorHct.hue,
                  respectMonochromeSeed && isSecondaryMonochrome ? 0 : 16.0,
                ),
          tertiaryPalette: tertiarySourceColorHct != null
              ? TonalPalette.of(
                  tertiarySourceColorHct.hue,
                  respectMonochromeSeed && isTertiaryMonochrome ? 0 : 24.0,
                )
              : TonalPalette.of(
                  MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 60.0),
                  respectMonochromeSeed && isTertiaryMonochrome ? 0 : 24.0,
                ),
          neutralPalette: TonalPalette.of(
            neutralSourceColorHct?.hue ?? sourceColorHct.hue,
            0.0,
          ),
          neutralVariantPalette: TonalPalette.of(
            neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
            0.0,
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
