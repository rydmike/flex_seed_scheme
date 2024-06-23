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
// ignore_for_file: lines_longer_than_80_chars

import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('0 length input', () {
    final double hue = DynamicScheme.getRotatedHue(
        Hct.from(43, 16, 16), <double>[], <double>[]);
    expect(hue, closeTo(43, 1.0));
  });

  test('1 length input no rotation', () {
    final double hue = DynamicScheme.getRotatedHue(
        Hct.from(43, 16, 16), <double>[0], <double>[0]);
    expect(hue, closeTo(43, 1.0));
  });

  test('input length mismatch asserts', () {
    expect(() {
      DynamicScheme.getRotatedHue(
          Hct.from(43, 16, 16), <double>[0, 1], <double>[0]);
    }, throwsA(const TypeMatcher<AssertionError>()));
  });

  test('on boundary rotation correct', () {
    final double hue = DynamicScheme.getRotatedHue(
      Hct.from(43, 16, 16),
      <double>[0, 42, 360],
      <double>[0, 15, 0],
    );
    expect(hue, closeTo(43 + 15, 1.0));
  });

  test('rotation result larger than 360 degrees wraps', () {
    final double hue = DynamicScheme.getRotatedHue(
      Hct.from(43, 16, 16),
      <double>[0, 42, 360],
      <double>[0, 480, 0],
    );
    expect(hue, closeTo(163, 1.0));
  });

  // RydMike: More tests: Dynamic Scheme test via ColorScheme.
  test(
      'Color values in ColorScheme.fromSeed with different variants matches '
      'values in DynamicScheme', () {
    const Color seedColor = Colors.orange;
    final Hct sourceColor = Hct.fromInt(seedColor.value);
    final DynamicScheme dynamicScheme = SchemeTonalSpot(
        sourceColorHct: sourceColor, isDark: false, contrastLevel: 0.0);

    // Test getters for key colors
    expect(dynamicScheme.primaryPaletteKeyColor, 4288834351);
    expect(dynamicScheme.secondaryPaletteKeyColor, 4287459929);
    expect(dynamicScheme.tertiaryPaletteKeyColor, 4285627473);
    expect(dynamicScheme.neutralPaletteKeyColor, 4286608748);
    expect(dynamicScheme.neutralVariantPaletteKeyColor, 4286805096);

    final DynamicColor surfaceHighest =
        MaterialDynamicColors.highestSurface(dynamicScheme);
    expect(dynamicScheme.getHct(surfaceHighest).toInt(),
        surfaceHighest.getArgb(dynamicScheme));

    // TODO(rydmike): Add DynamicSchemeVariant test when Flutter uses MCU 0.12.0
    // for (final DynamicSchemeVariant schemeVariant in DynamicSchemeVariant.values) {
    //   final DynamicScheme dynamicScheme = switch (schemeVariant) {
    // DynamicSchemeVariant.tonalSpot => SchemeTonalSpot(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.fidelity => SchemeFidelity(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.content => SchemeContent(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.monochrome => SchemeMonochrome(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.neutral => SchemeNeutral(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.vibrant => SchemeVibrant(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.expressive => SchemeExpressive(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.rainbow => SchemeRainbow(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    // DynamicSchemeVariant.fruitSalad => SchemeFruitSalad(sourceColorHct: sourceColor, isDark: isDark, contrastLevel: contrastLevel),
    //   };

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      // dynamicSchemeVariant: schemeVariant,
    );

    expect(colorScheme.primary.value,
        MaterialDynamicColors.primary.getArgb(dynamicScheme));
    expect(colorScheme.onPrimary.value,
        MaterialDynamicColors.onPrimary.getArgb(dynamicScheme));
    expect(colorScheme.primaryContainer.value,
        MaterialDynamicColors.primaryContainer.getArgb(dynamicScheme));

    // TODO(rydmike): This test cannot pass until Flutter updates to MCU 0.12.0
    // expect(colorScheme.onPrimaryContainer.value,
    //     MaterialDynamicColors.onPrimaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Using hard coded value test until Flutter updates.
    expect(colorScheme.onPrimaryContainer.value, 4281079296);
    //
    expect(colorScheme.primaryFixed.value,
        MaterialDynamicColors.primaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.primaryFixedDim.value,
        MaterialDynamicColors.primaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onPrimaryFixed.value,
        MaterialDynamicColors.onPrimaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onPrimaryFixedVariant.value,
        MaterialDynamicColors.onPrimaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.secondary.value,
        MaterialDynamicColors.secondary.getArgb(dynamicScheme));
    expect(colorScheme.onSecondary.value,
        MaterialDynamicColors.onSecondary.getArgb(dynamicScheme));
    expect(colorScheme.secondaryContainer.value,
        MaterialDynamicColors.secondaryContainer.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryContainer.value,
        MaterialDynamicColors.onSecondaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onSecondaryContainer.value, 4280883206);
    // expect(4284039724,
    //     MaterialDynamicColors.onSecondaryContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.secondaryFixed.value,
        MaterialDynamicColors.secondaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.secondaryFixedDim.value,
        MaterialDynamicColors.secondaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryFixed.value,
        MaterialDynamicColors.onSecondaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryFixedVariant.value,
        MaterialDynamicColors.onSecondaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.tertiary.value,
        MaterialDynamicColors.tertiary.getArgb(dynamicScheme));
    expect(colorScheme.onTertiary.value,
        MaterialDynamicColors.onTertiary.getArgb(dynamicScheme));
    expect(colorScheme.tertiaryContainer.value,
        MaterialDynamicColors.tertiaryContainer.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryContainer.value,
        MaterialDynamicColors.onTertiaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onTertiaryContainer.value, 4279639553);
    // expect(4282469156,
    //     MaterialDynamicColors.onTertiaryContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.tertiaryFixed.value,
        MaterialDynamicColors.tertiaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.tertiaryFixedDim.value,
        MaterialDynamicColors.tertiaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryFixed.value,
        MaterialDynamicColors.onTertiaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryFixedVariant.value,
        MaterialDynamicColors.onTertiaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.error.value,
        MaterialDynamicColors.error.getArgb(dynamicScheme));
    expect(colorScheme.onError.value,
        MaterialDynamicColors.onError.getArgb(dynamicScheme));
    expect(colorScheme.errorContainer.value,
        MaterialDynamicColors.errorContainer.getArgb(dynamicScheme));
    expect(colorScheme.onErrorContainer.value,
        MaterialDynamicColors.onErrorContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onErrorContainer.value, 4282449922);
    // expect(4287823882,
    //     MaterialDynamicColors.onErrorContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.background.value,
        MaterialDynamicColors.background.getArgb(dynamicScheme));
    expect(colorScheme.onBackground.value,
        MaterialDynamicColors.onBackground.getArgb(dynamicScheme));
    expect(colorScheme.surface.value,
        MaterialDynamicColors.surface.getArgb(dynamicScheme));
    expect(colorScheme.surfaceDim.value,
        MaterialDynamicColors.surfaceDim.getArgb(dynamicScheme));
    expect(colorScheme.surfaceBright.value,
        MaterialDynamicColors.surfaceBright.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerLowest.value,
        MaterialDynamicColors.surfaceContainerLowest.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerLow.value,
        MaterialDynamicColors.surfaceContainerLow.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainer.value,
        MaterialDynamicColors.surfaceContainer.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerHigh.value,
        MaterialDynamicColors.surfaceContainerHigh.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerHighest.value,
        MaterialDynamicColors.surfaceContainerHighest.getArgb(dynamicScheme));
    expect(colorScheme.onSurface.value,
        MaterialDynamicColors.onSurface.getArgb(dynamicScheme));
    expect(colorScheme.surfaceVariant.value,
        MaterialDynamicColors.surfaceVariant.getArgb(dynamicScheme));
    expect(colorScheme.onSurfaceVariant.value,
        MaterialDynamicColors.onSurfaceVariant.getArgb(dynamicScheme));
    expect(colorScheme.outline.value,
        MaterialDynamicColors.outline.getArgb(dynamicScheme));
    expect(colorScheme.outlineVariant.value,
        MaterialDynamicColors.outlineVariant.getArgb(dynamicScheme));
    expect(colorScheme.shadow.value,
        MaterialDynamicColors.shadow.getArgb(dynamicScheme));
    expect(colorScheme.scrim.value,
        MaterialDynamicColors.scrim.getArgb(dynamicScheme));
    expect(colorScheme.inverseSurface.value,
        MaterialDynamicColors.inverseSurface.getArgb(dynamicScheme));
    expect(colorScheme.onInverseSurface.value,
        MaterialDynamicColors.inverseOnSurface.getArgb(dynamicScheme));
    expect(colorScheme.inversePrimary.value,
        MaterialDynamicColors.inversePrimary.getArgb(dynamicScheme));

    // Test the getter for the dynamic scheme.
    expect(colorScheme.primary.value, dynamicScheme.primary);
    expect(colorScheme.onPrimary.value, dynamicScheme.onPrimary);
    expect(colorScheme.primaryContainer.value, dynamicScheme.primaryContainer);
    expect(
        colorScheme.onPrimaryContainer.value, dynamicScheme.onPrimaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onPrimaryContainer.value, 4281079296);
    // expect(4285086720, dynamicScheme.onPrimaryContainer);
    //
    expect(colorScheme.primaryFixed.value, dynamicScheme.primaryFixed);
    expect(colorScheme.primaryFixedDim.value, dynamicScheme.primaryFixedDim);
    expect(colorScheme.onPrimaryFixed.value, dynamicScheme.onPrimaryFixed);
    expect(colorScheme.onPrimaryFixedVariant.value,
        dynamicScheme.onPrimaryFixedVariant);
    expect(colorScheme.secondary.value, dynamicScheme.secondary);
    expect(colorScheme.onSecondary.value, dynamicScheme.onSecondary);
    expect(
        colorScheme.secondaryContainer.value, dynamicScheme.secondaryContainer);
    expect(colorScheme.onSecondaryContainer.value,
        dynamicScheme.onSecondaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onSecondaryContainer.value, 4280883206);
    // expect(4284039724, dynamicScheme.onSecondaryContainer);
    //
    expect(colorScheme.secondaryFixed.value, dynamicScheme.secondaryFixed);
    expect(
        colorScheme.secondaryFixedDim.value, dynamicScheme.secondaryFixedDim);
    expect(colorScheme.onSecondaryFixed.value, dynamicScheme.onSecondaryFixed);
    expect(colorScheme.onSecondaryFixedVariant.value,
        dynamicScheme.onSecondaryFixedVariant);
    expect(colorScheme.tertiary.value, dynamicScheme.tertiary);
    expect(colorScheme.onTertiary.value, dynamicScheme.onTertiary);
    expect(
        colorScheme.tertiaryContainer.value, dynamicScheme.tertiaryContainer);
    expect(colorScheme.onTertiaryContainer.value,
        dynamicScheme.onTertiaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onTertiaryContainer.value, 4279639553);
    // expect(4282469156, dynamicScheme.onTertiaryContainer);
    //
    expect(colorScheme.tertiaryFixed.value, dynamicScheme.tertiaryFixed);
    expect(colorScheme.tertiaryFixedDim.value, dynamicScheme.tertiaryFixedDim);
    expect(colorScheme.onTertiaryFixed.value, dynamicScheme.onTertiaryFixed);
    expect(colorScheme.onTertiaryFixedVariant.value,
        dynamicScheme.onTertiaryFixedVariant);
    expect(colorScheme.error.value, dynamicScheme.error);
    expect(colorScheme.onError.value, dynamicScheme.onError);
    expect(colorScheme.errorContainer.value, dynamicScheme.errorContainer);
    expect(colorScheme.onErrorContainer.value, dynamicScheme.onErrorContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onErrorContainer.value, 4282449922);
    // expect(4287823882, dynamicScheme.onErrorContainer);
    //
    expect(colorScheme.background.value, dynamicScheme.background);
    expect(colorScheme.onBackground.value, dynamicScheme.onBackground);
    expect(colorScheme.surface.value, dynamicScheme.surface);
    expect(colorScheme.surfaceDim.value, dynamicScheme.surfaceDim);
    expect(colorScheme.surfaceBright.value, dynamicScheme.surfaceBright);
    expect(colorScheme.surfaceContainerLowest.value,
        dynamicScheme.surfaceContainerLowest);
    expect(colorScheme.surfaceContainerLow.value,
        dynamicScheme.surfaceContainerLow);
    expect(colorScheme.surfaceContainer.value, dynamicScheme.surfaceContainer);
    expect(colorScheme.surfaceContainerHigh.value,
        dynamicScheme.surfaceContainerHigh);
    expect(colorScheme.surfaceContainerHighest.value,
        dynamicScheme.surfaceContainerHighest);
    expect(colorScheme.onSurface.value, dynamicScheme.onSurface);
    expect(colorScheme.surfaceVariant.value, dynamicScheme.surfaceVariant);
    expect(colorScheme.onSurfaceVariant.value, dynamicScheme.onSurfaceVariant);
    expect(colorScheme.outline.value, dynamicScheme.outline);
    expect(colorScheme.outlineVariant.value, dynamicScheme.outlineVariant);
    expect(colorScheme.shadow.value, dynamicScheme.shadow);
    expect(colorScheme.scrim.value, dynamicScheme.scrim);
    expect(colorScheme.inverseSurface.value, dynamicScheme.inverseSurface);
    expect(colorScheme.onInverseSurface.value, dynamicScheme.inverseOnSurface);
    expect(colorScheme.inversePrimary.value, dynamicScheme.inversePrimary);
    expect(colorScheme.surfaceTint.value, dynamicScheme.surfaceTint);
  });
}
