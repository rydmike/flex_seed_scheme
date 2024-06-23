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
import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../utils/math_utils.dart';
import 'dynamic_color.dart';
import 'material_dynamic_colors.dart';
import 'variant.dart';

/// Constructed by a set of values representing the current UI state (such as
/// whether or not its dark theme, what the theme style is, etc.), and
/// provides a set of [TonalPalette]s that can create colors that fit in
/// with the theme style. Used by [DynamicColor] to resolve into a color.
class DynamicScheme {
  /// The source color of the theme as an ARGB integer.
  final int sourceColorArgb;

  /// The source color of the theme in HCT.
  final Hct sourceColorHct;

  /// The variant, or style, of the theme.
  final Variant variant;

  /// Whether or not the scheme is in 'dark mode' or 'light mode'.
  final bool isDark;

  /// Value from -1 to 1. -1 represents minimum contrast, 0 represents
  /// standard (i.e. the design as spec'd), and 1 represents maximum contrast.
  final double contrastLevel;

  /// Use expressive on container colors for light mode.
  ///
  /// Material spec and MCU v0.12.0 changes light mode on colors for
  /// containers from tone 10 to tone 30 can the `ContrastCurve` from
  /// ContrastCurve(4.5, 7.0, 11.0, 21.0) to
  /// ContrastCurve(3.0, 4.5, 7.0, 11.0), making min contrast for normal 4.5
  /// instead of past 7.0.
  ///
  /// This change is not yet used by Flutter and not fully documented in the
  /// M3 guide. In this MCY fork we are making this change a deliberate opt-in
  /// feature and default to not opting in on it. This default may be adjusted
  /// later to opt-in by default, but FSS will continue to offer the older
  /// version with better contrast too.
  ///
  /// Defaults to false in FSS version 3.0.0.
  ///
  /// The result you get with false, corresponds to used results in MCU until
  /// version 0.11.1. Version 0.12.0 of MCU it corresponds to setting
  /// this flag to true. This is a breaking change in MCU 0.12.0 and will
  /// change the light mode color schemes produced by all DynamicColor based
  /// Material color schemes.
  final bool useExpressiveOnContainerColors;

  /// Given a tone, produces a color. Hue and chroma of the color are specified
  /// in the design specification of the variant. Usually colorful.
  final TonalPalette primaryPalette;

  /// Given a tone, produces a color. Hue and chroma of the color are specified
  /// in the design specification of the variant. Usually less colorful.
  final TonalPalette secondaryPalette;

  /// Given a tone, produces a color. Hue and chroma of the color are specified
  /// in the design specification of the variant. Usually a different hue from
  /// primary and colorful.
  final TonalPalette tertiaryPalette;

  /// Given a tone, produces a color. Hue and chroma of the color are specified
  /// in the design specification of the variant. Usually not colorful at all,
  /// intended for background & surface colors.
  final TonalPalette neutralPalette;

  /// Given a tone, produces a color. Hue and chroma of the color are specified
  /// in the design specification of the variant. Usually not colorful, but
  /// slightly more colorful than Neutral. Intended for backgrounds & surfaces.
  final TonalPalette neutralVariantPalette;

  /// Given a tone, produces a reddish, colorful, color.
  final TonalPalette errorPalette;

  /// Primary constructor for [DynamicScheme].
  DynamicScheme({
    required this.sourceColorArgb,
    required this.variant,
    this.contrastLevel = 0.0,
    this.useExpressiveOnContainerColors = false,
    required this.isDark,
    required this.primaryPalette,
    required this.secondaryPalette,
    required this.tertiaryPalette,
    required this.neutralPalette,
    required this.neutralVariantPalette,
    TonalPalette? customErrorPalette,
  })  : sourceColorHct = Hct.fromInt(sourceColorArgb),
        errorPalette = customErrorPalette ?? TonalPalette.of(25.0, 84.0);

