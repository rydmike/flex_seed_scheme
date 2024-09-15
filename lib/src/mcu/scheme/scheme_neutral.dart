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

/// A Dynamic Color theme that is near grayscale.
class SchemeNeutral extends DynamicScheme {
  /// Default SchemeNeutral constructor.
  SchemeNeutral({
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
          variant: Variant.neutral,
          primaryPalette: TonalPalette.of(sourceColorHct.hue,
              respectMonochromeSeed && isPrimaryMonochrome ? 0 : 12.0),
          secondaryPalette: TonalPalette.of(
              secondarySourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isSecondaryMonochrome ? 0 : 8.0),
          tertiaryPalette: TonalPalette.of(
              tertiarySourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isTertiaryMonochrome ? 0 : 16.0),
          neutralPalette: TonalPalette.of(
              neutralSourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isNeutralMonochrome ? 0 : 2.0),
          neutralVariantPalette: TonalPalette.of(
              neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
              respectMonochromeSeed && isNeutralVariantMonochrome ? 0 : 2.0),
          customErrorPalette: errorSourceColorHct == null
              ? null
              : TonalPalette.of(
                  errorSourceColorHct.hue,
                  respectMonochromeSeed && isErrorMonochrome
                      ? 0
                      : errorSourceColorHct.chroma),
        );
}
