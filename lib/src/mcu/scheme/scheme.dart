// Copyright 2021 Google LLC
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

// This file is automatically generated. Do not modify it.

// ignore_for_file: comment_references

import '../material_color_utilities.dart';

/// Prefer [ColorScheme]. This class is the same concept as Flutter's
/// ColorScheme class, inlined to ensure parity across languages.
@Deprecated('The `Scheme` class is deprecated in favor of `DynamicScheme`.\n'
    'Please see '
    'https://github.com/material-foundation/material-color-utilities/blob/main/make_schemes.md'
    'for migration guidance.')
class Scheme {
  /// primary color as int.
  final int primary;

  /// onPrimary color as int.
  final int onPrimary;

  /// primaryContainer color as int.
  final int primaryContainer;

  /// onPrimaryContainer color as int.
  final int onPrimaryContainer;

  /// secondary color as int.
  final int secondary;

  /// onSecondary color as int.
  final int onSecondary;

  /// secondaryContainer color as int.
  final int secondaryContainer;

  /// onSecondaryContainer color as int.
  final int onSecondaryContainer;

  /// tertiary color as int.
  final int tertiary;

  /// onTertiary color as int.
  final int onTertiary;

  /// tertiaryContainer color as int.
  final int tertiaryContainer;

  /// onTertiaryContainer color as int.
  final int onTertiaryContainer;

  /// error color as int.
  final int error;

  /// onError color as int.
  final int onError;

  /// errorContainer color as int.
  final int errorContainer;

  /// onErrorContainer color as int.
  final int onErrorContainer;

  /// background color as int.
  final int background;

  /// onBackground color as int.
  final int onBackground;

  /// surface color as int.
  final int surface;

  /// onSurface color as int.
  final int onSurface;

  /// surfaceVariant color as int.
  final int surfaceVariant;

  /// onSurfaceVariant color as int.
  final int onSurfaceVariant;

  /// outline color as int.
  final int outline;

  /// outlineVariant color as int.
  final int outlineVariant;

  /// shadow color as int.
  final int shadow;

  /// scrim color as int.
  final int scrim;

  /// inverseSurface color as int.
  final int inverseSurface;

  /// inverseOnSurface color as int.
  final int inverseOnSurface;

  /// inversePrimary color as int.
  final int inversePrimary;

  /// Default Scheme constructor.
  @Deprecated('The `Scheme` class is deprecated in favor of `DynamicScheme`.\n'
      'Please see '
      'https://github.com/material-foundation/material-color-utilities/blob/main/make_schemes.md'
      'for migration guidance.')
  const Scheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
  });

  /// Get light Scheme from CorePalette.
  static Scheme light(int color) => lightFromCorePalette(CorePalette.of(color));

  /// Get dark Scheme from CorePalette.
  static Scheme dark(int color) => darkFromCorePalette(CorePalette.of(color));

  /// Get Scheme for lightContent from CorePalette.
  static Scheme lightContent(int color) =>
      lightFromCorePalette(CorePalette.contentOf(color));

  /// Get Scheme for darkContent from CorePalette.
  static Scheme darkContent(int color) =>
      darkFromCorePalette(CorePalette.contentOf(color));

  /// Get Scheme from lightFromCorePalette.
  static Scheme lightFromCorePalette(CorePalette palette) => Scheme(
        primary: palette.primary.get(40),
        onPrimary: palette.primary.get(100),
        primaryContainer: palette.primary.get(90),
        onPrimaryContainer: palette.primary.get(10),
        secondary: palette.secondary.get(40),
        onSecondary: palette.secondary.get(100),
        secondaryContainer: palette.secondary.get(90),
        onSecondaryContainer: palette.secondary.get(10),
        tertiary: palette.tertiary.get(40),
        onTertiary: palette.tertiary.get(100),
        tertiaryContainer: palette.tertiary.get(90),
        onTertiaryContainer: palette.tertiary.get(10),
        error: palette.error.get(40),
        onError: palette.error.get(100),
        errorContainer: palette.error.get(90),
        onErrorContainer: palette.error.get(10),
        background: palette.neutral.get(99),
        onBackground: palette.neutral.get(10),
        surface: palette.neutral.get(99),
        onSurface: palette.neutral.get(10),
        surfaceVariant: palette.neutralVariant.get(90),
        onSurfaceVariant: palette.neutralVariant.get(30),
        outline: palette.neutralVariant.get(50),
        outlineVariant: palette.neutralVariant.get(80),
        shadow: palette.neutral.get(0),
        scrim: palette.neutral.get(0),
        inverseSurface: palette.neutral.get(20),
        inverseOnSurface: palette.neutral.get(95),
        inversePrimary: palette.primary.get(80),
      );

  /// Get Scheme from darkFromCorePalette.
  static Scheme darkFromCorePalette(CorePalette palette) => Scheme(
        primary: palette.primary.get(80),
        onPrimary: palette.primary.get(20),
        primaryContainer: palette.primary.get(30),
        onPrimaryContainer: palette.primary.get(90),
        secondary: palette.secondary.get(80),
        onSecondary: palette.secondary.get(20),
        secondaryContainer: palette.secondary.get(30),
        onSecondaryContainer: palette.secondary.get(90),
        tertiary: palette.tertiary.get(80),
        onTertiary: palette.tertiary.get(20),
        tertiaryContainer: palette.tertiary.get(30),
        onTertiaryContainer: palette.tertiary.get(90),
        error: palette.error.get(80),
        onError: palette.error.get(20),
        errorContainer: palette.error.get(30),
        // TODO(rydmike): This tone is wrong, based on both past and current
        //  spec it should be tone 90. MCU has always used the wrong tone here.
        //  whereas FSS has used the one from the spec. We will skip this color
        //  in the legacy test due to the error in the legacy Scheme.
        onErrorContainer: palette.error.get(80),
        background: palette.neutral.get(10),
        onBackground: palette.neutral.get(90),
        surface: palette.neutral.get(10),
        onSurface: palette.neutral.get(90),
        surfaceVariant: palette.neutralVariant.get(30),
        onSurfaceVariant: palette.neutralVariant.get(80),
        outline: palette.neutralVariant.get(60),
        outlineVariant: palette.neutralVariant.get(30),
        shadow: palette.neutral.get(0),
        scrim: palette.neutral.get(0),
        inverseSurface: palette.neutral.get(90),
        inverseOnSurface: palette.neutral.get(20),
        inversePrimary: palette.primary.get(40),
      );
}