  /// Get the the rotated hue of the source color.
  static double getRotatedHue(
      Hct sourceColor, List<double> hues, List<double> rotations) {
    final double sourceHue = sourceColor.hue;
    assert(hues.length == rotations.length,
        'Hues and rotations length must match');
    if (rotations.length == 1) {
      return MathUtils.sanitizeDegreesDouble(sourceColor.hue + rotations[0]);
    }
    final int size = hues.length;
    for (int i = 0; i <= (size - 2); i++) {
      final double thisHue = hues[i];
      final double nextHue = hues[i + 1];
      if (thisHue < sourceHue && sourceHue < nextHue) {
        return MathUtils.sanitizeDegreesDouble(sourceHue + rotations[i]);
      }
    }
    // If this statement executes, something is wrong, there should have been a
    // rotation found using the arrays.
    return sourceHue;
  }

  /// Get the HCT color of the DynamicColor.
  Hct getHct(DynamicColor dynamicColor) => dynamicColor.getHct(this);

  /// Get the int ARGB color of the DynamicColor.
  int getArgb(DynamicColor dynamicColor) => dynamicColor.getArgb(this);

  // Getters.
  /// The primaryPaletteKeyColor color of the theme.
  int get primaryPaletteKeyColor =>
      getArgb(MaterialDynamicColors.primaryPaletteKeyColor);

  /// The secondaryPaletteKeyColor color of the theme.
  int get secondaryPaletteKeyColor =>
      getArgb(MaterialDynamicColors.secondaryPaletteKeyColor);

  /// The tertiaryPaletteKeyColor color of the theme.
  int get tertiaryPaletteKeyColor =>
      getArgb(MaterialDynamicColors.tertiaryPaletteKeyColor);

  /// The neutralPaletteKeyColor color of the theme.
  int get neutralPaletteKeyColor =>
      getArgb(MaterialDynamicColors.neutralPaletteKeyColor);

  /// The neutralVariantPaletteKeyColor variant color of the theme.
  int get neutralVariantPaletteKeyColor =>
      getArgb(MaterialDynamicColors.neutralVariantPaletteKeyColor);

  /// The background color of the theme.
  int get background => getArgb(MaterialDynamicColors.background);

  /// The onBackground color of the theme.
  int get onBackground => getArgb(MaterialDynamicColors.onBackground);

  /// The surface color of the theme.
  int get surface => getArgb(MaterialDynamicColors.surface);

  /// The surfaceDim color of the theme.
  int get surfaceDim => getArgb(MaterialDynamicColors.surfaceDim);

  /// The surfaceBright color of the theme.
  int get surfaceBright => getArgb(MaterialDynamicColors.surfaceBright);

  /// The surfaceContainerLowest color of the theme.
  int get surfaceContainerLowest =>
      getArgb(MaterialDynamicColors.surfaceContainerLowest);

  /// The surfaceContainerLow color of the theme.
  int get surfaceContainerLow =>
      getArgb(MaterialDynamicColors.surfaceContainerLow);

  /// The surfaceContainer color of the theme.
  int get surfaceContainer => getArgb(MaterialDynamicColors.surfaceContainer);

  /// The surfaceContainerHigh color of the theme.
  int get surfaceContainerHigh =>
      getArgb(MaterialDynamicColors.surfaceContainerHigh);

  /// The surfaceContainerHighest color of the theme.
  int get surfaceContainerHighest =>
      getArgb(MaterialDynamicColors.surfaceContainerHighest);

  /// The onSurface color of the theme.
  int get onSurface => getArgb(MaterialDynamicColors.onSurface);

  /// The surfaceVariant color of the theme.
  int get surfaceVariant => getArgb(MaterialDynamicColors.surfaceVariant);

  /// The onSurfaceVariant color of the theme.
  int get onSurfaceVariant => getArgb(MaterialDynamicColors.onSurfaceVariant);

  /// The inverseSurface color of the theme.
  int get inverseSurface => getArgb(MaterialDynamicColors.inverseSurface);

  /// The inverseOnSurface color of the theme.
  int get inverseOnSurface => getArgb(MaterialDynamicColors.inverseOnSurface);

  /// The inverseSurfaceVariant color of the theme.
  int get outline => getArgb(MaterialDynamicColors.outline);

  /// The outlineVariant color of the theme.
  int get outlineVariant => getArgb(MaterialDynamicColors.outlineVariant);

  /// The shadow color of the theme.
  int get shadow => getArgb(MaterialDynamicColors.shadow);

