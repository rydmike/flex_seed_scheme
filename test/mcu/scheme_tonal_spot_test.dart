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
  // New tests
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

  // Old tests
  test('lightTheme_minContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff6C70AA));
  });

  test('lightTheme_standardContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff555992));
  });

  test('lightTheme_maxContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff22265C));
  });

  test('lightTheme_minContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffD5D6FF));
  });

  test('lightTheme_standardContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('lightTheme_maxContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff40447B));
  });

  test('lightTheme_minContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff7175B0));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff3E4278));
  });

  test('lightTheme_standardContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        useExpressiveOnContainerColors: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff11144B));
  });

  test('lightTheme_maxContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffFFFFFF));
  });

  test('lightTheme_minContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_standardContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_maxContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xfffbf8ff));
  });

  test('lightTheme_minContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xff5f5e65));
  });

  test('lightTheme_standardContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xff1b1b21));
  });

  test('lightTheme_maxContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xff000000));
  });

  test('lightTheme_minContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xffFFFBFF));
  });

  test('lightTheme_standardContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xffffffff));
  });

  test('lightTheme_maxContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xffFFFFFF));
  });

  test('lightTheme_minContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xffFFFBFF));
  });

  test('lightTheme_standardContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xffffffff));
  });

  test('lightTheme_maxContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xffFFFFFF));
  });

  test('lightTheme_minContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xffFFFBFF));
  });

  test('lightTheme_standardContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xffffffff));
  });

  test('lightTheme_maxContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: false,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xffFFFFFF));
  });

  test('darkTheme_minContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xff888CC8));
  });

  test('darkTheme_standardContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffbec2ff));
  });

  test('darkTheme_maxContrast_primary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primary.getArgb(scheme), isColor(0xffF0EEFF));
  });

  test('darkTheme_minContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff31356B));
  });

  test('darkTheme_standardContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xff3E4278));
  });

  test('darkTheme_maxContrast_primaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.primaryContainer.getArgb(scheme),
        isColor(0xffBABEFD));
  });

  test('darkTheme_minContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff7B7FBB));
  });

  test('darkTheme_standardContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xffe0e0ff));
  });

  test('darkTheme_maxContrast_onPrimaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme),
        isColor(0xff00003C));
  });

  test('darkTheme_minContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xff27283B));
  });

  test('darkTheme_standardContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xff2e2f42));
  });

  test('darkTheme_maxContrast_onSecondary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onSecondary.getArgb(scheme), isColor(0xff000000));
  });

  test('darkTheme_minContrast_onTertiaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffA17891));
  });

  test('darkTheme_standardContrast_onTertiaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xffffd8ee));
  });

  test('darkTheme_maxContrast_onTertiaryContainer', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme),
        isColor(0xff1B0315));
  });

  test('darkTheme_minContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xff3E1F34));
  });

  test('darkTheme_standardContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xff46263b));
  });

  test('darkTheme_maxContrast_onTertiary', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onTertiary.getArgb(scheme), isColor(0xff000000));
  });

  test('darkTheme_minContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xff5C0003));
  });

  test('darkTheme_standardContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xff690005));
  });

  test('darkTheme_maxContrast_onError', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.onError.getArgb(scheme), isColor(0xff000000));
  });

  test('darkTheme_minContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131318));
  });

  test('darkTheme_standardContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131318));
  });

  test('darkTheme_maxContrast_surface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(MaterialDynamicColors.surface.getArgb(scheme), isColor(0xff131318));
  });

  test('darkTheme_minContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: -1.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xffa4a2a9));
  });

  test('darkTheme_standardContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 0.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xffe4e1e9));
  });

  test('darkTheme_maxContrast_onSurface', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xff0000ff),
        isDark: true,
        contrastLevel: 1.0);
    expect(
        MaterialDynamicColors.onSurface.getArgb(scheme), isColor(0xffFFFFFF));
  });

  test('lightTheme colors are correct', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
      sourceColorHct: Hct.fromInt(0xff0000ff),
      isDark: false,
      contrastLevel: 0.0,
    );
    expect(MaterialDynamicColors.inverseSurface.getArgb(scheme),
        isColor(0xff303036));
    expect(MaterialDynamicColors.inverseOnSurface.getArgb(scheme),
        isColor(0xfff2eff7));
    expect(MaterialDynamicColors.outlineVariant.getArgb(scheme),
        isColor(0xffc7c5d0));
    expect(MaterialDynamicColors.shadow.getArgb(scheme), isColor(0xff000000));
    expect(MaterialDynamicColors.scrim.getArgb(scheme), isColor(0xff000000));
    expect(
        MaterialDynamicColors.surfaceTint.getArgb(scheme), isColor(0xff555992));
    expect(MaterialDynamicColors.inversePrimary.getArgb(scheme),
        isColor(0xffbec2ff));
  });

  test('darkTheme colors are correct', () {
    final SchemeTonalSpot scheme = SchemeTonalSpot(
      sourceColorHct: Hct.fromInt(0xff0000ff),
      isDark: true,
      contrastLevel: 0.0,
    );
    expect(MaterialDynamicColors.inverseSurface.getArgb(scheme),
        isColor(0xffe4e1e9));
    expect(MaterialDynamicColors.inverseOnSurface.getArgb(scheme),
        isColor(0xff303036));
    expect(MaterialDynamicColors.outlineVariant.getArgb(scheme),
        isColor(0xff46464f));
    expect(MaterialDynamicColors.shadow.getArgb(scheme), isColor(0xff000000));
    expect(MaterialDynamicColors.scrim.getArgb(scheme), isColor(0xff000000));
    expect(
        MaterialDynamicColors.surfaceTint.getArgb(scheme), isColor(0xffbec2ff));
    expect(MaterialDynamicColors.inversePrimary.getArgb(scheme),
        isColor(0xff555992));
  });
}
