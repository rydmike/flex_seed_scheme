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
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);

    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff747474));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff000000));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff000000));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd9d9d9));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff3b3b3b));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff3b3b3b));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff7A7A7A));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff919191));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffffffff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffffffff));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff3a3a3a));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd4d4d4));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd4d4d4));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff848484));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff000000));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff000000));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff848484));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff000000));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff000000));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_monochromeSpec', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
      sourceColorHct: Hct.fromInt(0xff0000ff),
      isDark: true,
      contrastLevel: 0.0,
    );
    expect(
      MaterialDynamicColors.primary.getHct(scheme).tone,
      closeTo(100, 1),
    );
    expect(
      MaterialDynamicColors.onPrimary.getHct(scheme).tone,
      closeTo(10, 1),
    );
    expect(
      MaterialDynamicColors.primaryContainer.getHct(scheme).tone,
      closeTo(85, 1),
    );
    expect(
      MaterialDynamicColors.onPrimaryContainer.getHct(scheme).tone,
      closeTo(0, 1),
    );
    expect(
      MaterialDynamicColors.secondary.getHct(scheme).tone,
      closeTo(80, 1),
    );
    expect(
      MaterialDynamicColors.onSecondary.getHct(scheme).tone,
      closeTo(10, 1),
    );
    expect(
      MaterialDynamicColors.secondaryContainer.getHct(scheme).tone,
      closeTo(30, 1),
    );
    expect(
      MaterialDynamicColors.onSecondaryContainer.getHct(scheme).tone,
      closeTo(90, 1),
    );
    expect(
      MaterialDynamicColors.tertiary.getHct(scheme).tone,
      closeTo(90, 1),
    );
    expect(
      MaterialDynamicColors.onTertiary.getHct(scheme).tone,
      closeTo(10, 1),
    );
    expect(
      MaterialDynamicColors.tertiaryContainer.getHct(scheme).tone,
      closeTo(60, 1),
    );
    expect(
      MaterialDynamicColors.onTertiaryContainer.getHct(scheme).tone,
      closeTo(0, 1),
    );
  });

  test('lightTheme_monochromeSpec', () {
    final SchemeMonochrome scheme = SchemeMonochrome(
      sourceColorHct: Hct.fromInt(0xff0000ff),
      isDark: false,
      contrastLevel: 0.0,
    );
    expect(
      MaterialDynamicColors.primary.getHct(scheme).tone,
      closeTo(0, 1),
    );
    expect(
      MaterialDynamicColors.onPrimary.getHct(scheme).tone,
      closeTo(90, 1),
    );
    expect(
      MaterialDynamicColors.primaryContainer.getHct(scheme).tone,
      closeTo(25, 1),
    );
    expect(
      MaterialDynamicColors.onPrimaryContainer.getHct(scheme).tone,
      closeTo(100, 1),
    );
    expect(
      MaterialDynamicColors.secondary.getHct(scheme).tone,
      closeTo(40, 1),
    );
    expect(
      MaterialDynamicColors.onSecondary.getHct(scheme).tone,
      closeTo(100, 1),
    );
    expect(
      MaterialDynamicColors.secondaryContainer.getHct(scheme).tone,
      closeTo(85, 1),
    );
    expect(
      MaterialDynamicColors.onSecondaryContainer.getHct(scheme).tone,
      closeTo(10, 1),
    );
    expect(
      MaterialDynamicColors.tertiary.getHct(scheme).tone,
      closeTo(25, 1),
    );
    expect(
      MaterialDynamicColors.onTertiary.getHct(scheme).tone,
      closeTo(90, 1),
    );
    expect(
      MaterialDynamicColors.tertiaryContainer.getHct(scheme).tone,
      closeTo(49, 1),
    );
    expect(
      MaterialDynamicColors.onTertiaryContainer.getHct(scheme).tone,
      closeTo(100, 1),
    );
  });
}