  /// The scrim color of the theme.
  int get scrim => getArgb(MaterialDynamicColors.scrim);

  /// The surfaceTint color of the theme.
  int get surfaceTint => getArgb(MaterialDynamicColors.surfaceTint);

  /// The primary color of the theme.
  int get primary => getArgb(MaterialDynamicColors.primary);

  /// The onPrimary color of the theme.
  int get onPrimary => getArgb(MaterialDynamicColors.onPrimary);

  /// The primaryContainer color of the theme.
  int get primaryContainer => getArgb(MaterialDynamicColors.primaryContainer);

  /// The onPrimaryContainer color of the theme.
  int get onPrimaryContainer =>
      getArgb(MaterialDynamicColors.onPrimaryContainer);

  /// The inversePrimary color of the theme.
  int get inversePrimary => getArgb(MaterialDynamicColors.inversePrimary);

  /// The secondary color of the theme.
  int get secondary => getArgb(MaterialDynamicColors.secondary);

  /// The onSecondary color of the theme.
  int get onSecondary => getArgb(MaterialDynamicColors.onSecondary);

  /// The secondaryContainer color of the theme.
  int get secondaryContainer =>
      getArgb(MaterialDynamicColors.secondaryContainer);

  /// The onSecondaryContainer color of the theme.
  int get onSecondaryContainer =>
      getArgb(MaterialDynamicColors.onSecondaryContainer);

  /// The tertiary color of the theme.
  int get tertiary => getArgb(MaterialDynamicColors.tertiary);

  /// The onTertiary color of the theme.
  int get onTertiary => getArgb(MaterialDynamicColors.onTertiary);

  /// The tertiaryContainer color of the theme.
  int get tertiaryContainer => getArgb(MaterialDynamicColors.tertiaryContainer);

  /// The onTertiaryContainer color of the theme.
  int get onTertiaryContainer =>
      getArgb(MaterialDynamicColors.onTertiaryContainer);

  /// The error color of the theme.
  int get error => getArgb(MaterialDynamicColors.error);

  /// The onError color of the theme.
  int get onError => getArgb(MaterialDynamicColors.onError);

  /// The errorContainer color of the theme.
  int get errorContainer => getArgb(MaterialDynamicColors.errorContainer);

  /// The onErrorContainer color of the theme.
  int get onErrorContainer => getArgb(MaterialDynamicColors.onErrorContainer);

  /// The primaryFixed color of the theme.
  int get primaryFixed => getArgb(MaterialDynamicColors.primaryFixed);

  /// The primaryFixedDim color of the theme.
  int get primaryFixedDim => getArgb(MaterialDynamicColors.primaryFixedDim);

  /// The onPrimaryFixed color of the theme.
  int get onPrimaryFixed => getArgb(MaterialDynamicColors.onPrimaryFixed);

  /// The onPrimaryFixedVariant color of the theme.
  int get onPrimaryFixedVariant =>
      getArgb(MaterialDynamicColors.onPrimaryFixedVariant);

  /// The secondaryFixed color of the theme.
  int get secondaryFixed => getArgb(MaterialDynamicColors.secondaryFixed);

  /// The secondaryFixedDim color of the theme.
  int get secondaryFixedDim => getArgb(MaterialDynamicColors.secondaryFixedDim);

  /// The onSecondaryFixed color of the theme.
  int get onSecondaryFixed => getArgb(MaterialDynamicColors.onSecondaryFixed);

  /// The onSecondaryFixedVariant color of the theme.
  int get onSecondaryFixedVariant =>
      getArgb(MaterialDynamicColors.onSecondaryFixedVariant);

  /// The tertiaryFixed color of the theme.
  int get tertiaryFixed => getArgb(MaterialDynamicColors.tertiaryFixed);

  /// The tertiaryFixedDim color of the theme.
  int get tertiaryFixedDim => getArgb(MaterialDynamicColors.tertiaryFixedDim);

  /// The onTertiaryFixed color of the theme.
  int get onTertiaryFixed => getArgb(MaterialDynamicColors.onTertiaryFixed);

  /// The onTertiaryFixedVariant color of the theme.
  int get onTertiaryFixedVariant =>
      getArgb(MaterialDynamicColors.onTertiaryFixedVariant);
}
