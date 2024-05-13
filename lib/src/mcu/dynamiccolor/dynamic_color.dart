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

import '../contrast/contrast.dart';
import '../dynamiccolor/dynamic_scheme.dart';
import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../utils/math_utils.dart';
import 'src/contrast_curve.dart';
import 'src/tone_delta_pair.dart';

/// A color that adjusts itself based on UI state provided by [DynamicScheme].
///
/// This color automatically adjusts to accommodate a desired contrast level, or
/// other adjustments such as differing in light mode versus dark mode, or what
/// the theme is, or what the color that produced the theme is, etc.
///
/// Colors without backgrounds do not change tone when contrast changes. Colors
/// with backgrounds become closer to their background as contrast lowers, and
/// further when contrast increases.
///
/// Prefer the static constructors. They provide a much more simple interface,
/// such as requiring just a hexcode, or just a hexcode and a background.
///
/// Ultimately, each component necessary for calculating a color, adjusting it
/// for a desired contrast level, and ensuring it has a certain lightness/tone
/// difference from another color, is provided by a function that takes a
/// [DynamicScheme] and returns a value. This ensures ultimate flexibility, any
/// desired behavior of a color for any design system, but it usually
/// unnecessary. See the default constructor for more information.
class DynamicColor {
  /// [name] The name of the dynamic color.
  final String name;

  /// [palette] Function that provides a TonalPalette given
  /// DynamicScheme. A TonalPalette is defined by a hue and chroma, so this
  /// replaces the need to specify hue/chroma. By providing a tonal palette,
  /// when contrast adjustments are made, intended chroma can be preserved.
  final TonalPalette Function(DynamicScheme) palette;

  /// [tone] Function that provides a tone, given a DynamicScheme.
  final double Function(DynamicScheme) tone;

  /// [isBackground] Whether this dynamic color is a background, with
  /// some other color as the foreground.
  final bool isBackground;

  /// [background] The background of the dynamic color (as a function of a
  /// `DynamicScheme`), if it exists.
  final DynamicColor Function(DynamicScheme)? background;

  /// [secondBackground] A second background of the dynamic color (as a function
  /// of a `DynamicScheme`), if it
  /// exists.
  final DynamicColor Function(DynamicScheme)? secondBackground;

  /// [contrastCurve] A [ContrastCurve] object specifying how its contrast
  /// against its background should behave in various contrast levels options.
  final ContrastCurve? contrastCurve;

  /// [toneDeltaPair] A [ToneDeltaPair] object specifying a tone delta
  /// constraint between two colors. One of them must be the color being
  /// constructed.
  final ToneDeltaPair Function(DynamicScheme)? toneDeltaPair;

  final Map<DynamicScheme, Hct> _hctCache = <DynamicScheme, Hct>{};

  /// The base (explicit) constructor for [DynamicColor].
  ///
  /// [name] The name of the dynamic color.
  /// [palette] Function that provides a TonalPalette given
  /// DynamicScheme. A TonalPalette is defined by a hue and chroma, so this
  /// replaces the need to specify hue/chroma. By providing a tonal palette,
  /// when contrast adjustments are made, intended chroma can be preserved.
  /// [tone] Function that provides a tone, given a DynamicScheme.
  /// [isBackground] Whether this dynamic color is a background, with
  /// some other color as the foreground.
  /// [background] The background of the dynamic color (as a function of a
  /// `DynamicScheme`), if it exists.
  /// [secondBackground] A second background of the dynamic color (as a function
  /// of a `DynamicScheme`), if it
  /// exists.
  /// [contrastCurve] A [ContrastCurve] object specifying how its contrast
  /// against its background should behave in various contrast levels options.
  /// [toneDeltaPair] A [ToneDeltaPair] object specifying a tone delta
  /// constraint between two colors. One of them must be the color being
  /// constructed.
  DynamicColor({
    required this.name,
    required this.palette,
    required this.tone,
    required this.isBackground,
    required this.background,
    required this.secondBackground,
    required this.contrastCurve,
    required this.toneDeltaPair,
  });

