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

// TODO(rydmike): The doc below is what the MCU source says and does, BUT
// the hue actually matches the source hue, but chroma is locked to 45.
// Not sure what is up with the orig source code, but this is how it is now.

/// A playful theme - the source color's hue does not appear in the theme.
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
  }) : super(
          sourceColorArgb: sourceColorHct.toInt(),
          variant: Variant.rainbow,
          primaryPalette: TonalPalette.of(
            sourceColorHct.hue,
            48.0,
          ),
          secondaryPalette: secondarySourceColorHct != null
              ? TonalPalette.of(
                  secondarySourceColorHct.hue,
                  16.0,
                )
              : TonalPalette.of(
                  sourceColorHct.hue,
                  16.0,
                ),
          tertiaryPalette: tertiarySourceColorHct != null
              ? TonalPalette.of(
                  tertiarySourceColorHct.hue,
                  24.0,
                )
              : TonalPalette.of(
                  MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 60.0),
                  24.0,
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
                  errorSourceColorHct.hue, errorSourceColorHct.chroma),
        );
}
