/*
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:meta/meta.dart';

import 'tonal_palette.dart';

/// Comprises foundational palettes to build a color scheme. Generated from a
/// source color, these palettes will then be part of a `DynamicScheme`
/// together with appearance preferences.
///
/// FlexSeedScheme information:
///
/// This exists in MCU but is not used by anything in MCU nor is it
/// exported. It exists because CorePalette was deprecated in MCU in favor of
/// DynamicScheme, and CorePalettes is the replacement for CorePalette.
/// It is missing error palette compared to CorePalette and seems a bit
/// half baked in MCU 0.13.0. We add equality, hashCode and toString
/// that is missing compared to CorePalettes in MCU.
/// We include it here for completeness. Recommend using
/// DynamicScheme instead or old CorePalette.
@immutable
class CorePalettes {
  /// Construct a set of core palettes.
  const CorePalettes(
    this.primary,
    this.secondary,
    this.tertiary,
    this.neutral,
    this.neutralVariant,
  );

  /// Primary tonal palette.
  final TonalPalette primary;

  /// Secondary tonal palette.
  final TonalPalette secondary;

  /// Tertiary tonal palette.
  final TonalPalette tertiary;

  /// Neutral tonal palette.
  final TonalPalette neutral;

  /// Neutral variant tonal palette.
  final TonalPalette neutralVariant;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is CorePalettes &&
        primary == other.primary &&
        secondary == other.secondary &&
        tertiary == other.tertiary &&
        neutral == other.neutral &&
        neutralVariant == other.neutralVariant;
  }

  @override
  int get hashCode => Object.hash(
        primary,
        secondary,
        tertiary,
        neutral,
        neutralVariant,
      );

  @override
  String toString() {
    return 'primary: $primary, '
        'secondary: $secondary, '
        'tertiary: $tertiary, '
        'neutral: $neutral, '
        'neutralVariant: $neutralVariant';
  }
}
