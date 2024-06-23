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
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);

    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff767685));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff777680));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff75758b));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff787678));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff787678));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff737383));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff5d5d6c));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff2B2B38));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd9d7e9));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffe2e1f3));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff484856));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff797888));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff454654));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff1A1B27));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffcf8fa));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffcf8fa));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffcf8fa));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff908f9f));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffc6c5d6));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffF0EEFF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff393947));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff454654));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffC2C1D2));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff838393));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffe2e1f3));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff090A16));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff828299));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffe1e0f9));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff080A1B));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131315));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131315));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeNeutral scheme = SchemeNeutral(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131315));
  });
}
