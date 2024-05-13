// Copyright 2023 Google LLC
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

import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';

DynamicScheme schemeFromVariant({
  required Variant variant,
  required Hct sourceColorHct,
  required bool isDark,
  required double contrastLevel,
}) {
  switch (variant) {
    case Variant.content:
      return SchemeContent(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.expressive:
      return SchemeExpressive(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.fidelity:
      return SchemeFidelity(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.fruitSalad:
      return SchemeFruitSalad(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.monochrome:
      return SchemeMonochrome(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.neutral:
      return SchemeNeutral(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.rainbow:
      return SchemeRainbow(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.tonalSpot:
      return SchemeTonalSpot(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
    case Variant.vibrant:
      return SchemeVibrant(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      );
  }
}
