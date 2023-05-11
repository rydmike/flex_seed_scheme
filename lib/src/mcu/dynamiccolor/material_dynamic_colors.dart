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

import '../material_color_utilities.dart';
import 'src/tone_delta_constraint.dart';

bool _isFidelity(DynamicScheme scheme) =>
    scheme.variant == Variant.fidelity || scheme.variant == Variant.content;

bool _isMonochrome(DynamicScheme scheme) =>
    scheme.variant == Variant.monochrome;

/// Tokens, or named colors, in the Material Design system.
class MaterialDynamicColors {
  /// contentAccentToneDelta.
  static const double contentAccentToneDelta = 15.0;

  /// highestSurface.
  static DynamicColor highestSurface(DynamicScheme s) {
    return s.isDark ? surfaceBright : surfaceDim;
  }

  /// viewingConditionsForAlbers.
  static ViewingConditions viewingConditionsForAlbers(DynamicScheme scheme) {
    return ViewingConditions.make(backgroundLstar: scheme.isDark ? 30 : 80);
  }

  /// background color.
  static DynamicColor background = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 6 : 98,
  );

  /// color.
  static DynamicColor onBackground = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 10,
    background: (_) => background,
  );

  /// onBackground color.
  static DynamicColor surface = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 6 : 98,
  );

  /// surfaceDim color.
  static DynamicColor surfaceDim = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 6 : 87,
  );

  /// surfaceBright color.
  static DynamicColor surfaceBright = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 24 : 98,
  );

  /// surfaceContainerLowest color.
  static DynamicColor surfaceContainerLowest = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 4 : 100,
  );

  /// surfaceContainerLow color.
  static DynamicColor surfaceContainerLow = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 10 : 96,
  );

  /// surfaceContainer color.
  static DynamicColor surfaceContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 12 : 94,
  );

  /// surfaceContainerHigh color.
  static DynamicColor surfaceContainerHigh = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 17 : 92,
  );

  /// surfaceContainerHighest color.
  static DynamicColor surfaceContainerHighest = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 22 : 90,
  );

  /// onSurface color.
  static DynamicColor onSurface = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 10,
    background: highestSurface,
  );

  /// surfaceVariant color.
  static DynamicColor surfaceVariant = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 90,
  );

  /// onSurfaceVariant color.
  static DynamicColor onSurfaceVariant = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 30,
    background: (DynamicScheme s) => surfaceVariant,
  );

  /// inverseSurface color.
  static DynamicColor inverseSurface = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 20,
  );

  /// inverseOnSurface color.
  static DynamicColor inverseOnSurface = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => s.isDark ? 20 : 95,
    background: (DynamicScheme s) => inverseSurface,
  );

  /// outline color.
  static DynamicColor outline = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => 50,
    background: highestSurface,
  );

  /// outlineVariant color.
  static DynamicColor outlineVariant = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralVariantPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 80,
    background: highestSurface,
  );

  /// shadow color.
  static DynamicColor shadow = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => 0,
  );

  /// scrim color.
  static DynamicColor scrim = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.neutralPalette,
    tone: (DynamicScheme s) => 0,
  );

  /// surfaceTint color.
  static DynamicColor surfaceTint = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
  );

  /// primary color.
  static DynamicColor primary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 100 : 0;
      }
      return s.isDark ? 80 : 40;
    },
    background: highestSurface,
    toneDeltaConstraint: (DynamicScheme s) => ToneDeltaConstraint(
      delta: contentAccentToneDelta,
      keepAway: primaryContainer,
      keepAwayPolarity: s.isDark ? TonePolarity.darker : TonePolarity.lighter,
    ),
  );

  /// onPrimary color.
  static DynamicColor onPrimary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 90;
      }
      return s.isDark ? 20 : 100;
    },
    background: (DynamicScheme s) => primary,
  );

  /// primaryContainer color.
  static DynamicColor primaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    background: highestSurface,
    tone: (DynamicScheme s) {
      if (_isFidelity(s)) {
        return _performAlbers(s.sourceColorHct, s);
      }
      if (_isMonochrome(s)) {
        return s.isDark ? 85 : 25;
      }
      return s.isDark ? 30 : 90;
    },
  );

  /// onPrimaryContainer color.
  static DynamicColor onPrimaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    background: (DynamicScheme s) => primaryContainer,
    tone: (DynamicScheme s) {
      if (_isFidelity(s)) {
        return DynamicColor.foregroundTone(primaryContainer.tone(s), 4.5);
      }
      if (_isMonochrome(s)) {
        return s.isDark ? 0 : 100;
      }
      return s.isDark ? 90 : 10;
    },
  );

  /// inversePrimary color.
  static DynamicColor inversePrimary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.primaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 40 : 80,
    background: (DynamicScheme s) => inverseSurface,
  );

  /// secondary color.
  static DynamicColor secondary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
    background: highestSurface,
    toneDeltaConstraint: (DynamicScheme s) => ToneDeltaConstraint(
      delta: contentAccentToneDelta,
      keepAway: secondaryContainer,
      keepAwayPolarity: s.isDark ? TonePolarity.darker : TonePolarity.lighter,
    ),
  );

  /// onSecondary color.
  static DynamicColor onSecondary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.secondaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 100;
      } else {
        return s.isDark ? 20 : 100;
      }
    },
    background: (DynamicScheme s) => secondary,
  );

  /// secondaryContainer color.
  static DynamicColor secondaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.secondaryPalette,
    background: highestSurface,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 30 : 85;
      }
      final double initialTone = s.isDark ? 30.0 : 90.0;
      if (!_isFidelity(s)) {
        return initialTone;
      }
      final double answer = _findDesiredChromaByTone(
          s.secondaryPalette.hue,
          s.secondaryPalette.chroma,
          initialTone,
          // ignore: avoid_bool_literals_in_conditional_expressions
          s.isDark ? false : true);
      return _performAlbers(s.secondaryPalette.getHct(answer), s);
    },
  );

  /// onSecondaryContainer color.
  static DynamicColor onSecondaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.secondaryPalette,
    background: (DynamicScheme s) => secondaryContainer,
    tone: (DynamicScheme s) {
      if (!_isFidelity(s)) {
        return s.isDark ? 90 : 10;
      }
      return DynamicColor.foregroundTone(secondaryContainer.tone(s), 4.5);
    },
  );

  /// tertiary color.
  static DynamicColor tertiary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 90 : 25;
      }
      return s.isDark ? 80 : 40;
    },
    background: highestSurface,
    toneDeltaConstraint: (DynamicScheme s) => ToneDeltaConstraint(
      delta: contentAccentToneDelta,
      keepAway: tertiaryContainer,
      keepAwayPolarity: s.isDark ? TonePolarity.darker : TonePolarity.lighter,
    ),
  );

  /// onTertiary color.
  static DynamicColor onTertiary = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.tertiaryPalette,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 10 : 90;
      }
      return s.isDark ? 20 : 100;
    },
    background: (DynamicScheme s) => tertiary,
  );

  /// tertiaryContainer color.
  static DynamicColor tertiaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.tertiaryPalette,
    background: highestSurface,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 60 : 49;
      }
      if (!_isFidelity(s)) {
        return s.isDark ? 30 : 90;
      }

      final double albersTone =
          _performAlbers(s.tertiaryPalette.getHct(s.sourceColorHct.tone), s);
      final Hct proposedHct = s.tertiaryPalette.getHct(albersTone);
      return DislikeAnalyzer.fixIfDisliked(proposedHct).tone;
    },
  );

  /// onTertiaryContainer color.
  static DynamicColor onTertiaryContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.tertiaryPalette,
    background: (DynamicScheme s) => tertiaryContainer,
    tone: (DynamicScheme s) {
      if (_isMonochrome(s)) {
        return s.isDark ? 0 : 100;
      }
      if (!_isFidelity(s)) {
        return s.isDark ? 90 : 10;
      }
      return DynamicColor.foregroundTone(tertiaryContainer.tone(s), 4.5);
    },
  );

  /// error color.
  static DynamicColor error = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 80 : 40,
    background: highestSurface,
    toneDeltaConstraint: (DynamicScheme s) => ToneDeltaConstraint(
      delta: contentAccentToneDelta,
      keepAway: errorContainer,
      keepAwayPolarity: s.isDark ? TonePolarity.darker : TonePolarity.lighter,
    ),
  );

  /// onError color.
  static DynamicColor onError = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 20 : 100,
    background: (DynamicScheme s) => error,
  );

  /// errorContainer color.
  static DynamicColor errorContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 30 : 90,
    background: highestSurface,
  );

  /// onErrorContainer color.
  static DynamicColor onErrorContainer = DynamicColor.fromPalette(
    palette: (DynamicScheme s) => s.errorPalette,
    tone: (DynamicScheme s) => s.isDark ? 90 : 10,
    background: (DynamicScheme s) => errorContainer,
  );

  /// primaryFixed color.
  static DynamicColor primaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.primaryPalette,
      tone: (DynamicScheme s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 100.0 : 10.0;
        }
        return 90.0;
      },
      background: MaterialDynamicColors.highestSurface);

  /// primaryFixedDim color.
  static DynamicColor primaryFixedDim = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.primaryPalette,
      tone: (DynamicScheme s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 90.0 : 20.0;
        }
        return 80.0;
      },
      background: MaterialDynamicColors.highestSurface);

  /// onPrimaryFixed color.
  static DynamicColor onPrimaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.primaryPalette,
      tone: (DynamicScheme s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 10.0 : 90.0;
        }
        return 10.0;
      },
      background: (DynamicScheme s) => primaryFixedDim);

  /// onPrimaryFixedVariant color.
  static DynamicColor onPrimaryFixedVariant = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.primaryPalette,
      tone: (DynamicScheme s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 30.0 : 70.0;
        }
        return 30.0;
      },
      background: (DynamicScheme s) => primaryFixedDim);

  /// secondaryFixed color.
  static DynamicColor secondaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.secondaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 80.0 : 90.0,
      background: MaterialDynamicColors.highestSurface);

  /// secondaryFixedDim color.
  static DynamicColor secondaryFixedDim = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.secondaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 70.0 : 80.0,
      background: MaterialDynamicColors.highestSurface);

  /// onSecondaryFixed color.
  static DynamicColor onSecondaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.secondaryPalette,
      tone: (DynamicScheme s) => 10.0,
      background: (DynamicScheme s) => secondaryFixedDim);

  /// onSecondaryFixedVariant color.
  static DynamicColor onSecondaryFixedVariant = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.secondaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 25.0 : 30.0,
      background: (DynamicScheme s) => secondaryFixedDim);

  /// tertiaryFixed color.
  static DynamicColor tertiaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.tertiaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 40.0 : 90.0,
      background: MaterialDynamicColors.highestSurface);

  /// tertiaryFixedDim color.
  static DynamicColor tertiaryFixedDim = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.tertiaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 30.0 : 80.0,
      background: MaterialDynamicColors.highestSurface);

  /// onTertiaryFixed color.
  static DynamicColor onTertiaryFixed = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.tertiaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 90.0 : 10.0,
      background: (DynamicScheme s) => tertiaryFixedDim);

  /// onTertiaryFixedVariant color.
  static DynamicColor onTertiaryFixedVariant = DynamicColor.fromPalette(
      palette: (DynamicScheme s) => s.tertiaryPalette,
      tone: (DynamicScheme s) => _isMonochrome(s) ? 70.0 : 30.0,
      background: (DynamicScheme s) => tertiaryFixedDim);

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

  static double _performAlbers(Hct prealbers, DynamicScheme scheme) {
    final Hct albersd =
        prealbers.inViewingConditions(viewingConditionsForAlbers(scheme));
    if (DynamicColor.tonePrefersLightForeground(prealbers.tone) &&
        !DynamicColor.toneAllowsLightForeground(albersd.tone)) {
      return DynamicColor.enableLightForeground(prealbers.tone);
    } else {
      return DynamicColor.enableLightForeground(albersd.tone);
    }
  }
}