  /// The convenience constructor for [DynamicColor].
  ///
  /// Similar to the base constructor, but all parameters other than [palette]
  /// and [tone] have defaults.
  ///
  /// [name] The name of the dynamic color. Defaults to empty.
  /// [palette] Function that provides a TonalPalette given
  /// DynamicScheme. A TonalPalette is defined by a hue and chroma, so this
  /// replaces the need to specify hue/chroma. By providing a tonal palette,
  /// when contrast adjustments are made, intended chroma can be preserved.
  /// [tone] Function that provides a tone, given a DynamicScheme.
  /// [isBackground] Whether this dynamic color is a background, with
  /// some other color as the foreground. Defaults to false.
  /// [background] The background of the dynamic color (as a function of a
  /// `DynamicScheme`), if it exists.
  /// [secondBackground] A second background of the dynamic color (as a function
  /// of a `DynamicScheme`), if it exists.
  /// [contrastCurve] A [ContrastCurve] object specifying how its contrast
  /// against its background should behave in various contrast levels options.
  /// [toneDeltaPair] A [ToneDeltaPair] object specifying a tone delta
  /// constraint between two colors. One of them must be the color being
  /// constructed.
  factory DynamicColor.fromPalette({
    String name = '',
    required TonalPalette Function(DynamicScheme) palette,
    required double Function(DynamicScheme) tone,
    bool isBackground = false,
    DynamicColor Function(DynamicScheme)? background,
    DynamicColor Function(DynamicScheme)? secondBackground,
    ContrastCurve? contrastCurve,
    ToneDeltaPair Function(DynamicScheme)? toneDeltaPair,
  }) {
    return DynamicColor(
      name: name,
      palette: palette,
      tone: tone,
      isBackground: isBackground,
      background: background,
      secondBackground: secondBackground,
      contrastCurve: contrastCurve,
      toneDeltaPair: toneDeltaPair,
    );
  }

  /// Return a ARGB integer (i.e. a hex code).

  /// [scheme] Defines the conditions of the user interface, for example,
  /// whether or not it is dark mode or light mode, and what the desired
  /// contrast level is.
  int getArgb(DynamicScheme scheme) {
    return getHct(scheme).toInt();
  }

  /// Return a color, expressed in the HCT color space, that this
  /// [DynamicColor] is under the conditions in [scheme].
  ///
  /// [scheme] Defines the conditions of the user interface, for example,
  /// whether or not it is dark mode or light mode, and what the desired
  /// contrast level is.
  Hct getHct(DynamicScheme scheme) {
    final Hct? cachedAnswer = _hctCache[scheme];
    if (cachedAnswer != null) {
      return cachedAnswer;
    }
    final double tone = getTone(scheme);
    final Hct answer = palette(scheme).getHct(tone);
    if (_hctCache.length > 4) {
      _hctCache.clear();
    }
    _hctCache[scheme] = answer;
    return answer;
  }

