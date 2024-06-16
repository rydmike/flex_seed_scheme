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
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff080cff));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff656dd3));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff81009f));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff767684));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff757589));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff5660ff));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff0001BB));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff00019F));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffd5d6ff));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0000FF));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0000F6));
  });

  test('lightTheme_minContrast_tertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xfffac9ff));
  });

  test('lightTheme_standardContrast_tertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff81009F));
  });

  test('lightTheme_maxContrast_tertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff7D009A));
  });

  test('lightTheme_minContrast_objectionableTertiaryContainerLightens', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff850096),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xffffccd7));
  });

  test('lightTheme_standardContrast_objectionableTertiaryContainerLightens',
      () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff850096),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff980249));
  });

  test('lightTheme_maxContrast_objectionableTertiaryContainerDarkens', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff850096),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.tertiaryContainer.getArgb(scheme),
        isColor(0xff930046));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff5E68FF));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffB3B7FF));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff7c84ff));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffbec2ff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffF0EEFF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0001c9));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff0000FF));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffBABDFF));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff6B75FF));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffB3B7FF));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff00003D));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffC254DE));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffF09FFF));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff1A0022));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12121d));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12121d));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeContent scheme = SchemeContent(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff12121d));
  });
}
