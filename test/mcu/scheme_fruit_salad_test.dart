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

import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';
import 'package:test/test.dart';

import './utils/color_matcher.dart';

void main() {
  test('keyColors', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff0091c0));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff3a7e9e));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff6e72ac));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff777682));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff75758b));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff007ea7));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff006688));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff003042));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffaae0ff));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffc2e8ff));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff004F6B));
  });

  test('lightTheme_minContrast_tertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xffd5d6ff));
  });

  test('lightTheme_standardContrast_tertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('lightTheme_maxContrast_tertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff40447B));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff0083AE));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff004D67));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff001E2B));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_standardContrast_secondary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.secondary.getArgb(scheme), isColor(0xff196584));
  });

  test('lightTheme_standardContrast_secondaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.secondaryContainer.getArgb(scheme),
        isColor(0xffc2e8ff));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff1e9bcb));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff76d1ff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffE0F3FF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff003f56));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff004d67));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff68CEFF));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff008EBC));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffc2e8ff));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff000D15));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff7B7FBB));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff00003C));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });

  test('darkTheme_standardContrast_secondary', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.secondary.getArgb(scheme), isColor(0xff8ecff2));
  });

  test('darkTheme_standardContrast_secondaryContainer', () {
    final SchemeFruitSalad scheme = SchemeFruitSalad(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.secondaryContainer.getArgb(scheme),
        isColor(0xff004d67));
  });
}
