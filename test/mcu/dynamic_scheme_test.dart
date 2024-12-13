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

import 'package:flex_seed_scheme/src/flex/flex_color_seed_color_extensions.dart';
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
    final Hct sourceColor = Hct.fromInt(seedColor.value32bit);
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

    expect(colorScheme.primary.value32bit,
        MaterialDynamicColors.primary.getArgb(dynamicScheme));
    expect(colorScheme.onPrimary.value32bit,
        MaterialDynamicColors.onPrimary.getArgb(dynamicScheme));
    expect(colorScheme.primaryContainer.value32bit,
        MaterialDynamicColors.primaryContainer.getArgb(dynamicScheme));

    // TODO(rydmike): This test cannot pass until Flutter updates to MCU 0.12.0
    // expect(colorScheme.onPrimaryContainer.value32bit,
    //     MaterialDynamicColors.onPrimaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Using hard coded value test until Flutter updates.
    expect(colorScheme.onPrimaryContainer.value32bit, 4281079296);
    //
    expect(colorScheme.primaryFixed.value32bit,
        MaterialDynamicColors.primaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.primaryFixedDim.value32bit,
        MaterialDynamicColors.primaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onPrimaryFixed.value32bit,
        MaterialDynamicColors.onPrimaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onPrimaryFixedVariant.value32bit,
        MaterialDynamicColors.onPrimaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.secondary.value32bit,
        MaterialDynamicColors.secondary.getArgb(dynamicScheme));
    expect(colorScheme.onSecondary.value32bit,
        MaterialDynamicColors.onSecondary.getArgb(dynamicScheme));
    expect(colorScheme.secondaryContainer.value32bit,
        MaterialDynamicColors.secondaryContainer.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryContainer.value32bit,
        MaterialDynamicColors.onSecondaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onSecondaryContainer.value32bit, 4280883206);
    // expect(4284039724,
    //     MaterialDynamicColors.onSecondaryContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.secondaryFixed.value32bit,
        MaterialDynamicColors.secondaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.secondaryFixedDim.value32bit,
        MaterialDynamicColors.secondaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryFixed.value32bit,
        MaterialDynamicColors.onSecondaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onSecondaryFixedVariant.value32bit,
        MaterialDynamicColors.onSecondaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.tertiary.value32bit,
        MaterialDynamicColors.tertiary.getArgb(dynamicScheme));
    expect(colorScheme.onTertiary.value32bit,
        MaterialDynamicColors.onTertiary.getArgb(dynamicScheme));
    expect(colorScheme.tertiaryContainer.value32bit,
        MaterialDynamicColors.tertiaryContainer.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryContainer.value32bit,
        MaterialDynamicColors.onTertiaryContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onTertiaryContainer.value32bit, 4279639553);
    // expect(4282469156,
    //     MaterialDynamicColors.onTertiaryContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.tertiaryFixed.value32bit,
        MaterialDynamicColors.tertiaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.tertiaryFixedDim.value32bit,
        MaterialDynamicColors.tertiaryFixedDim.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryFixed.value32bit,
        MaterialDynamicColors.onTertiaryFixed.getArgb(dynamicScheme));
    expect(colorScheme.onTertiaryFixedVariant.value32bit,
        MaterialDynamicColors.onTertiaryFixedVariant.getArgb(dynamicScheme));
    expect(colorScheme.error.value32bit,
        MaterialDynamicColors.error.getArgb(dynamicScheme));
    expect(colorScheme.onError.value32bit,
        MaterialDynamicColors.onError.getArgb(dynamicScheme));
    expect(colorScheme.errorContainer.value32bit,
        MaterialDynamicColors.errorContainer.getArgb(dynamicScheme));
    expect(colorScheme.onErrorContainer.value32bit,
        MaterialDynamicColors.onErrorContainer.getArgb(dynamicScheme));
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onErrorContainer.value32bit, 4282449922);
    // expect(4287823882,
    //     MaterialDynamicColors.onErrorContainer.getArgb(dynamicScheme));
    //
    expect(colorScheme.background.value32bit,
        MaterialDynamicColors.background.getArgb(dynamicScheme));
    expect(colorScheme.onBackground.value32bit,
        MaterialDynamicColors.onBackground.getArgb(dynamicScheme));
    expect(colorScheme.surface.value32bit,
        MaterialDynamicColors.surface.getArgb(dynamicScheme));
    expect(colorScheme.surfaceDim.value32bit,
        MaterialDynamicColors.surfaceDim.getArgb(dynamicScheme));
    expect(colorScheme.surfaceBright.value32bit,
        MaterialDynamicColors.surfaceBright.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerLowest.value32bit,
        MaterialDynamicColors.surfaceContainerLowest.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerLow.value32bit,
        MaterialDynamicColors.surfaceContainerLow.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainer.value32bit,
        MaterialDynamicColors.surfaceContainer.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerHigh.value32bit,
        MaterialDynamicColors.surfaceContainerHigh.getArgb(dynamicScheme));
    expect(colorScheme.surfaceContainerHighest.value32bit,
        MaterialDynamicColors.surfaceContainerHighest.getArgb(dynamicScheme));
    expect(colorScheme.onSurface.value32bit,
        MaterialDynamicColors.onSurface.getArgb(dynamicScheme));
    expect(colorScheme.surfaceVariant.value32bit,
        MaterialDynamicColors.surfaceVariant.getArgb(dynamicScheme));
    expect(colorScheme.onSurfaceVariant.value32bit,
        MaterialDynamicColors.onSurfaceVariant.getArgb(dynamicScheme));
    expect(colorScheme.outline.value32bit,
        MaterialDynamicColors.outline.getArgb(dynamicScheme));
    expect(colorScheme.outlineVariant.value32bit,
        MaterialDynamicColors.outlineVariant.getArgb(dynamicScheme));
    expect(colorScheme.shadow.value32bit,
        MaterialDynamicColors.shadow.getArgb(dynamicScheme));
    expect(colorScheme.scrim.value32bit,
        MaterialDynamicColors.scrim.getArgb(dynamicScheme));
    expect(colorScheme.inverseSurface.value32bit,
        MaterialDynamicColors.inverseSurface.getArgb(dynamicScheme));
    expect(colorScheme.onInverseSurface.value32bit,
        MaterialDynamicColors.inverseOnSurface.getArgb(dynamicScheme));
    expect(colorScheme.inversePrimary.value32bit,
        MaterialDynamicColors.inversePrimary.getArgb(dynamicScheme));

    // Test the getter for the dynamic scheme.
    expect(colorScheme.primary.value32bit, dynamicScheme.primary);
    expect(colorScheme.onPrimary.value32bit, dynamicScheme.onPrimary);
    expect(colorScheme.primaryContainer.value32bit,
        dynamicScheme.primaryContainer);
    expect(colorScheme.onPrimaryContainer.value32bit,
        dynamicScheme.onPrimaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onPrimaryContainer.value32bit, 4281079296);
    // expect(4285086720, dynamicScheme.onPrimaryContainer);
    //
    expect(colorScheme.primaryFixed.value32bit, dynamicScheme.primaryFixed);
    expect(
        colorScheme.primaryFixedDim.value32bit, dynamicScheme.primaryFixedDim);
    expect(colorScheme.onPrimaryFixed.value32bit, dynamicScheme.onPrimaryFixed);
    expect(colorScheme.onPrimaryFixedVariant.value32bit,
        dynamicScheme.onPrimaryFixedVariant);
    expect(colorScheme.secondary.value32bit, dynamicScheme.secondary);
    expect(colorScheme.onSecondary.value32bit, dynamicScheme.onSecondary);
    expect(colorScheme.secondaryContainer.value32bit,
        dynamicScheme.secondaryContainer);
    expect(colorScheme.onSecondaryContainer.value32bit,
        dynamicScheme.onSecondaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onSecondaryContainer.value32bit, 4280883206);
    // expect(4284039724, dynamicScheme.onSecondaryContainer);
    //
    expect(colorScheme.secondaryFixed.value32bit, dynamicScheme.secondaryFixed);
    expect(colorScheme.secondaryFixedDim.value32bit,
        dynamicScheme.secondaryFixedDim);
    expect(colorScheme.onSecondaryFixed.value32bit,
        dynamicScheme.onSecondaryFixed);
    expect(colorScheme.onSecondaryFixedVariant.value32bit,
        dynamicScheme.onSecondaryFixedVariant);
    expect(colorScheme.tertiary.value32bit, dynamicScheme.tertiary);
    expect(colorScheme.onTertiary.value32bit, dynamicScheme.onTertiary);
    expect(colorScheme.tertiaryContainer.value32bit,
        dynamicScheme.tertiaryContainer);
    expect(colorScheme.onTertiaryContainer.value32bit,
        dynamicScheme.onTertiaryContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onTertiaryContainer.value32bit, 4279639553);
    // expect(4282469156, dynamicScheme.onTertiaryContainer);
    //
    expect(colorScheme.tertiaryFixed.value32bit, dynamicScheme.tertiaryFixed);
    expect(colorScheme.tertiaryFixedDim.value32bit,
        dynamicScheme.tertiaryFixedDim);
    expect(
        colorScheme.onTertiaryFixed.value32bit, dynamicScheme.onTertiaryFixed);
    expect(colorScheme.onTertiaryFixedVariant.value32bit,
        dynamicScheme.onTertiaryFixedVariant);
    expect(colorScheme.error.value32bit, dynamicScheme.error);
    expect(colorScheme.onError.value32bit, dynamicScheme.onError);
    expect(colorScheme.errorContainer.value32bit, dynamicScheme.errorContainer);
    expect(colorScheme.onErrorContainer.value32bit,
        dynamicScheme.onErrorContainer);
    // TODO(rydmike): Use hard coded values to test expressive colors
    // expect(colorScheme.onErrorContainer.value32bit, 4282449922);
    // expect(4287823882, dynamicScheme.onErrorContainer);
    //
    expect(colorScheme.background.value32bit, dynamicScheme.background);
    expect(colorScheme.onBackground.value32bit, dynamicScheme.onBackground);
    expect(colorScheme.surface.value32bit, dynamicScheme.surface);
    expect(colorScheme.surfaceDim.value32bit, dynamicScheme.surfaceDim);
    expect(colorScheme.surfaceBright.value32bit, dynamicScheme.surfaceBright);
    expect(colorScheme.surfaceContainerLowest.value32bit,
        dynamicScheme.surfaceContainerLowest);
    expect(colorScheme.surfaceContainerLow.value32bit,
        dynamicScheme.surfaceContainerLow);
    expect(colorScheme.surfaceContainer.value32bit,
        dynamicScheme.surfaceContainer);
    expect(colorScheme.surfaceContainerHigh.value32bit,
        dynamicScheme.surfaceContainerHigh);
    expect(colorScheme.surfaceContainerHighest.value32bit,
        dynamicScheme.surfaceContainerHighest);
    expect(colorScheme.onSurface.value32bit, dynamicScheme.onSurface);
    expect(colorScheme.surfaceVariant.value32bit, dynamicScheme.surfaceVariant);
    expect(colorScheme.onSurfaceVariant.value32bit,
        dynamicScheme.onSurfaceVariant);
    expect(colorScheme.outline.value32bit, dynamicScheme.outline);
    expect(colorScheme.outlineVariant.value32bit, dynamicScheme.outlineVariant);
    expect(colorScheme.shadow.value32bit, dynamicScheme.shadow);
    expect(colorScheme.scrim.value32bit, dynamicScheme.scrim);
    expect(colorScheme.inverseSurface.value32bit, dynamicScheme.inverseSurface);
    expect(colorScheme.onInverseSurface.value32bit,
        dynamicScheme.inverseOnSurface);
    expect(colorScheme.inversePrimary.value32bit, dynamicScheme.inversePrimary);
    expect(colorScheme.surfaceTint.value32bit, dynamicScheme.surfaceTint);
  });
}