  /// Return a tone, T in the HCT color space, that this [DynamicColor] is under
  /// the conditions in [scheme].
  ///
  /// [scheme] Defines the conditions of the user interface, for example,
  /// whether or not it is dark mode or light mode, and what the desired
  /// contrast level is.
  double getTone(DynamicScheme scheme) {
    final bool decreasingContrast = scheme.contrastLevel < 0;

    // Case 1: dual foreground, pair of colors with delta constraint.
    if (toneDeltaPair != null) {
      final ToneDeltaPair pair = toneDeltaPair!(scheme);
      final DynamicColor roleA = pair.roleA;
      final DynamicColor roleB = pair.roleB;
      final double delta = pair.delta;
      final TonePolarity polarity = pair.polarity;
      final bool stayTogether = pair.stayTogether;

      final DynamicColor bg = background!(scheme);
      final double bgTone = bg.getTone(scheme);

      final bool aIsNearer = polarity == TonePolarity.nearer ||
          (polarity == TonePolarity.lighter && !scheme.isDark) ||
          (polarity == TonePolarity.darker && scheme.isDark);
      final DynamicColor nearer = aIsNearer ? roleA : roleB;
      final DynamicColor farther = aIsNearer ? roleB : roleA;
      final bool amNearer = name == nearer.name;
      final int expansionDir = scheme.isDark ? 1 : -1;

      // 1st round: solve to min, each
      final double nContrast = nearer.contrastCurve!.get(scheme.contrastLevel);
      final double fContrast = farther.contrastCurve!.get(scheme.contrastLevel);

      // If a color is good enough, it is not adjusted.
      // Initial and adjusted tones for `nearer`
      final double nInitialTone = nearer.tone(scheme);
      double nTone = Contrast.ratioOfTones(bgTone, nInitialTone) >= nContrast
          ? nInitialTone
          : DynamicColor.foregroundTone(bgTone, nContrast);
      // Initial and adjusted tones for `farther`
      final double fInitialTone = farther.tone(scheme);
      double fTone = Contrast.ratioOfTones(bgTone, fInitialTone) >= fContrast
          ? fInitialTone
          : DynamicColor.foregroundTone(bgTone, fContrast);

      if (decreasingContrast) {
        // If decreasing contrast, adjust color to the "bare minimum"
        // that satisfies contrast.
        nTone = DynamicColor.foregroundTone(bgTone, nContrast);
        fTone = DynamicColor.foregroundTone(bgTone, fContrast);
      }

      if ((fTone - nTone) * expansionDir >= delta) {
        // Good! Tones satisfy the constraint; no change needed.
      } else {
        // 2nd round: expand farther to match delta.
        fTone = MathUtils.clampDouble(0, 100, nTone + delta * expansionDir);
        if ((fTone - nTone) * expansionDir >= delta) {
          // Good! Tones now satisfy the constraint; no change needed.
        } else {
          // 3rd round: contract nearer to match delta.
          nTone = MathUtils.clampDouble(0, 100, fTone - delta * expansionDir);
        }
      }

      // Avoids the 50-59 awkward zone.
      if (50 <= nTone && nTone < 60) {
        // If `nearer` is in the awkward zone, move it away, together with
        // `farther`.
        if (expansionDir > 0) {
          nTone = 60;
          fTone = math.max(fTone, nTone + delta * expansionDir);
        } else {
          nTone = 49;
          fTone = math.min(fTone, nTone + delta * expansionDir);
        }
      } else if (50 <= fTone && fTone < 60) {
        if (stayTogether) {
          // Rydmike: If MCU devs do not hit test this, I'm not going to either.
          // coverage:ignore-start
          // Fixes both, to avoid two colors on opposite sides of the "awkward
          // zone".
          if (expansionDir > 0) {
            nTone = 60;
            fTone = math.max(fTone, nTone + delta * expansionDir);
          } else {
            nTone = 49;
            fTone = math.min(fTone, nTone + delta * expansionDir);
          }
          // coverage:ignore-end
        } else {
          // Not required to stay together; fixes just one.
          if (expansionDir > 0) {
            fTone = 60;
          } else {
            fTone = 49;
          }
        }
      }

      // Returns `nTone` if this color is `nearer`, otherwise `fTone`.
      return amNearer ? nTone : fTone;
    } else {
      // Case 2: No contrast pair; just solve for itself.
      double answer = tone(scheme);

      if (background == null) {
        return answer; // No adjustment for colors with no background.
      }

      final double bgTone = background!(scheme).getTone(scheme);

      final double desiredRatio = contrastCurve!.get(scheme.contrastLevel);

      if (Contrast.ratioOfTones(bgTone, answer) >= desiredRatio) {
        // Don't "improve" what's good enough.
      } else {
        // Rough improvement.
        answer = DynamicColor.foregroundTone(bgTone, desiredRatio);
      }

      if (decreasingContrast) {
        answer = DynamicColor.foregroundTone(bgTone, desiredRatio);
      }

      if (isBackground && 50 <= answer && answer < 60) {
        // Rydmike: If MCU devs do not hit test this, I'm not going to either.
        // coverage:ignore-start
        // Must adjust
        if (Contrast.ratioOfTones(49, bgTone) >= desiredRatio) {
          answer = 49;
        } else {
          answer = 60;
        }
        // coverage:ignore-end
      }

      if (secondBackground != null) {
        // Case 3: Adjust for dual backgrounds.

        final double bgTone1 = background!(scheme).getTone(scheme);
        final double bgTone2 = secondBackground!(scheme).getTone(scheme);

        final double upper = math.max(bgTone1, bgTone2);
        final double lower = math.min(bgTone1, bgTone2);

        if (Contrast.ratioOfTones(upper, answer) >= desiredRatio &&
            Contrast.ratioOfTones(lower, answer) >= desiredRatio) {
          return answer;
        }

        // The darkest light tone that satisfies the desired ratio,
        // or -1 if such ratio cannot be reached.
        final double lightOption =
            Contrast.lighter(tone: upper, ratio: desiredRatio);

        // The lightest dark tone that satisfies the desired ratio,
        // or -1 if such ratio cannot be reached.
        final double darkOption =
            Contrast.darker(tone: lower, ratio: desiredRatio);

        // Tones suitable for the foreground.
        final List<double> availables = <double>[];
        if (lightOption != -1) availables.add(lightOption);
        if (darkOption != -1) availables.add(darkOption);
        // Rydmike: If MCU devs do not hit test this, I'm not going to either.
        // coverage:ignore-start
        final bool prefersLight =
            DynamicColor.tonePrefersLightForeground(bgTone1) ||
                DynamicColor.tonePrefersLightForeground(bgTone2);
        if (prefersLight) {
          return (lightOption < 0) ? 100 : lightOption;
        }
        if (availables.length == 1) {
          return availables[0];
        }
        return (darkOption < 0) ? 0 : darkOption;
        // coverage:ignore-end
      }

      return answer;
    }
  }

