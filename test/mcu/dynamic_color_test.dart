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
  'on_background': MaterialDynamicColors.onBackground,
  'surface': MaterialDynamicColors.surface,
  'surface_dim': MaterialDynamicColors.surfaceDim,
  'surface_bright': MaterialDynamicColors.surfaceBright,
  'surface_container_lowest': MaterialDynamicColors.surfaceContainerLowest,
  'surface_container_low': MaterialDynamicColors.surfaceContainerLow,
  'surface_container': MaterialDynamicColors.surfaceContainer,
  'surface_container_high': MaterialDynamicColors.surfaceContainerHigh,
  'surface_container_highest': MaterialDynamicColors.surfaceContainerHighest,
  'on_surface': MaterialDynamicColors.onSurface,
  'surface_variant': MaterialDynamicColors.surfaceVariant,
  'on_surface_variant': MaterialDynamicColors.onSurfaceVariant,
  'inverse_surface': MaterialDynamicColors.inverseSurface,
  'inverse_on_surface': MaterialDynamicColors.inverseOnSurface,
  'outline': MaterialDynamicColors.outline,
  'outline_variant': MaterialDynamicColors.outlineVariant,
  'shadow': MaterialDynamicColors.shadow,
  'scrim': MaterialDynamicColors.scrim,
  'surface_tint': MaterialDynamicColors.surfaceTint,
  'primary': MaterialDynamicColors.primary,
  'on_primary': MaterialDynamicColors.onPrimary,
  'primary_container': MaterialDynamicColors.primaryContainer,
  'on_primary_container': MaterialDynamicColors.onPrimaryContainer,
  'inverse_primary': MaterialDynamicColors.inversePrimary,
  'secondary': MaterialDynamicColors.secondary,
  'on_secondary': MaterialDynamicColors.onSecondary,
  'secondary_container': MaterialDynamicColors.secondaryContainer,
  'on_secondary_container': MaterialDynamicColors.onSecondaryContainer,
  'tertiary': MaterialDynamicColors.tertiary,
  'on_tertiary': MaterialDynamicColors.onTertiary,
  'tertiary_container': MaterialDynamicColors.tertiaryContainer,
  'on_tertiary_container': MaterialDynamicColors.onTertiaryContainer,
  'error': MaterialDynamicColors.error,
  'on_error': MaterialDynamicColors.onError,
  'error_container': MaterialDynamicColors.errorContainer,
  'on_error_container': MaterialDynamicColors.onErrorContainer,
};

final List<_Pair> _textSurfacePairs = <_Pair>[
  _Pair('on_primary', 'primary'),
  _Pair('on_primary_container', 'primary_container'),
  _Pair('on_secondary', 'secondary'),
  _Pair('on_secondary_container', 'secondary_container'),
  _Pair('on_tertiary', 'tertiary'),
  _Pair('on_tertiary_container', 'tertiary_container'),
  _Pair('on_error', 'error'),
  _Pair('on_error_container', 'error_container'),
  _Pair('on_background', 'background'),
  _Pair('on_surface_variant', 'surface_bright'),
  _Pair('on_surface_variant', 'surface_dim'),
  _Pair('inverse_on_surface', 'inverse_surface'),
];

void main() {
  test('Values are correct', () {
    expect(
      MaterialDynamicColors.onPrimaryContainer.getArgb(SchemeFidelity(
        sourceColorHct: Hct.fromInt(0xFFFF0000),
        isDark: false,
        contrastLevel: 0.5,
      )),
      equals(0xFFFFFFFF),
    );
    expect(
      MaterialDynamicColors.onSecondaryContainer.getArgb(SchemeContent(
        sourceColorHct: Hct.fromInt(0xFF0000FF),
        isDark: false,
        contrastLevel: 0.5,
      )),
      equals(0xFFFFFFFF),
    );
    expect(
      MaterialDynamicColors.onTertiaryContainer.getArgb(SchemeContent(
        sourceColorHct: Hct.fromInt(0xFFFFFF00),
        isDark: true,
        contrastLevel: -0.5,
      )),
      equals(0xff959b1a),
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
      equals(0xffff422f),
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
      MaterialDynamicColors.surfaceVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSurfaceVariant.getHct(scheme).tone,
      closeTo(80.0, 1.0),
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
      closeTo(40.0, 1.0),
    );
    expect(
      MaterialDynamicColors.primaryFixedDim.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixed.getHct(scheme).tone,
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixedVariant.getHct(scheme).tone,
      closeTo(90.0, 1.0),
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
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixedVariant.getHct(scheme).tone,
      closeTo(90.0, 1.0),
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
      MaterialDynamicColors.surfaceVariant.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onSurfaceVariant.getHct(scheme).tone,
      closeTo(30.0, 1.0),
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
      closeTo(40.0, 1.0),
    );
    expect(
      MaterialDynamicColors.primaryFixedDim.getHct(scheme).tone,
      closeTo(30.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixed.getHct(scheme).tone,
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onPrimaryFixedVariant.getHct(scheme).tone,
      closeTo(90.0, 1.0),
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
      closeTo(100.0, 1.0),
    );
    expect(
      MaterialDynamicColors.onTertiaryFixedVariant.getHct(scheme).tone,
      closeTo(90.0, 1.0),
    );
  });

  //
  // RydMike - Raw usage DynamicColor tests
  //
  group('DynamicColor Test', () {
    test('Raw  DynamicColor', () {
      final SchemeExpressive scheme = SchemeExpressive(
          sourceColorHct: Hct.fromInt(0xff0000ff),
          isDark: false,
          contrastLevel: -1.0);

      // TODO(rydmike): Figure out missing testcases for DynamicColor
      final DynamicColor dScheme = DynamicColor(
        name: 'name',
        palette: (DynamicScheme s) => TonalPalette.of(55, 55),
        tone: (DynamicScheme s) => s.isDark ? 6 : 87,
        isBackground: true,
        background: null,
        secondBackground: null,
        contrastCurve: null,
        toneDeltaPair: null,
      );

      expect(dScheme.getHct(scheme).toInt(), Hct.fromInt(4294955442).toInt());
      expect(dScheme.getArgb(scheme), Hct.fromInt(4294955442).toInt());
      expect(dScheme.getTone(scheme), 87);
    });
    // Rydmike: Extra tests.
    test('Raw  DynamicColor', () {
      expect(DynamicColor.enableLightForeground(10), 10);
      expect(DynamicColor.enableLightForeground(90), 90);
      expect(DynamicColor.enableLightForeground(58), 49);
    });
  });
}
