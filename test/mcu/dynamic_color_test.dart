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

import 'package:flex_seed_scheme/src/mcu/dynamiccolor/src/tone_delta_constraint.dart';
import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';
import 'package:test/test.dart';

final List<Hct> seedColors = <Hct>[
  Hct.fromInt(0xFFFF0000),
  Hct.fromInt(0xFFFFFF00),
  Hct.fromInt(0xFF00FF00),
  Hct.fromInt(0xFF0000FF),
];

final List<double> contrastLevels = <double>[-1.0, -0.5, 0.0, 0.5, 1.0];

class _Pair {
  final String fgName;
  final String bgName;

  _Pair(this.fgName, this.bgName);
}

final Map<String, DynamicColor> _colors = <String, DynamicColor>{
  'background': MaterialDynamicColors.background,
  'onBackground': MaterialDynamicColors.onBackground,
  'surface': MaterialDynamicColors.surface,
  'surfaceDim': MaterialDynamicColors.surfaceDim,
  'surfaceBright': MaterialDynamicColors.surfaceBright,
  'surfaceContainerLowest': MaterialDynamicColors.surfaceContainerLowest,
  'surfaceContainerLow': MaterialDynamicColors.surfaceContainerLow,
  'surfaceContainer': MaterialDynamicColors.surfaceContainer,
  'surfaceContainerHigh': MaterialDynamicColors.surfaceContainerHigh,
  'surfaceContainerHighest': MaterialDynamicColors.surfaceContainerHighest,
  'onSurface': MaterialDynamicColors.onSurface,
  'surfaceVariant': MaterialDynamicColors.surfaceVariant,
  'onSurfaceVariant': MaterialDynamicColors.onSurfaceVariant,
  'inverseSurface': MaterialDynamicColors.inverseSurface,
  'inverseOnSurface': MaterialDynamicColors.inverseOnSurface,
  'outline': MaterialDynamicColors.outline,
  'outlineVariant': MaterialDynamicColors.outlineVariant,
  'shadow': MaterialDynamicColors.shadow,
  'scrim': MaterialDynamicColors.scrim,
  'surfaceTint': MaterialDynamicColors.surfaceTint,
  'primary': MaterialDynamicColors.primary,
  'onPrimary': MaterialDynamicColors.onPrimary,
  'primaryContainer': MaterialDynamicColors.primaryContainer,
  'onPrimaryContainer': MaterialDynamicColors.onPrimaryContainer,
  'inversePrimary': MaterialDynamicColors.inversePrimary,
  'secondary': MaterialDynamicColors.secondary,
  'onSecondary': MaterialDynamicColors.onSecondary,
  'secondaryContainer': MaterialDynamicColors.secondaryContainer,
  'onSecondaryContainer': MaterialDynamicColors.onSecondaryContainer,
  'tertiary': MaterialDynamicColors.tertiary,
  'onTertiary': MaterialDynamicColors.onTertiary,
  'tertiaryContainer': MaterialDynamicColors.tertiaryContainer,
  'onTertiaryContainer': MaterialDynamicColors.onTertiaryContainer,
  'error': MaterialDynamicColors.error,
  'onError': MaterialDynamicColors.onError,
  'errorContainer': MaterialDynamicColors.errorContainer,
  'onErrorContainer': MaterialDynamicColors.onErrorContainer,
};

final List<_Pair> _textSurfacePairs = <_Pair>[
  _Pair('onPrimary', 'primary'),
  _Pair('onPrimaryContainer', 'primaryContainer'),
  _Pair('onSecondary', 'secondary'),
  _Pair('onSecondaryContainer', 'secondaryContainer'),
  _Pair('onTertiary', 'tertiary'),
  _Pair('onTertiaryContainer', 'tertiaryContainer'),
  _Pair('onError', 'error'),
  _Pair('onErrorContainer', 'errorContainer'),
  _Pair('onBackground', 'background'),
  _Pair('onSurfaceVariant', 'surfaceVariant'),
  _Pair('inverseOnSurface', 'inverseSurface'),
];