  /// Given a background tone, find a foreground tone, while ensuring they reach
  /// a contrast ratio that is as close to [ratio] as possible.
  ///
  /// [bgTone] Tone in HCT. Range is 0 to 100, undefined behavior when it falls
  /// outside that range.
  /// [ratio] The contrast ratio desired between [bgTone] and the return value.
  static double foregroundTone(double bgTone, double ratio) {
    final double lighterTone =
        Contrast.lighterUnsafe(tone: bgTone, ratio: ratio);
    final double darkerTone = Contrast.darkerUnsafe(tone: bgTone, ratio: ratio);
    final double lighterRatio = Contrast.ratioOfTones(lighterTone, bgTone);
    final double darkerRatio = Contrast.ratioOfTones(darkerTone, bgTone);
    final bool preferLighter = tonePrefersLightForeground(bgTone);

    if (preferLighter) {
      // This handles an edge case where the initial contrast ratio is high
      // (ex. 13.0), and the ratio passed to the function is that high ratio,
      // and both the lighter and darker ratio fails to pass that ratio.
      //
      // This was observed with Tonal Spot's On Primary Container turning black
      // momentarily between high and max contrast in light mode.
      // PC's standard tone was T90, OPC's was T10, it was light mode, and the
      // contrast value was 0.6568521221032331.
      final bool negligibleDifference =
          (lighterRatio - darkerRatio).abs() < 0.1 &&
              lighterRatio < ratio &&
              darkerRatio < ratio; // coverage:ignore-line
      return lighterRatio >= ratio ||
              lighterRatio >= darkerRatio ||
              negligibleDifference
          ? lighterTone
          : darkerTone;
    } else {
      return darkerRatio >= ratio || darkerRatio >= lighterRatio
          ? darkerTone
          : lighterTone;
    }
  }

  /// Adjust a tone such that white has 4.5 contrast, if the tone is
  /// reasonably close to supporting it.
  static double enableLightForeground(double tone) {
    if (tonePrefersLightForeground(tone) && !toneAllowsLightForeground(tone)) {
      return 49.0;
    }
    return tone;
  }

  /// Returns whether [tone] prefers a light foreground.
  ///
  /// People prefer white foregrounds on ~T60-70. Observed over time, and also
  /// by Andrew Somers during research for APCA.
  ///
  /// T60 used as to create the smallest discontinuity possible when skipping
  /// down to T49 in order to ensure light foregrounds.
  ///
  /// Since `tertiaryContainer` in dark monochrome scheme requires a tone of
  /// 60, it should not be adjusted. Therefore, 60 is excluded here.
  static bool tonePrefersLightForeground(double tone) {
    return tone.round() < 60;
  }

  /// Returns whether [tone] can reach a contrast ratio of 4.5 with a lighter
  /// color.
  static bool toneAllowsLightForeground(double tone) {
    return tone.round() <= 49;
  }
}
