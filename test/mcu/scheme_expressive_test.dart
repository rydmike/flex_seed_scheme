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
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);

    expect(MaterialDynamicColors.primaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff35855f));
    expect(MaterialDynamicColors.secondaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff8c6d8c));
    expect(MaterialDynamicColors.tertiaryPaletteKeyColor.getArgb(scheme),
        isColor(0xff806ea1));
    expect(MaterialDynamicColors.neutralPaletteKeyColor.getArgb(scheme),
        isColor(0xff79757f));
    expect(MaterialDynamicColors.neutralVariantPaletteKeyColor.getArgb(scheme),
        isColor(0xff7a7585));
  });

  test('lightTheme_minContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff32835d));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff146c48));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff00341F));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff99eabd));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffa2f4c6));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff005436));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff388862));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff005234));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff002112));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffffffff));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffdf7ff));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffdf7ff));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffdf7ff));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff51a078));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff87d7ab));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);

    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffBBFFD7));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff00432a));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff005234));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff83D3A8));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff43936C));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffa2f4c6));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff000E06));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff14121a));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff14121a));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeExpressive scheme = SchemeExpressive(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff14121a));
  });
}
