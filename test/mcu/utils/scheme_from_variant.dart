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
  return switch (variant) {
    Variant.content => SchemeContent(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.expressive => SchemeExpressive(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.fidelity => SchemeFidelity(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.fruitSalad => SchemeFruitSalad(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.monochrome => SchemeMonochrome(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.neutral => SchemeNeutral(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.rainbow => SchemeRainbow(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.tonalSpot => SchemeTonalSpot(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
    Variant.vibrant => SchemeVibrant(
        sourceColorHct: sourceColorHct,
        isDark: isDark,
        contrastLevel: contrastLevel,
      ),
  };
}
