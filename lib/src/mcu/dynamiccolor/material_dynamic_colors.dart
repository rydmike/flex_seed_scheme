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
import 'dynamic_color.dart';
import 'src/contrast_curve.dart';
import 'src/tone_delta_pair.dart';

bool _isFidelity(DynamicScheme scheme) =>
    scheme.variant == Variant.fidelity || scheme.variant == Variant.content;

bool _isMonochrome(DynamicScheme scheme) =>
    scheme.variant == Variant.monochrome;

bool _useExpressiveOnContainers(DynamicScheme scheme) =>
    scheme.useExpressiveOnContainerColors;

/// Tokens, or named colors, in the Material Design system.
class MaterialDynamicColors {
  /// Required tone delta for content accent.
  static const double contentAccentToneDelta = 15.0;

  /// Get DynamicColor for highestSurface.
  static DynamicColor highestSurface(DynamicScheme s) {
    return s.isDark ? surfaceBright : surfaceDim;
  }

  /// Get DynamicColor for primaryPaletteKeyColor.
  static DynamicColor primaryPaletteKeyColor = DynamicColor.fromPalette(
    name: 'primary_palette_key_color',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => s.primaryPalette.keyColor.tone,
  );

  /// Get DynamicColor for secondaryPaletteKeyColor.
  static DynamicColor secondaryPaletteKeyColor = DynamicColor.fromPalette(
    name: 'secondary_palette_key_color',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => s.secondaryPalette.keyColor.tone,
  );

