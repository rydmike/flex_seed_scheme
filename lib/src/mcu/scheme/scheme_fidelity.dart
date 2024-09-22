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
import 'dart:math' as math;

import '../dislike/dislike_analyzer.dart';
import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';
import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../temperature/temperature_cache.dart';

/// A scheme that places the source color in Scheme.primaryContainer.
///
/// Primary Container is the source color, adjusted for color relativity.
/// It maintains constant appearance in light mode and dark mode.
/// This adds ~5 tone in light mode, and subtracts ~5 tone in dark mode.
///
/// Tertiary Container is the complement to the source color, using
/// [TemperatureCache]. It also maintains constant appearance.
class SchemeFidelity extends DynamicScheme {
  /// Default SchemeFidelity constructor.
  SchemeFidelity({
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
          variant: Variant.fidelity,
          primaryPalette: TonalPalette.of(
            sourceColorHct.hue,
            respectMonochromeSeed && isPrimaryMonochrome
                ? 0
                : sourceColorHct.chroma,
          ),
          secondaryPalette: secondarySourceColorHct != null
              ? TonalPalette.of(
                  secondarySourceColorHct.hue,
                  respectMonochromeSeed && isSecondaryMonochrome
                      ? 0
                      : math.max(secondarySourceColorHct.chroma - 32.0,
                          secondarySourceColorHct.chroma * 0.5),
                )
              : TonalPalette.of(
                  sourceColorHct.hue,
                  respectMonochromeSeed && isSecondaryMonochrome
                      ? 0
                      : math.max(sourceColorHct.chroma - 32.0,
                          sourceColorHct.chroma * 0.5),
                ),
          tertiaryPalette: tertiarySourceColorHct != null
              ? TonalPalette.of(
                  tertiarySourceColorHct.hue,
                  respectMonochromeSeed && isTertiaryMonochrome
                      ? 0
                      : tertiarySourceColorHct.chroma,
                )
              : respectMonochromeSeed
                  ? TonalPalette.of(sourceColorHct.hue, 0)
                  : TonalPalette.fromHct(
                      DislikeAnalyzer.fixIfDisliked(
                        TemperatureCache(sourceColorHct).complement,
                      ),
                    ),
          neutralPalette: TonalPalette.of(
            neutralSourceColorHct?.hue ?? sourceColorHct.hue,
            respectMonochromeSeed && isNeutralMonochrome
                ? 0
                : (neutralSourceColorHct?.chroma ?? sourceColorHct.chroma) /
                    8.0,
          ),
          neutralVariantPalette: TonalPalette.of(
            neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
            respectMonochromeSeed && isNeutralVariantMonochrome
                ? 0
                : ((neutralVariantSourceColorHct?.chroma ??
                            sourceColorHct.chroma) /
                        8.0) +
                    4.0,
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
