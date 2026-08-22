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

import 'package:flex_seed_scheme/src/mcu/dynamiccolor/dynamic_scheme.dart';
import 'package:flex_seed_scheme/src/mcu/dynamiccolor/variant.dart';
import 'package:flex_seed_scheme/src/mcu/hct/hct.dart';
import 'package:flex_seed_scheme/src/mcu/palettes/tonal_palette.dart';
import 'package:flex_seed_scheme/src/mcu/utils/math_utils.dart';

/// A Dynamic Color theme with low to medium colorfulness and a Tertiary
/// [TonalPalette] with a hue related to the source color. The default
/// Material You theme on Android 12 and 13.
class SchemeTonalSpot extends DynamicScheme {
  /// SchemeTonalSpot default constructor.
  SchemeTonalSpot({
    required super.sourceColorHct,
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
         variant: Variant.tonalSpot,
         primaryPalette: TonalPalette.of(sourceColorHct.hue, respectMonochromeSeed && isPrimaryMonochrome ? 0 : 36.0),
         secondaryPalette: TonalPalette.of(
           secondarySourceColorHct?.hue ?? sourceColorHct.hue,
           respectMonochromeSeed && isSecondaryMonochrome ? 0 : 16,
         ),
         tertiaryPalette: TonalPalette.of(
           MathUtils.sanitizeDegreesDouble(tertiarySourceColorHct?.hue ?? (sourceColorHct.hue + 60.0)),
           respectMonochromeSeed && isTertiaryMonochrome ? 0 : 24.0,
         ),
         neutralPalette: TonalPalette.of(
           neutralSourceColorHct?.hue ?? sourceColorHct.hue,
           respectMonochromeSeed && isNeutralMonochrome ? 0 : 6,
         ),
         neutralVariantPalette: TonalPalette.of(
           neutralVariantSourceColorHct?.hue ?? sourceColorHct.hue,
           respectMonochromeSeed && isNeutralVariantMonochrome ? 0 : 8.0,
         ),
         errorPalette: errorSourceColorHct == null
             ? null
             : TonalPalette.of(
                 errorSourceColorHct.hue,
                 respectMonochromeSeed && isErrorMonochrome ? 0 : errorSourceColorHct.chroma,
               ),
       );
}