  /// Get DynamicColor for tertiaryPaletteKeyColor.
  static DynamicColor tertiaryPaletteKeyColor = DynamicColor.fromPalette(
    name: 'tertiary_palette_key_color',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) => s.tertiaryPalette.keyColor.tone,
  );

  /// Get DynamicColor for neutralPaletteKeyColor.
  static DynamicColor neutralPaletteKeyColor = DynamicColor.fromPalette(
    name: 'neutral_palette_key_color',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.neutralPalette.keyColor.tone,
  );

  /// Get DynamicColor for neutralVariantPaletteKeyColor.
  static DynamicColor neutralVariantPaletteKeyColor = DynamicColor.fromPalette(
    name: 'neutral_variant_palette_key_color',
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.neutralVariantPalette.keyColor.tone,
  );

  /// Get DynamicColor for background.
  static DynamicColor background = DynamicColor.fromPalette(
    name: 'background',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 6 : 98,
    isBackground: true,
  );

  /// Get DynamicColor for backgroundDim.
  static DynamicColor onBackground = DynamicColor.fromPalette(
    name: 'on_background',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 10,
    background: (DynamicScheme s) => MaterialDynamicColors.background,
    contrastCurve: ContrastCurve(3, 3, 4.5, 7),
  );

  /// Get DynamicColor for surface.
  static DynamicColor surface = DynamicColor.fromPalette(
    name: 'surface',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 6 : 98,
    isBackground: true,
  );

  /// Get DynamicColor for surfaceDim.
  static DynamicColor surfaceDim = DynamicColor.fromPalette(
    name: 'surface_dim',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) =>
        s.isDark ? 6 : ContrastCurve(87, 87, 80, 75).get(s.contrastLevel),
    isBackground: true,
  );

  /// Get DynamicColor for surfaceBright.
  static DynamicColor surfaceBright = DynamicColor.fromPalette(
    name: 'surface_bright',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) =>
        s.isDark ? ContrastCurve(24, 24, 29, 34).get(s.contrastLevel) : 98,
    isBackground: true,
  );

  /// Get DynamicColor for surfaceContainerLowest.
  static DynamicColor surfaceContainerLowest = DynamicColor.fromPalette(
    name: 'surface_container_lowest',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) =>
        s.isDark ? ContrastCurve(4, 4, 2, 0).get(s.contrastLevel) : 100,
    isBackground: true,
  );

  /// Get DynamicColor for surfaceContainerLow.
  static DynamicColor surfaceContainerLow = DynamicColor.fromPalette(
    name: 'surface_container_low',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark
        ? ContrastCurve(10, 10, 11, 12).get(s.contrastLevel)
        : ContrastCurve(96, 96, 96, 95).get(s.contrastLevel),
    isBackground: true,
  );

  /// Get DynamicColor for surfaceContainer.
  static DynamicColor surfaceContainer = DynamicColor.fromPalette(
    name: 'surface_container',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark
        ? ContrastCurve(12, 12, 16, 20).get(s.contrastLevel)
        : ContrastCurve(94, 94, 92, 90).get(s.contrastLevel),
    isBackground: true,
  );

  /// Get DynamicColor for surfaceContainerHigh.
  static DynamicColor surfaceContainerHigh = DynamicColor.fromPalette(
    name: 'surface_container_high',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark
        ? ContrastCurve(17, 17, 21, 25).get(s.contrastLevel)
        : ContrastCurve(92, 92, 88, 85).get(s.contrastLevel),
    isBackground: true,
  );

  /// Get DynamicColor for surfaceContainerHighest.
  static DynamicColor surfaceContainerHighest = DynamicColor.fromPalette(
    name: 'surface_container_highest',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark
        ? ContrastCurve(22, 22, 26, 30).get(s.contrastLevel)
        : ContrastCurve(90, 90, 84, 80).get(s.contrastLevel),
    isBackground: true,
  );

  /// Get DynamicColor for onSurface.
  static DynamicColor onSurface = DynamicColor.fromPalette(
    name: 'on_surface',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 10,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for surfaceVariant.
  static DynamicColor surfaceVariant = DynamicColor.fromPalette(
    name: 'surface_variant',
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 90,
    isBackground: true,
  );

  /// Get DynamicColor for onSurfaceVariant.
  static DynamicColor onSurfaceVariant = DynamicColor.fromPalette(
    name: 'on_surface_variant',
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 30,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for inverseSurface.
  static DynamicColor inverseSurface = DynamicColor.fromPalette(
    name: 'inverse_surface',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 20,
  );

  /// Get DynamicColor for inverseOnSurface.
  static DynamicColor inverseOnSurface = DynamicColor.fromPalette(
    name: 'inverse_on_surface',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 20 : 95,
    background: (DynamicScheme s) => MaterialDynamicColors.inverseSurface,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for outline.
  static DynamicColor outline = DynamicColor.fromPalette(
    name: 'outline',
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 60 : 50,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1.5, 3, 4.5, 7),
  );

  /// Get DynamicColor for outlineVariant.
  static DynamicColor outlineVariant = DynamicColor.fromPalette(
    name: 'outline_variant',
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 80,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
  );

  /// Get DynamicColor for shadow.
  static DynamicColor shadow = DynamicColor.fromPalette(
    name: 'shadow',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => 0,
  );

  /// Get DynamicColor for scrim.
  static DynamicColor scrim = DynamicColor.fromPalette(
    name: 'scrim',
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => 0,
  );

  /// Get DynamicColor for surfaceTint.
  static DynamicColor surfaceTint = DynamicColor.fromPalette(
    name: 'surface_tint',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
    isBackground: true,
  );

  /// Get DynamicColor for primary.
  static DynamicColor primary = DynamicColor.fromPalette(
    name: 'primary',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 100 : 0;
      }
      return s.isDark ? 80 : 40;
    },
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 7),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.primaryContainer,
        MaterialDynamicColors.primary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onPrimary.
  static DynamicColor onPrimary = DynamicColor.fromPalette(
    name: 'on_primary',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 90;
      }
      return s.isDark ? 20 : 100;
    },
    background: (DynamicScheme s) => MaterialDynamicColors.primary,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for primaryContainer.
  static DynamicColor primaryContainer = DynamicColor.fromPalette(
    name: 'primary_container',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isFidelity(s)) {
        return s.sourceColorHct.tone;
      }
      if (_isMonochrome(s)) {
        return s.isDark ? 85 : 25;
      }
      return s.isDark ? 30 : 90;
    },
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.primaryContainer,
        MaterialDynamicColors.primary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onPrimaryContainer.
  static DynamicColor onPrimaryContainer = DynamicColor.fromPalette(
    name: 'on_primary_container',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isFidelity(s)) {
        return DynamicColor.foregroundTone(
            MaterialDynamicColors.primaryContainer.tone(s), 4.5);
      }
      if (_isMonochrome(s)) {
        return s.isDark ? 0 : 100;
      }
      if (_useExpressiveOnContainers(s)) {
        return s.isDark ? 90 : 30;
      } else {
        return s.isDark ? 90 : 10;
      }
    },
    background: (DynamicScheme s) => MaterialDynamicColors.primaryContainer,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for inversePrimary.
  static DynamicColor inversePrimary = DynamicColor.fromPalette(
    name: 'inverse_primary',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 40 : 80,
    background: (DynamicScheme s) => MaterialDynamicColors.inverseSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 7),
  );

  /// Get DynamicColor for inverseOnPrimary.
  static DynamicColor secondary = DynamicColor.fromPalette(
    name: 'secondary',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 7),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.secondaryContainer,
        MaterialDynamicColors.secondary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onSecondary.
  static DynamicColor onSecondary = DynamicColor.fromPalette(
    name: 'on_secondary',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 100;
      } else {
        return s.isDark ? 20 : 100;
      }
    },
    background: (DynamicScheme s) => MaterialDynamicColors.secondary,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for secondaryContainer.
  static DynamicColor secondaryContainer = DynamicColor.fromPalette(
    name: 'secondary_container',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) {
      final double initialTone = s.isDark ? 30.0 : 90.0;
      if (_isMonochrome(s)) {
        return s.isDark ? 30 : 85;
      }
      if (!_isFidelity(s)) {
        return initialTone;
      }
      return _findDesiredChromaByTone(
          s.secondaryPalette.hue,
          // ignore: avoid_bool_literals_in_conditional_expressions
          s.secondaryPalette.chroma,
          initialTone,
          // ignore: avoid_bool_literals_in_conditional_expressions
          s.isDark ? false : true);
    },
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.secondaryContainer,
        MaterialDynamicColors.secondary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onSecondaryContainer.
  static DynamicColor onSecondaryContainer = DynamicColor.fromPalette(
    name: 'on_secondary_container',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 90 : 10;
      }
      if (!_isFidelity(s)) {
        if (_useExpressiveOnContainers(s)) {
          return s.isDark ? 90 : 30;
        } else {
          return s.isDark ? 90 : 10;
        }
      }
      return DynamicColor.foregroundTone(
          MaterialDynamicColors.secondaryContainer.tone(s), 4.5);
    },
    background: (DynamicScheme s) => MaterialDynamicColors.secondaryContainer,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for tertiary.
  static DynamicColor tertiary = DynamicColor.fromPalette(
    name: 'tertiary',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 90 : 25;
      }
      return s.isDark ? 80 : 40;
    },
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 7),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.tertiaryContainer,
        MaterialDynamicColors.tertiary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onTertiary.
  static DynamicColor onTertiary = DynamicColor.fromPalette(
    name: 'on_tertiary',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 90;
      }
      return s.isDark ? 20 : 100;
    },
    background: (DynamicScheme s) => MaterialDynamicColors.tertiary,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for tertiaryContainer.
  static DynamicColor tertiaryContainer = DynamicColor.fromPalette(
    name: 'tertiary_container',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 60 : 49;
      }
      if (!_isFidelity(s)) {
        return s.isDark ? 30 : 90;
      }
      final Hct proposedHct = s.tertiaryPalette.getHct(s.sourceColorHct.tone);
      return DislikeAnalyzer.fixIfDisliked(proposedHct).tone;
    },
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.tertiaryContainer,
        MaterialDynamicColors.tertiary,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onTertiaryContainer.
  static DynamicColor onTertiaryContainer = DynamicColor.fromPalette(
    name: 'on_tertiary_container',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 0 : 100;
      }
      if (!_isFidelity(s)) {
        if (_useExpressiveOnContainers(s)) {
          return s.isDark ? 90 : 30;
        } else {
          return s.isDark ? 90 : 10;
        }
      }
      return DynamicColor.foregroundTone(
          MaterialDynamicColors.tertiaryContainer.tone(s), 4.5);
    },
    background: (DynamicScheme s) => MaterialDynamicColors.tertiaryContainer,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for error.
  static DynamicColor error = DynamicColor.fromPalette(
    name: 'error',
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(3, 4.5, 7, 7),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.errorContainer,
        MaterialDynamicColors.error,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onError.
  static DynamicColor onError = DynamicColor.fromPalette(
    name: 'on_error',
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 20 : 100,
    background: (DynamicScheme s) => MaterialDynamicColors.error,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for errorContainer.
  static DynamicColor errorContainer = DynamicColor.fromPalette(
    name: 'error_container',
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 90,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.errorContainer,
        MaterialDynamicColors.error,
        10,
        TonePolarity.nearer,
        false),
  );

  /// Get DynamicColor for onErrorContainer.
  static DynamicColor onErrorContainer = DynamicColor.fromPalette(
    name: 'on_error_container',
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 90 : 10;
      }
      if (_useExpressiveOnContainers(s)) {
        return s.isDark ? 90 : 30;
      } else {
        return s.isDark ? 90 : 10;
      }
    },
    background: (DynamicScheme s) => MaterialDynamicColors.errorContainer,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for primaryFixed.
  static DynamicColor primaryFixed = DynamicColor.fromPalette(
    name: 'primary_fixed',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 40.0 : 90.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.primaryFixed,
        MaterialDynamicColors.primaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for primaryFixedDim.
  static DynamicColor primaryFixedDim = DynamicColor.fromPalette(
    name: 'primary_fixed_dim',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 30.0 : 80.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.primaryFixed,
        MaterialDynamicColors.primaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for onPrimaryFixed.
  static DynamicColor onPrimaryFixed = DynamicColor.fromPalette(
    name: 'on_primary_fixed',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 100.0 : 10.0,
    background: (DynamicScheme s) => MaterialDynamicColors.primaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.primaryFixed,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for onPrimaryFixedVariant.
  static DynamicColor onPrimaryFixedVariant = DynamicColor.fromPalette(
    name: 'on_primary_fixed_variant',
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 90.0 : 30.0,
    background: (DynamicScheme s) => MaterialDynamicColors.primaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.primaryFixed,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for secondaryFixed.
  static DynamicColor secondaryFixed = DynamicColor.fromPalette(
    name: 'secondary_fixed',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 80.0 : 90.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.secondaryFixed,
        MaterialDynamicColors.secondaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for secondaryFixedDim.
  static DynamicColor secondaryFixedDim = DynamicColor.fromPalette(
    name: 'secondary_fixed_dim',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 70.0 : 80.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.secondaryFixed,
        MaterialDynamicColors.secondaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for onSecondaryFixed.
  static DynamicColor onSecondaryFixed = DynamicColor.fromPalette(
    name: 'on_secondary_fixed',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => 10.0,
    background: (DynamicScheme s) => MaterialDynamicColors.secondaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.secondaryFixed,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for onSecondaryFixedVariant.
  static DynamicColor onSecondaryFixedVariant = DynamicColor.fromPalette(
    name: 'on_secondary_fixed_variant',
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 25.0 : 30.0,
    background: (DynamicScheme s) => MaterialDynamicColors.secondaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.secondaryFixed,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  /// Get DynamicColor for tertiaryFixed.
  static DynamicColor tertiaryFixed = DynamicColor.fromPalette(
    name: 'tertiary_fixed',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 40.0 : 90.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.tertiaryFixed,
        MaterialDynamicColors.tertiaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for tertiaryFixedDim.
  static DynamicColor tertiaryFixedDim = DynamicColor.fromPalette(
    name: 'tertiary_fixed_dim',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 30.0 : 80.0,
    isBackground: true,
    background: MaterialDynamicColors.highestSurface,
    contrastCurve: ContrastCurve(1, 1, 3, 4.5),
    toneDeltaPair: (DynamicScheme s) => ToneDeltaPair(
        MaterialDynamicColors.tertiaryFixed,
        MaterialDynamicColors.tertiaryFixedDim,
        10,
        TonePolarity.lighter,
        true),
  );

  /// Get DynamicColor for onTertiaryFixed.
  static DynamicColor onTertiaryFixed = DynamicColor.fromPalette(
    name: 'on_tertiary_fixed',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 100.0 : 10.0,
    background: (DynamicScheme s) => MaterialDynamicColors.tertiaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.tertiaryFixed,
    contrastCurve: ContrastCurve(4.5, 7, 11, 21),
  );

  /// Get DynamicColor for onTertiaryFixedVariant.
  static DynamicColor onTertiaryFixedVariant = DynamicColor.fromPalette(
    name: 'on_tertiary_fixed_variant',
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) => _isMonochrome(s) ? 90.0 : 30.0,
    background: (DynamicScheme s) => MaterialDynamicColors.tertiaryFixedDim,
    secondBackground: (DynamicScheme s) => MaterialDynamicColors.tertiaryFixed,
    contrastCurve: ContrastCurve(3, 4.5, 7, 11),
  );

  static double _findDesiredChromaByTone(
      double hue, double chroma, double tone, bool byDecreasingTone) {
    double answer = tone;

    Hct closestToChroma = Hct.from(hue, chroma, tone);
    if (closestToChroma.chroma < chroma) {
      double chromaPeak = closestToChroma.chroma;
      while (closestToChroma.chroma < chroma) {
        answer += byDecreasingTone ? -1.0 : 1.0;
        final Hct potentialSolution = Hct.from(hue, chroma, answer);
        if (chromaPeak > potentialSolution.chroma) {
          break;
        }
        if ((potentialSolution.chroma - chroma).abs() < 0.4) {
          break;
        }

        final double potentialDelta = (potentialSolution.chroma - chroma).abs();
        final double currentDelta = (closestToChroma.chroma - chroma).abs();
        if (potentialDelta < currentDelta) {
          closestToChroma = potentialSolution;
        }
        chromaPeak = math.max(chromaPeak, potentialSolution.chroma);
      }
    }

    return answer;
  }
}