void main() {
  test('Values are correct', () {
    expect(
      MaterialDynamicColors.onPrimaryContainer.getArgb(SchemeFidelity(
        sourceColorHct: Hct.fromInt(0xFFFF0000),
        isDark: false,
        contrastLevel: 0.5,
      )),
      equals(0xFFFFE5E1),
    );
    expect(
      MaterialDynamicColors.onSecondaryContainer.getArgb(SchemeContent(
        sourceColorHct: Hct.fromInt(0xFF0000FF),
        isDark: false,
        contrastLevel: 0.5,
      )),
      equals(0xFFFFFCFF),
    );
    expect(
      MaterialDynamicColors.onTertiaryContainer.getArgb(SchemeContent(
        sourceColorHct: Hct.fromInt(0xFFFFFF00),
        isDark: true,
        contrastLevel: -0.5,
      )),
      equals(0xFF616600),
    );
    expect(
      MaterialDynamicColors.inverseSurface.getArgb(SchemeContent(
          sourceColorHct: Hct.fromInt(0xFF0000FF),
          isDark: false,
          contrastLevel: 0.0)),
      equals(0xFF2F2F3B),
    );
    expect(
      MaterialDynamicColors.inversePrimary.getArgb(SchemeContent(
          sourceColorHct: Hct.fromInt(0xFFFF0000),
          isDark: false,
          contrastLevel: -0.5)),
      equals(0xFFFF907F),
    );
    expect(
      MaterialDynamicColors.outlineVariant.getArgb(SchemeContent(
          sourceColorHct: Hct.fromInt(0xFFFFFF00),
          isDark: true,
          contrastLevel: 0.0)),
      equals(0xFF484831),
    );
  });

  // Parametric test, ensuring that dynamic schemes respect contrast
  // between text-surface pairs.

  for (final Hct color in seedColors) {
    for (final double contrastLevel in contrastLevels) {
      for (final bool isDark in <bool>[false, true]) {
        for (final DynamicScheme scheme in <DynamicScheme>[
          SchemeContent(
              sourceColorHct: color,
              isDark: isDark,
              contrastLevel: contrastLevel),
          SchemeMonochrome(
              sourceColorHct: color,
              isDark: isDark,
              contrastLevel: contrastLevel),
          SchemeTonalSpot(
              sourceColorHct: color,
              isDark: isDark,
              contrastLevel: contrastLevel),
          SchemeFidelity(
              sourceColorHct: color,
              isDark: isDark,
              contrastLevel: contrastLevel),
        ]) {
          test(
              'Scheme: $scheme; Seed color: $color; '
              'Contrast level: $contrastLevel; Dark: $isDark', () {
            for (final _Pair pair in _textSurfacePairs) {
              // Expect that each text-surface pair has a
              // minimum contrast of 4.5 (unreduced contrast), or 3.0
              // (reduced contrast).
              final String fgName = pair.fgName;
              final String bgName = pair.bgName;
              final double foregroundTone =
                  _colors[fgName]!.getHct(scheme).tone;
              final double backgroundTone =
                  _colors[bgName]!.getHct(scheme).tone;
              final double contrast =
                  Contrast.ratioOfTones(foregroundTone, backgroundTone);

              final double minimumRequirement =
                  contrastLevel >= 0.0 ? 4.5 : 3.0;

              expect(
                contrast,
                greaterThanOrEqualTo(minimumRequirement),
                reason: 'Contrast $contrast is too low between '
                    'foreground ($fgName; $foregroundTone) and '
                    'background ($bgName; $backgroundTone)',
              );
            }
          });
        }
      }
    }
  }

  // Tests for fixed colors.
  test('fixed colors in non-monochrome schemes', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
      sourceColorHct: Hct.fromInt(0xFFFF0000),
      isDark: true,
      contrastLevel: 0.0,
    );

    expect(
      MaterialDynamicColors.primaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.primaryFixedDim.getHct(scheme).tone,
      closeTo(80.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixedVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixedDim.getHct(scheme).tone,
      closeTo(80.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixedVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixedDim.getHct(scheme).tone,
      closeTo(80.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixedVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    //
    // Rydmike extra coverage tests
    //
    expect(
      MaterialDynamicColors.surfaceDim.getHct(scheme).tone,
      closeTo(6.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceBright.getHct(scheme).tone,
      closeTo(24.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerLowest.getHct(scheme).tone,
      closeTo(4.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerLow.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainer.getHct(scheme).tone,
      closeTo(12.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerHigh.getHct(scheme).tone,
      closeTo(17.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerHighest.getHct(scheme).tone,
      closeTo(22.0, 1.0),
    );
    expect(
      MaterialDynamicColors.outline.getHct(scheme).tone,
      closeTo(60.0, 2.0),
    );
  });

  test('fixed colors in light monochrome schemes', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
      sourceColorHct: Hct.fromInt(0xFFFF0000),
      isDark: false,
      contrastLevel: 0.0,
    );

    expect(
      MaterialDynamicColors.primaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.primaryFixedDim.getHct(scheme).tone,
      closeTo(20.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixedVariant.getHct(scheme).tone,
      closeTo(70.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixed.getHct(scheme).tone,
      closeTo(80.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixedDim.getHct(scheme).tone,
      closeTo(70.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixedVariant.getHct(scheme).tone,
      closeTo(25.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixed.getHct(scheme).tone,
      closeTo(40.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixedDim.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixedVariant.getHct(scheme).tone,
      closeTo(70.0, 1.0),
    );
    //
    // Rydmike extra coverage tests
    //
    expect(
      MaterialDynamicColors.surfaceDim.getHct(scheme).tone,
      closeTo(87.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceBright.getHct(scheme).tone,
      closeTo(98.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerLowest.getHct(scheme).tone,
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerLow.getHct(scheme).tone,
      closeTo(96.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainer.getHct(scheme).tone,
      closeTo(94.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerHigh.getHct(scheme).tone,
      closeTo(92.0, 1.0),
    );
    expect(
      MaterialDynamicColors.surfaceContainerHighest.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.outline.getHct(scheme).tone,
      closeTo(50.0, 2.0),
    );
  });

  test('fixed colors in dark monochrome schemes', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
      sourceColorHct: Hct.fromInt(0xFFFF0000),
      isDark: true,
      contrastLevel: 0.0,
    );

    expect(
      MaterialDynamicColors.primaryFixed.getHct(scheme).tone,
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.primaryFixedDim.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixedVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixed.getHct(scheme).tone,
      closeTo(80.0, 1.0),
    );
    expect(
      MaterialDynamicColors.secondaryFixedDim.getHct(scheme).tone,
      closeTo(70.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixed.getHct(scheme).tone,
      closeTo(10.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSecondaryFixedVariant.getHct(scheme).tone,
      closeTo(25.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixed.getHct(scheme).tone,
      closeTo(40.0, 1.0),
    );
    expect(
      MaterialDynamicColors.tertiaryFixedDim.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixed.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixedVariant.getHct(scheme).tone,
      closeTo(70.0, 1.0),
    );
  });
  //
  // RydMike - Raw usage DynamicColor statics
  //
  group('DynamicColor Test', () {
    test('fixed toneMinContrastDefault', () {
      final SchemeExpressive scheme = SchemeExpressive(
          sourceColorHct: Hct.fromInt(0xff0000ff),
          isDark: false,
          contrastLevel: -1.0);
      final double contrast = DynamicColor.toneMinContrastDefault(
          (DynamicScheme p0) => 5,
          (DynamicScheme p0) => MaterialDynamicColors.background,
          scheme,
          (DynamicScheme p0) => ToneDeltaConstraint(
              delta: 50,
              keepAway: MaterialDynamicColors.secondaryContainer,
              keepAwayPolarity: TonePolarity.noPreference));
      expect(contrast, equals(40.0));
    });
    test('fixed censureToneDelta', () {
      final SchemeExpressive scheme = SchemeExpressive(
          sourceColorHct: Hct.fromInt(0xff0000ff),
          isDark: false,
          contrastLevel: -1.0);
      final double delta = DynamicColor.ensureToneDelta(
        tone: 30,
        toneStandard: 20,
        scheme: scheme,
        constraintProvider: (DynamicScheme p0) => ToneDeltaConstraint(
            delta: 30,
            keepAway: MaterialDynamicColors.surfaceVariant,
            keepAwayPolarity: TonePolarity.noPreference),
        toneToDistanceFrom: (DynamicColor c0) => 10,
      );
      expect(delta, equals(20.0));
    });
  });
}
