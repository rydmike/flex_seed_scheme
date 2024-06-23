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
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);

    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff080cff));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff7b7296));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff886c9d));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff777682));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff767685));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff5660ff));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff343dff));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff00019F));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd5d6ff));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0000F6));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff5E68FF));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff0000EF));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff00006E));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff7c84ff));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffbec2ff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffF0EEFF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0001c9));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0000ef));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffBABDFF));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff6B75FF));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff00003D));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff9679AB));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xfff2daff));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff16002A));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeVibrant scheme = SchemeVibrant(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12131c));
  });
}
