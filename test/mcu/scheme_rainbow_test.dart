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
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff696fc4));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff75758b));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff936b84));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff070707));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff676dc1));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff5056a9));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff1B2074));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd5d6ff));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff3A4092));
  });

  test('lightTheme_minContrast_tertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xfffbcbe7));
  });

  test('lightTheme_standardContrast_tertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xffffd8ee));
  });

  test('lightTheme_maxContrast_tertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff613E55));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff6C72C7));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff383E8F));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff050865));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfff9f9f9));
  });

  test('lightTheme_standardContrast_secondary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.secondary.getArgb(scheme), isColor(0xff5c5d72));
  });

  test('lightTheme_standardContrast_secondaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.secondaryContainer.getArgb(scheme),
        isColor(0xffe1e0f9));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff8389e0));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffbec2ff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffF0EEFF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff2a3082));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff383e8f));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffBABDFF));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff767CD2));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff00003D));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffA17891));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffffd8ee));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff1B0315));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131313));
  });

  test('darkTheme_standardContrast_secondary', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.secondary.getArgb(scheme), isColor(0xffc5c4dd));
  });

  test('darkTheme_standardContrast_secondaryContainer', () {
    final SchemeRainbow scheme = SchemeRainbow(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.secondaryContainer.getArgb(scheme),
        isColor(0xff444559));
  });
}
