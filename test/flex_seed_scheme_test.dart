import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // FlexSeedScheme unit tests for using FlexKeyColors and FlexTones
  //****************************************************************************
  group('FCS7: WITH FlexSeedScheme ', () {
    debugDefaultTargetPlatformOverride = null;

    const Color primarySeedColor = Color(0xFF6750A4);
    const Color secondarySeedColor = Color(0xFF3871BB);
    const Color tertiarySeedColor = Color(0xFF6CA450);

    // A key promise of the algorithm is that SeedColorScheme.fromSeeds produced
    // with only one and same seed color, should be equal to using Flutter
    // ColorScheme.fromSeed with same color, this verifies that it is so.
    test(
        'FCS7.001-l: GIVEN a SeedColorScheme.fromSeeds using only one seed '
        'EXPECT equal to ColorScheme.fromSeed using same color as key.', () {
      final ColorScheme flutter = ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primarySeedColor,
      );

      // TODO(rydmike): Remove surfaceVariant from test when Flutter removes it.
      // We have to copy the surfaceVariant from the Flutter scheme to the
      // SeedColorScheme as it is not part of colors it makes anymore since it
      // is deprecated in the Flutter ColorScheme class, but Flutter
      // ColorScheme.fromSeed still uses it, even though it is deprecated in
      // the Flutter ColorScheme class.
      final ColorScheme flex = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        // ignore: deprecated_member_use, for testing, still used in SDK.
      ).copyWith(surfaceVariant: flutter.surfaceVariant);

      expect(
        flex,
        equals(flutter),
      );
    });
    test(
        'FCS7.001-d: GIVEN a ColorScheme.fromSeeds using only one seed '
        'EXPECT equal to ColorScheme.fromSeed using same color as key.', () {
      final ColorScheme flutter = ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primarySeedColor,
      );
      // TODO(rydmike): Remove surfaceVariant from test when Flutter removes it.
      // We have to copy the surfaceVariant from the Flutter scheme to the
      // SeedColorScheme as it is not part of colors it makes anymore since it
      // is deprecated in the Flutter ColorScheme class, but Flutter
      // ColorScheme.fromSeed still uses it, even though it is deprecated in
      // the Flutter ColorScheme class.
      final ColorScheme flex = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        // ignore: deprecated_member_use, for testing, still used in SDK.
      ).copyWith(surfaceVariant: flutter.surfaceVariant);

      expect(
        flex,
        equals(flutter),
      );
    });
    // Custom tests seed tests. We don't have any real refs to lock them
    // down to, but we can do reference value test so we know if they ever
    // change for any reason. Like the HCT algo being updated again
    // as it did from version 0.1.4 to 0.1.5 of material_color_utilities.
    test(
        'FCS7.002-l: GIVEN a SeedColorScheme.fromSeeds using two seeds '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.light,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#eb1e3(brightness: Brightness.light, primary: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.3333, green: 0.3725, blue: 0.4431, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.4941, green: 0.3216, blue: 0.3765, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8510, blue: 0.8902, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 0.1922, green: 0.0627, blue: 0.1137, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 1.0000, green: 0.8510, blue: 0.8902, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.9373, green: 0.7216, blue: 0.7843, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.1922, green: 0.0627, blue: 0.1137, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.3882, green: 0.2314, blue: 0.2824, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 0.7294, green: 0.1020, blue: 0.1020, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8549, blue: 0.8392, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 0.2549, green: 0.0000, blue: 0.0078, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.8706, green: 0.8471, blue: 0.8784, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.9725, green: 0.9490, blue: 0.9804, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.9490, green: 0.9255, blue: 0.9569, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.9255, green: 0.9020, blue: 0.9333, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.2863, green: 0.2706, blue: 0.3059, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.4784, green: 0.4588, blue: 0.4980, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.7922, green: 0.7686, blue: 0.8118, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.1961, green: 0.1843, blue: 0.2078, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 0.9608, green: 0.9373, blue: 0.9686, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    test(
        'FCS7.002-2: GIVEN a SeedColorScheme.fromSeeds using two seeds '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.dark,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#5d66c(brightness: Brightness.dark, primary: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 0.2118, green: 0.1529, blue: 0.3647, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 0.1529, green: 0.1922, blue: 0.2549, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.9373, green: 0.7216, blue: 0.7843, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 0.2902, green: 0.1451, blue: 0.1961, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 0.3882, green: 0.2314, blue: 0.2824, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8510, blue: 0.8902, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 1.0000, green: 0.8510, blue: 0.8902, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.9373, green: 0.7216, blue: 0.7843, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.1922, green: 0.0627, blue: 0.1137, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.3882, green: 0.2314, blue: 0.2824, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 1.0000, green: 0.7059, blue: 0.6706, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 0.4118, green: 0.0000, blue: 0.0196, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 0.5765, green: 0.0000, blue: 0.0392, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8549, blue: 0.8392, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.2314, green: 0.2196, blue: 0.2431, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 0.0588, green: 0.0510, blue: 0.0745, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.1294, green: 0.1216, blue: 0.1412, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.1686, green: 0.1608, blue: 0.1843, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.2118, green: 0.2039, blue: 0.2275, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.7922, green: 0.7686, blue: 0.8118, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.5804, green: 0.5608, blue: 0.6000, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.2863, green: 0.2706, blue: 0.3059, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 0.1961, green: 0.1843, blue: 0.2078, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    // With three seeds.
    test(
        'FCS7.003-l: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.light,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
          tertiaryKey: tertiarySeedColor,
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#53dd1(brightness: Brightness.light, primary: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.3333, green: 0.3725, blue: 0.4431, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.3098, green: 0.3922, blue: 0.2588, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 0.8196, green: 0.9176, blue: 0.7451, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 0.0510, green: 0.1255, blue: 0.0196, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 0.8196, green: 0.9176, blue: 0.7451, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.7098, green: 0.8078, blue: 0.6431, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.0510, green: 0.1255, blue: 0.0196, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.2196, green: 0.2980, blue: 0.1725, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 0.7294, green: 0.1020, blue: 0.1020, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8549, blue: 0.8392, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 0.2549, green: 0.0000, blue: 0.0078, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.8706, green: 0.8471, blue: 0.8784, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.9725, green: 0.9490, blue: 0.9804, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.9490, green: 0.9255, blue: 0.9569, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.9255, green: 0.9020, blue: 0.9333, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.2863, green: 0.2706, blue: 0.3059, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.4784, green: 0.4588, blue: 0.4980, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.7922, green: 0.7686, blue: 0.8118, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.1961, green: 0.1843, blue: 0.2078, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 0.9608, green: 0.9373, blue: 0.9686, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    test(
        'FCS7.003-2: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.dark,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
          tertiaryKey: tertiarySeedColor,
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#df953(brightness: Brightness.dark, primary: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 0.2118, green: 0.1529, blue: 0.3647, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1255, green: 0.0627, blue: 0.2784, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3020, green: 0.2392, blue: 0.4588, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 0.1529, green: 0.1922, blue: 0.2549, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8510, green: 0.8902, blue: 0.9725, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.7412, green: 0.7804, blue: 0.8627, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0706, green: 0.1098, blue: 0.1686, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.2392, green: 0.2784, blue: 0.3451, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.7098, green: 0.8078, blue: 0.6431, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 0.1333, green: 0.2078, blue: 0.0941, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 0.2196, green: 0.2980, blue: 0.1725, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 0.8196, green: 0.9176, blue: 0.7451, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 0.8196, green: 0.9176, blue: 0.7451, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.7098, green: 0.8078, blue: 0.6431, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.0510, green: 0.1255, blue: 0.0196, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.2196, green: 0.2980, blue: 0.1725, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 1.0000, green: 0.7059, blue: 0.6706, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 0.4118, green: 0.0000, blue: 0.0196, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 0.5765, green: 0.0000, blue: 0.0392, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.8549, blue: 0.8392, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.2314, green: 0.2196, blue: 0.2431, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 0.0588, green: 0.0510, blue: 0.0745, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.1137, green: 0.1059, blue: 0.1255, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.1294, green: 0.1216, blue: 0.1412, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.1686, green: 0.1608, blue: 0.1843, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.2118, green: 0.2039, blue: 0.2275, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.7922, green: 0.7686, blue: 0.8118, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.5804, green: 0.5608, blue: 0.6000, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.2863, green: 0.2706, blue: 0.3059, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 0.1961, green: 0.1843, blue: 0.2078, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.3961, green: 0.3333, blue: 0.5608, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.8118, green: 0.7412, blue: 0.9961, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 0.9020, green: 0.8784, blue: 0.9137, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    // With three seeds and custom mapping.
    test(
        'FCS7.004-l: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.ultraContrast '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.light,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
          tertiaryKey: tertiarySeedColor,
          tones: FlexTones.ultraContrast(Brightness.light),
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#1e6a3(brightness: Brightness.light, primary: Color(alpha: 1.0000, red: 0.2275, green: 0.0392, blue: 0.5490, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.0863, green: 0.0000, blue: 0.2549, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7373, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1333, green: 0.0000, blue: 0.3647, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3176, green: 0.1765, blue: 0.6392, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.0000, green: 0.3686, blue: 0.6980, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.8353, green: 0.8902, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.0000, green: 0.0667, blue: 0.1608, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8353, green: 0.8902, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.6549, green: 0.7843, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0000, green: 0.1059, blue: 0.2314, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.0000, green: 0.2784, blue: 0.5333, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.1059, green: 0.3216, blue: 0.0000, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 0.8039, green: 1.0000, blue: 0.6902, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 0.0118, green: 0.0824, blue: 0.0000, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 0.6392, green: 0.9725, blue: 0.4745, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.5333, green: 0.8588, blue: 0.3765, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.0275, green: 0.1294, blue: 0.0000, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.1059, green: 0.3216, blue: 0.0000, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 0.7294, green: 0.1020, blue: 0.1020, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.9294, blue: 0.9176, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 0.1765, green: 0.0000, blue: 0.0039, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.8667, green: 0.8510, blue: 0.8627, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.9922, green: 0.9725, blue: 0.9843, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.9922, green: 0.9725, blue: 0.9843, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.9686, green: 0.9490, blue: 0.9608, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.9255, green: 0.9059, blue: 0.9176, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.9020, green: 0.8824, blue: 0.8941, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.0784, green: 0.0706, blue: 0.0941, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.3765, green: 0.3647, blue: 0.3922, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.6824, green: 0.6627, blue: 0.6941, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.1922, green: 0.1882, blue: 0.1961, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 1.0000, green: 0.9843, blue: 1.0000, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.2275, green: 0.0392, blue: 0.5490, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    test(
        'FCS7.004-d: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.ultraContrast '
        'EXPECT equal to ref ColorScheme values.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.dark,
          primaryKey: primarySeedColor,
          secondaryKey: secondarySeedColor,
          tertiaryKey: tertiarySeedColor,
          tones: FlexTones.ultraContrast(Brightness.dark),
        ).toString(minLevel: DiagnosticLevel.fine),
        equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars, for tests.
          'ColorScheme#43334(brightness: Brightness.dark, primary: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimary: Color(alpha: 1.0000, red: 0.0392, green: 0.0000, blue: 0.1569, colorSpace: ColorSpace.sRGB), primaryContainer: Color(alpha: 1.0000, red: 0.3176, green: 0.1765, blue: 0.6392, colorSpace: ColorSpace.sRGB), onPrimaryContainer: Color(alpha: 1.0000, red: 0.9922, green: 0.9686, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixed: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), primaryFixedDim: Color(alpha: 1.0000, red: 0.8118, green: 0.7373, blue: 1.0000, colorSpace: ColorSpace.sRGB), onPrimaryFixed: Color(alpha: 1.0000, red: 0.1333, green: 0.0000, blue: 0.3647, colorSpace: ColorSpace.sRGB), onPrimaryFixedVariant: Color(alpha: 1.0000, red: 0.3176, green: 0.1765, blue: 0.6392, colorSpace: ColorSpace.sRGB), secondary: Color(alpha: 1.0000, red: 0.9216, green: 0.9451, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSecondary: Color(alpha: 1.0000, red: 0.0000, green: 0.0275, blue: 0.0902, colorSpace: ColorSpace.sRGB), secondaryContainer: Color(alpha: 1.0000, red: 0.0000, green: 0.2784, blue: 0.5333, colorSpace: ColorSpace.sRGB), onSecondaryContainer: Color(alpha: 1.0000, red: 0.9765, green: 0.9765, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryFixed: Color(alpha: 1.0000, red: 0.8353, green: 0.8902, blue: 1.0000, colorSpace: ColorSpace.sRGB), secondaryFixedDim: Color(alpha: 1.0000, red: 0.6549, green: 0.7843, blue: 1.0000, colorSpace: ColorSpace.sRGB), onSecondaryFixed: Color(alpha: 1.0000, red: 0.0000, green: 0.1059, blue: 0.2314, colorSpace: ColorSpace.sRGB), onSecondaryFixedVariant: Color(alpha: 1.0000, red: 0.0000, green: 0.2784, blue: 0.5333, colorSpace: ColorSpace.sRGB), tertiary: Color(alpha: 1.0000, red: 0.8039, green: 1.0000, blue: 0.6902, colorSpace: ColorSpace.sRGB), onTertiary: Color(alpha: 1.0000, red: 0.0039, green: 0.0392, blue: 0.0000, colorSpace: ColorSpace.sRGB), tertiaryContainer: Color(alpha: 1.0000, red: 0.1059, green: 0.3216, blue: 0.0000, colorSpace: ColorSpace.sRGB), onTertiaryContainer: Color(alpha: 1.0000, red: 0.9333, green: 1.0000, blue: 0.8706, colorSpace: ColorSpace.sRGB), tertiaryFixed: Color(alpha: 1.0000, red: 0.6392, green: 0.9725, blue: 0.4745, colorSpace: ColorSpace.sRGB), tertiaryFixedDim: Color(alpha: 1.0000, red: 0.5333, green: 0.8588, blue: 0.3765, colorSpace: ColorSpace.sRGB), onTertiaryFixed: Color(alpha: 1.0000, red: 0.0275, green: 0.1294, blue: 0.0000, colorSpace: ColorSpace.sRGB), onTertiaryFixedVariant: Color(alpha: 1.0000, red: 0.1059, green: 0.3216, blue: 0.0000, colorSpace: ColorSpace.sRGB), error: Color(alpha: 1.0000, red: 1.0000, green: 0.7059, blue: 0.6706, colorSpace: ColorSpace.sRGB), onError: Color(alpha: 1.0000, red: 0.1020, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), errorContainer: Color(alpha: 1.0000, red: 0.5765, green: 0.0000, blue: 0.0392, colorSpace: ColorSpace.sRGB), onErrorContainer: Color(alpha: 1.0000, red: 1.0000, green: 0.9725, blue: 0.9686, colorSpace: ColorSpace.sRGB), surface: Color(alpha: 1.0000, red: 0.0314, green: 0.0275, blue: 0.0353, colorSpace: ColorSpace.sRGB), onSurface: Color(alpha: 1.0000, red: 1.0000, green: 0.9843, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceDim: Color(alpha: 1.0000, red: 0.0784, green: 0.0745, blue: 0.0824, colorSpace: ColorSpace.sRGB), surfaceBright: Color(alpha: 1.0000, red: 0.2275, green: 0.2196, blue: 0.2314, colorSpace: ColorSpace.sRGB), surfaceContainerLowest: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), surfaceContainerLow: Color(alpha: 1.0000, red: 0.0784, green: 0.0745, blue: 0.0824, colorSpace: ColorSpace.sRGB), surfaceContainer: Color(alpha: 1.0000, red: 0.1255, green: 0.1216, blue: 0.1333, colorSpace: ColorSpace.sRGB), surfaceContainerHigh: Color(alpha: 1.0000, red: 0.1686, green: 0.1608, blue: 0.1725, colorSpace: ColorSpace.sRGB), surfaceContainerHighest: Color(alpha: 1.0000, red: 0.2118, green: 0.2039, blue: 0.2157, colorSpace: ColorSpace.sRGB), onSurfaceVariant: Color(alpha: 1.0000, red: 0.9608, green: 0.9373, blue: 0.9686, colorSpace: ColorSpace.sRGB), outline: Color(alpha: 1.0000, red: 0.7922, green: 0.7725, blue: 0.8000, colorSpace: ColorSpace.sRGB), outlineVariant: Color(alpha: 1.0000, red: 0.4745, green: 0.4627, blue: 0.4902, colorSpace: ColorSpace.sRGB), shadow: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), scrim: Color(alpha: 1.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB), inverseSurface: Color(alpha: 1.0000, red: 0.9020, green: 0.8824, blue: 0.8941, colorSpace: ColorSpace.sRGB), onInverseSurface: Color(alpha: 1.0000, red: 0.1098, green: 0.1059, blue: 0.1176, colorSpace: ColorSpace.sRGB), inversePrimary: Color(alpha: 1.0000, red: 0.4118, green: 0.2824, blue: 0.7373, colorSpace: ColorSpace.sRGB), surfaceTint: Color(alpha: 1.0000, red: 0.9137, green: 0.8667, blue: 1.0000, colorSpace: ColorSpace.sRGB), background: Color(alpha: 1.0000, red: 0.0314, green: 0.0275, blue: 0.0353, colorSpace: ColorSpace.sRGB), onBackground: Color(alpha: 1.0000, red: 1.0000, green: 0.9843, blue: 1.0000, colorSpace: ColorSpace.sRGB), surfaceVariant: Color(alpha: 1.0000, red: 0.0314, green: 0.0275, blue: 0.0353, colorSpace: ColorSpace.sRGB))',
        ),
      );
    });
    //
    test(
        'FCS7.005-a: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with onMainsUseBW '
        'EXPECT on colors to be pure black and white contrast colors', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).onMainsUseBW(),
      );
      expect(scheme.onPrimary, Colors.white);
      expect(scheme.onPrimaryContainer, Colors.black);
      expect(scheme.onPrimaryFixed, Colors.black);
      expect(scheme.onPrimaryFixedVariant, Colors.black);
      expect(scheme.onSecondary, Colors.white);
      expect(scheme.onSecondaryContainer, Colors.black);
      expect(scheme.onSecondaryFixed, Colors.black);
      expect(scheme.onSecondaryFixedVariant, Colors.black);
      expect(scheme.onTertiary, Colors.white);
      expect(scheme.onTertiaryContainer, Colors.black);
      expect(scheme.onTertiaryFixed, Colors.black);
      expect(scheme.onTertiaryFixedVariant, Colors.black);
      expect(scheme.onError, Colors.white);
      expect(scheme.onErrorContainer, Colors.black);
    });
    test(
        'FCS7.005-a-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with onMainsUseBW '
        ' false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).onMainsUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light),
      );
      expect(scheme, equals(scheme2));
    });
    test(
        'FCS7.005-b: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with onMainsUseBW '
        'EXPECT on colors to be pure black and white contrast colors', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).onMainsUseBW(),
      );
      expect(scheme.onPrimary, Colors.black);
      expect(scheme.onPrimaryContainer, Colors.white);
      expect(scheme.onPrimaryFixed, Colors.black);
      expect(scheme.onPrimaryFixedVariant, Colors.black);
      expect(scheme.onSecondary, Colors.black);
      expect(scheme.onSecondaryContainer, Colors.white);
      expect(scheme.onSecondaryFixed, Colors.black);
      expect(scheme.onSecondaryFixedVariant, Colors.black);
      expect(scheme.onTertiary, Colors.black);
      expect(scheme.onTertiaryContainer, Colors.white);
      expect(scheme.onTertiaryFixed, Colors.black);
      expect(scheme.onTertiaryFixedVariant, Colors.black);
      expect(scheme.onError, Colors.black);
      expect(scheme.onErrorContainer, Colors.white);
    });
    test(
        'FCS7.005-b-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with onMainsUseBW '
        'false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).onMainsUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark),
      );
      expect(scheme, equals(scheme2));
    });
    //
    //
    test(
        'FCS7.006-a: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with '
        'onSurfacesUseBW '
        'EXPECT on colors to be pure black and white contrast colors', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).onSurfacesUseBW(),
      );
      expect(scheme.onSurface, Colors.black);
      expect(scheme.onInverseSurface, Colors.white);
    });
    test(
        'FCS7.006-a-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with '
        'onSurfacesUseBW false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).onSurfacesUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light),
      );
      expect(scheme, equals(scheme2));
    });
    test(
        'FCS7.006-b: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with '
        'onSurfacesUseBW '
        'EXPECT on colors to be pure black and white contrast colors', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).onSurfacesUseBW(),
      );
      expect(scheme.onSurface, Colors.white);
      expect(scheme.onSurfaceVariant, Colors.white);
      expect(scheme.onInverseSurface, Colors.black);
    });
    test(
        'FCS7.006-b-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with '
        'onSurfacesUseBW false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).onSurfacesUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark),
      );
      expect(scheme, equals(scheme2));
    });
    //
    test(
        'FCS7.006-c: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with '
        'surfacesUseBW '
        'EXPECT surface and background colors to be white.', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).surfacesUseBW(),
      );
      expect(scheme.surface, Colors.white);
    });
    test(
        'FCS7.006-c-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a light scheme with '
        'noOnSurfaceTint false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).surfacesUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light),
      );
      expect(scheme, equals(scheme2));
    });
    test(
        'FCS7.006-c: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with '
        'surfacesUseBW '
        'EXPECT surface and background colors to be black.', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).surfacesUseBW(),
      );
      expect(scheme.surface, Colors.black);
    });
    test(
        'FCS7.006-c-noOp: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and tones map FlexTones.jolly for a dark scheme with '
        'surfacesUseBW false '
        'EXPECT no change', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).onSurfacesUseBW(false),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark),
      );
      expect(scheme, equals(scheme2));
    });
    //
    const Color errorSeedColor = Color(0xFFDE3730);
    test(
        'FCS7.007-l: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and errorSeedColor tones map FlexTones.jolly for a light scheme with '
        'error chroma set to 84 '
        'EXPECT scheme equal to no error color definition', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        tones: FlexTones.jolly(Brightness.light).copyWith(errorChroma: 84),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.007-d: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and errorSeedColor tones map FlexTones.jolly for a dark scheme with '
        'error chroma set to 84 '
        'EXPECT scheme equal to no error color definition', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        tones: FlexTones.jolly(Brightness.dark).copyWith(errorChroma: 84),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.008-l: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and errorSeedColor tones map FlexTones.jolly for a light scheme with '
        'error chroma set to 80, min 40 '
        'EXPECT scheme equal to no error color definition with 80, 40', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        tones: FlexTones.jolly(Brightness.light).copyWith(
          errorChroma: 80,
          errorMinChroma: 40,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.light).copyWith(
          errorChroma: 80,
          errorMinChroma: 40,
        ),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.008-d: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and errorSeedColor tones map FlexTones.jolly for a dark scheme with '
        'error chroma set to 80, min 40 '
        'EXPECT scheme equal to no error color definition with 80, 40', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        tones: FlexTones.jolly(Brightness.dark).copyWith(
          errorChroma: 80,
          errorMinChroma: 40,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.jolly(Brightness.dark).copyWith(
          errorChroma: 80,
          errorMinChroma: 40,
        ),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.009-l: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a light scheme with '
        'error no neutral and variant chroma set  '
        'EXPECT scheme equal to neutral 6 and variant 8', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: secondarySeedColor,
        neutralVariantKey: tertiarySeedColor,
        tones: FlexTones.material(Brightness.light),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: secondarySeedColor,
        neutralVariantKey: tertiarySeedColor,
        tones: FlexTones.material(Brightness.light).copyWith(
          neutralChroma: 6,
          neutralVariantChroma: 8,
        ),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.009-d: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a dark scheme with '
        'error no neutral and variant chroma set  '
        'EXPECT scheme equal to neutral 8 and variant 8', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: secondarySeedColor,
        neutralVariantKey: tertiarySeedColor,
        tones: FlexTones.material(Brightness.dark),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: secondarySeedColor,
        neutralVariantKey: tertiarySeedColor,
        tones: FlexTones.material(Brightness.dark).copyWith(
          neutralChroma: 6,
          neutralVariantChroma: 8,
        ),
      );
      expect(scheme, scheme2);
    });
    const Color neutralSeedColor = Color(0xFF76777C);
    const Color neutralVariantSeedColor = Color(0xFF767871);

    test(
        'FCS7.010-l: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.light for with neutrals from key incl its '
        'own chroma, so no fixed neutral and variant chroma '
        'EXPECT scheme equal to neutral null and variant null', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: const FlexTones.light(
          secondaryChroma: 16,
          tertiaryChroma: 24,
          neutralChroma: null,
          neutralVariantChroma: null,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: const FlexTones.light(
            secondaryChroma: 16,
            tertiaryChroma: 24,
            neutralChroma: null,
            neutralMinChroma: 1,
            neutralVariantChroma: null,
            neutralVariantMinChroma: 1),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.010-d: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.dark for with neutrals from key incl its '
        'own chroma, so no fixed neutral and variant chroma '
        'EXPECT scheme equal to neutral null and variant null', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: const FlexTones.light(
          secondaryChroma: 16,
          tertiaryChroma: 24,
          neutralChroma: null,
          neutralVariantChroma: null,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: const FlexTones.light(
            secondaryChroma: 16,
            tertiaryChroma: 24,
            neutralChroma: null,
            neutralMinChroma: 1,
            neutralVariantChroma: null,
            neutralVariantMinChroma: 1),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.011-l: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a light scheme with '
        'error no neutral and variant chroma set  '
        'EXPECT scheme equal to neutral 4 and variant 8', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light)
            .copyWith(neutralChroma: 5, neutralVariantChroma: 10),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).copyWith(
            neutralChroma: 5,
            neutralMinChroma: 1,
            neutralVariantChroma: 10,
            neutralVariantMinChroma: 1),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.011-d: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a dark scheme with '
        'error no neutral and variant chroma set  '
        'EXPECT scheme equal to neutral 4 and variant 8', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.dark)
            .copyWith(neutralChroma: 5, neutralVariantChroma: 10),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.dark).copyWith(
            neutralChroma: 5,
            neutralMinChroma: 1,
            neutralVariantChroma: 10,
            neutralVariantMinChroma: 1),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.012: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and no tones or variant '
        'EXPECT same as when null assigned to both variant and tones', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        variant: null,
        tones: null,
      );
      expect(scheme, equals(scheme2));
    });
    test(
        'FCS7.013: GIVEN a SeedColorScheme.fromSeeds using three seeds '
        'and variant vivid '
        'EXPECT same as when null assigned to variant and tones '
        'using FlexTones.vivid.', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        variant: FlexSchemeVariant.vivid,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        tones: FlexTones.vivid(Brightness.dark),
      );
      expect(scheme, equals(scheme2));
    });

    // TODO(rydmike): Add tests for contrast levels?
    // ColorScheme test with DynamicScheme

    test(
        'FCS7.013: GIVEN Color values in SeedColorScheme.fromSeeds with '
        'different variants EXPECT that it matches color values in '
        'DynamicScheme when Flutter SDK scheme is used', () {
      const Color seedColor = Colors.orange;
      for (final FlexSchemeVariant schemeVariant in FlexSchemeVariant.values) {
        final DynamicScheme dynamicScheme = SeedColorScheme.buildDynamicScheme(
            brightness: Brightness.light,
            primarySeedColor: seedColor,
            variant: schemeVariant);
        final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
          primaryKey: seedColor,
          variant: schemeVariant,
        );

        if (schemeVariant.isFlutterScheme) {
          expect(colorScheme.primary.value32bit,
              MaterialDynamicColors.primary.getArgb(dynamicScheme));
          expect(colorScheme.onPrimary.value32bit,
              MaterialDynamicColors.onPrimary.getArgb(dynamicScheme));
          expect(colorScheme.primaryContainer.value32bit,
              MaterialDynamicColors.primaryContainer.getArgb(dynamicScheme));
          expect(colorScheme.onPrimaryContainer.value32bit,
              MaterialDynamicColors.onPrimaryContainer.getArgb(dynamicScheme));
          expect(colorScheme.primaryFixed.value32bit,
              MaterialDynamicColors.primaryFixed.getArgb(dynamicScheme));
          expect(colorScheme.primaryFixedDim.value32bit,
              MaterialDynamicColors.primaryFixedDim.getArgb(dynamicScheme));
          expect(colorScheme.onPrimaryFixed.value32bit,
              MaterialDynamicColors.onPrimaryFixed.getArgb(dynamicScheme));
          expect(
              colorScheme.onPrimaryFixedVariant.value32bit,
              MaterialDynamicColors.onPrimaryFixedVariant
                  .getArgb(dynamicScheme));
          expect(colorScheme.secondary.value32bit,
              MaterialDynamicColors.secondary.getArgb(dynamicScheme));
          expect(colorScheme.onSecondary.value32bit,
              MaterialDynamicColors.onSecondary.getArgb(dynamicScheme));
          expect(colorScheme.secondaryContainer.value32bit,
              MaterialDynamicColors.secondaryContainer.getArgb(dynamicScheme));
          expect(
              colorScheme.onSecondaryContainer.value32bit,
              MaterialDynamicColors.onSecondaryContainer
                  .getArgb(dynamicScheme));
          expect(colorScheme.secondaryFixed.value32bit,
              MaterialDynamicColors.secondaryFixed.getArgb(dynamicScheme));
          expect(colorScheme.secondaryFixedDim.value32bit,
              MaterialDynamicColors.secondaryFixedDim.getArgb(dynamicScheme));
          expect(colorScheme.onSecondaryFixed.value32bit,
              MaterialDynamicColors.onSecondaryFixed.getArgb(dynamicScheme));
          expect(
              colorScheme.onSecondaryFixedVariant.value32bit,
              MaterialDynamicColors.onSecondaryFixedVariant
                  .getArgb(dynamicScheme));
          expect(colorScheme.tertiary.value32bit,
              MaterialDynamicColors.tertiary.getArgb(dynamicScheme));
          expect(colorScheme.onTertiary.value32bit,
              MaterialDynamicColors.onTertiary.getArgb(dynamicScheme));
          expect(colorScheme.tertiaryContainer.value32bit,
              MaterialDynamicColors.tertiaryContainer.getArgb(dynamicScheme));
          expect(colorScheme.onTertiaryContainer.value32bit,
              MaterialDynamicColors.onTertiaryContainer.getArgb(dynamicScheme));
          expect(colorScheme.tertiaryFixed.value32bit,
              MaterialDynamicColors.tertiaryFixed.getArgb(dynamicScheme));
          expect(colorScheme.tertiaryFixedDim.value32bit,
              MaterialDynamicColors.tertiaryFixedDim.getArgb(dynamicScheme));
          expect(colorScheme.onTertiaryFixed.value32bit,
              MaterialDynamicColors.onTertiaryFixed.getArgb(dynamicScheme));
          expect(
              colorScheme.onTertiaryFixedVariant.value32bit,
              MaterialDynamicColors.onTertiaryFixedVariant
                  .getArgb(dynamicScheme));
          expect(colorScheme.error.value32bit,
              MaterialDynamicColors.error.getArgb(dynamicScheme));
          expect(colorScheme.onError.value32bit,
              MaterialDynamicColors.onError.getArgb(dynamicScheme));
          expect(colorScheme.errorContainer.value32bit,
              MaterialDynamicColors.errorContainer.getArgb(dynamicScheme));
          expect(colorScheme.onErrorContainer.value32bit,
              MaterialDynamicColors.onErrorContainer.getArgb(dynamicScheme));
          expect(colorScheme.surface.value32bit,
              MaterialDynamicColors.surface.getArgb(dynamicScheme));
          expect(colorScheme.surfaceDim.value32bit,
              MaterialDynamicColors.surfaceDim.getArgb(dynamicScheme));
          expect(colorScheme.surfaceBright.value32bit,
              MaterialDynamicColors.surfaceBright.getArgb(dynamicScheme));
          expect(
              colorScheme.surfaceContainerLowest.value32bit,
              MaterialDynamicColors.surfaceContainerLowest
                  .getArgb(dynamicScheme));
          expect(colorScheme.surfaceContainerLow.value32bit,
              MaterialDynamicColors.surfaceContainerLow.getArgb(dynamicScheme));
          expect(colorScheme.surfaceContainer.value32bit,
              MaterialDynamicColors.surfaceContainer.getArgb(dynamicScheme));
          expect(
              colorScheme.surfaceContainerHigh.value32bit,
              MaterialDynamicColors.surfaceContainerHigh
                  .getArgb(dynamicScheme));
          expect(
              colorScheme.surfaceContainerHighest.value32bit,
              MaterialDynamicColors.surfaceContainerHighest
                  .getArgb(dynamicScheme));
          expect(colorScheme.onSurface.value32bit,
              MaterialDynamicColors.onSurface.getArgb(dynamicScheme));
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
        } else {
          expect(true, true);
        }
      }
    });
    test(
        'FCS7.014-l: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a light scheme with '
        'error neutral and variant chroma set but with neutral chroma '
        'and variant neutral chroma set to 0 '
        'EXPECT scheme equal to using monochromeSurfaces()', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).copyWith(
          neutralMinChroma: 0,
          neutralChroma: 0,
          neutralVariantMinChroma: 0,
          neutralVariantChroma: 0,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).monochromeSurfaces(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.014-fixedColor-l: GIVEN a SeedColorScheme.fromSeeds using '
        'five seeds and tones map FlexTones.material for a light scheme with '
        'error neutral and variant chroma set but with modified fixed '
        'tones and variant tones '
        'EXPECT scheme equal to using higherContrastFixed()', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).copyWith(
          primaryFixedTone: 92,
          primaryFixedDimTone: 84,
          onPrimaryFixedTone: 6,
          onPrimaryFixedVariantTone: 12,
          //
          secondaryFixedTone: 92,
          secondaryFixedDimTone: 84,
          onSecondaryFixedTone: 6,
          onSecondaryFixedVariantTone: 12,
          //
          tertiaryFixedTone: 92,
          tertiaryFixedDimTone: 84,
          onTertiaryFixedTone: 6,
          onTertiaryFixedVariantTone: 12,
        ),
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).higherContrastFixed(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.015-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a light scheme '
        'EXPECT scheme equal to using tones material with same seeds', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.015-d: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a dark scheme '
        'EXPECT scheme equal to using tones material with same seeds', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.dark),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a light scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-l-expr: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a light scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and useExpressiveOnContainerColors true', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        tones: FlexTones.material(Brightness.light),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-d: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a dark scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.dark).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-d-expr: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant tonalSpot for a dark scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and useExpressiveOnContainerColors true', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.tonalSpot,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        tones: FlexTones.material(Brightness.dark),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-l-expr2: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant material for a light scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.material,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.light).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-d-expr2: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant material for a dark scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.material,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.material(Brightness.dark).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-l-expr3: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant chroma for a light scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.chroma,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.chroma(Brightness.light).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.016-d-expr3: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant chroma for a dark scheme and '
        'useExpressiveOnContainerColors set to true '
        'EXPECT scheme equal to using tones material with same seeds '
        'and using modifier expressiveOnContainer', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.chroma,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        tones: FlexTones.chroma(Brightness.dark).expressiveOnContainer(),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.017-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.content,
      );
      expect(scheme.primary, const Color(0xff4f378a));
      expect(scheme.primaryContainer, const Color(0xff6750a4));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff1f5205));
      expect(scheme.tertiaryContainer, const Color(0xff376b1e));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });

    test(
        'FCS7.017-l-respect: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.black,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.content,
      );
      expect(scheme.primary, const Color(0xff000000));
      expect(scheme.primaryContainer, const Color(0xff1b1b1b));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff000000));
      expect(scheme.tertiaryContainer, const Color(0xff072100));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.017-l-respect: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and variant content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffcccccc),
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.content,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffcccccc));
      expect(scheme.secondary, const Color(0xFF5E5E5E));
      expect(scheme.secondaryContainer, const Color(0xFFE2E2E2));
      expect(scheme.tertiary, const Color(0xFF5E5E5E));
      expect(scheme.tertiaryContainer, const Color(0xFFCCCCCC));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xFFF9F9F9));
      expect(scheme.surfaceContainer, const Color(0xFFEEEEEE));
    });
    test(
        'FCS7.017-l-mono-2: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant content for a light scheme and '
        'respectMonochromeSeed false '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: secondarySeedColor,
        tertiaryKey: const Color(0xFF999999),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: false,
        variant: FlexSchemeVariant.content,
      );
      expect(scheme.primary, const Color(0xff5d5f5f));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffdedddd));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.017-l-mono-3: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: const Color(0xFF555555),
        tertiaryKey: const Color(0xFF999999),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.content,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffe2e2e2));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffdddddd));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.018-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant expressive for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.expressive,
      );
      expect(scheme.primary, const Color(0xff006b5a));
      expect(scheme.primaryContainer, const Color(0xff95f4dc));
      expect(scheme.secondary, const Color(0xff7b5266));
      expect(scheme.secondaryContainer, const Color(0xffffd8e8));
      expect(scheme.tertiary, const Color(0xff1f695e));
      expect(scheme.tertiaryContainer, const Color(0xffa9f0e2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffbf8ff));
      expect(scheme.surfaceContainer, const Color(0xffeeedf8));
    });
    test(
        'FCS7.018-l-mono: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant expressive for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.expressive,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff7b5266));
      expect(scheme.secondaryContainer, const Color(0xffffd8e8));
      expect(scheme.tertiary, const Color(0xff1f695e));
      expect(scheme.tertiaryContainer, const Color(0xffa9f0e2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffbf8ff));
      expect(scheme.surfaceContainer, const Color(0xffeeedf8));
    });
    test(
        'FCS7.019-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and variant fidelity for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.fidelity,
      );
      expect(scheme.primary, const Color(0xff4f378a));
      expect(scheme.primaryContainer, const Color(0xff6750a4));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff1f5205));
      expect(scheme.tertiaryContainer, const Color(0xff376b1e));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.019-l-mono: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant fidelity for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.fidelity,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff366a1d));
      expect(scheme.tertiaryContainer, const Color(0xffb1ee91));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.019-l-mono-2: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant fidelity for a light scheme and '
        'respectMonochromeSeed false '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: secondarySeedColor,
        tertiaryKey: const Color(0xFF999999),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: false,
        variant: FlexSchemeVariant.fidelity,
      );
      expect(scheme.primary, const Color(0xff5d5f5f));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff4d5f7d));
      expect(scheme.secondaryContainer, const Color(0xffc8dbfe));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffdedddd));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.019-l-mono-3: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant fidelity for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: const Color(0xFF555555),
        tertiaryKey: const Color(0xFF999999),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.fidelity,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffe2e2e2));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffdddddd));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.019-l-mono-4: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and variant fidelity for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xffdddddd),
        secondaryKey: const Color(0xFF555555),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.fidelity,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffdddddd));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffe2e2e2));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffdddddd));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcf8f8));
      expect(scheme.surfaceContainer, const Color(0xfff1eded));
    });
    test(
        'FCS7.020-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and fruitSalad content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.fruitSalad,
      );
      expect(scheme.primary, const Color(0xff00639c));
      expect(scheme.primaryContainer, const Color(0xffcee5ff));
      expect(scheme.secondary, const Color(0xff006875));
      expect(scheme.secondaryContainer, const Color(0xff9eeffe));
      expect(scheme.tertiary, const Color(0xff446732));
      expect(scheme.tertiaryContainer, const Color(0xffc5efab));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9ff));
      expect(scheme.surfaceContainer, const Color(0xffeaeefa));
    });
    test(
        'FCS7.020-l-mono: GIVEN a SeedColorScheme.fromSeeds using six '
        'seeds and fruitSalad content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.black,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.fruitSalad,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff006875));
      expect(scheme.secondaryContainer, const Color(0xff9eeffe));
      expect(scheme.tertiary, const Color(0xff446732));
      expect(scheme.tertiaryContainer, const Color(0xffc5efab));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9ff));
      expect(scheme.surfaceContainer, const Color(0xffeaeefa));
    });
    test(
        'FCS7.021-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and monochrome content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.monochrome,
      );
      expect(scheme.primary, const Color(0xff000000));
      expect(scheme.primaryContainer, const Color(0xff3b3b3b));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffd4d4d4));
      expect(scheme.tertiary, const Color(0xff3b3b3b));
      expect(scheme.tertiaryContainer, const Color(0xff747474));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9f9));
      expect(scheme.surfaceContainer, const Color(0xffeeeeee));
    });
    test(
        'FCS7.021-l-mono: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and monochrome content for a light scheme and using mono error '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.black,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: Colors.black,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.monochrome,
      );
      expect(scheme.primary, const Color(0xff000000));
      expect(scheme.primaryContainer, const Color(0xff3b3b3b));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffd4d4d4));
      expect(scheme.tertiary, const Color(0xff3b3b3b));
      expect(scheme.tertiaryContainer, const Color(0xff747474));
      expect(scheme.error, const Color(0xff5e5e5e));
      expect(scheme.errorContainer, const Color(0xffe2e2e2));
      expect(scheme.surface, const Color(0xfff9f9f9));
      expect(scheme.surfaceContainer, const Color(0xffeeeeee));
    });
    test(
        'FCS7.022-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and neutral content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.neutral,
      );
      expect(scheme.primary, const Color(0xff615c6b));
      expect(scheme.primaryContainer, const Color(0xffe7dff2));
      expect(scheme.secondary, const Color(0xff5b5e66));
      expect(scheme.secondaryContainer, const Color(0xffe0e2ec));
      expect(scheme.tertiary, const Color(0xff55624c));
      expect(scheme.tertiaryContainer, const Color(0xffd8e7cb));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffbf8fa));
      expect(scheme.surfaceContainer, const Color(0xfff0edee));
    });
    test(
        'FCS7.022-l-mono: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and neutral content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.white,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.neutral,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff5b5e66));
      expect(scheme.secondaryContainer, const Color(0xffe0e2ec));
      expect(scheme.tertiary, const Color(0xff55624c));
      expect(scheme.tertiaryContainer, const Color(0xffd8e7cb));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffbf8fa));
      expect(scheme.surfaceContainer, const Color(0xfff0edee));
    });
    test(
        'FCS7.022-l-mono: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and neutral content for a light scheme and '
        'respectMonochromeSeed true '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.white,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.neutral,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xFF5E5E5E));
      expect(scheme.secondaryContainer, const Color(0xFFE2E2E2));
      expect(scheme.tertiary, const Color(0xFF5E5E5E));
      expect(scheme.tertiaryContainer, const Color(0xffe2e2e2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xFFF9F9F9));
      expect(scheme.surfaceContainer, const Color(0xFFEEEEEE));
    });
    test(
        'FCS7.023-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and rainbow content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.rainbow,
      );
      expect(scheme.primary, const Color(0xff6750a4));
      expect(scheme.primaryContainer, const Color(0xffe9ddff));
      expect(scheme.secondary, const Color(0xff555f71));
      expect(scheme.secondaryContainer, const Color(0xffd9e3f8));
      expect(scheme.tertiary, const Color(0xff4f6442));
      expect(scheme.tertiaryContainer, const Color(0xffd1eabe));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9f9));
      expect(scheme.surfaceContainer, const Color(0xffeeeeee));
    });
    test(
        'FCS7.023-l-mono: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and rainbow content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xFF111111),
        secondaryKey: secondarySeedColor,
        tertiaryKey: const Color(0xFF222222),
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.rainbow,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff555f71));
      expect(scheme.secondaryContainer, const Color(0xffd9e3f8));
      expect(scheme.tertiary, const Color(0xff5e5e5e));
      expect(scheme.tertiaryContainer, const Color(0xffe2e2e2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9f9));
      expect(scheme.surfaceContainer, const Color(0xffeeeeee));
    });
    test(
        'FCS7.024-l: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and vibrant content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        variant: FlexSchemeVariant.vibrant,
      );
      expect(scheme.primary, const Color(0xff6f19ff));
      expect(scheme.primaryContainer, const Color(0xffe9ddff));
      expect(scheme.secondary, const Color(0xff565d7e));
      expect(scheme.secondaryContainer, const Color(0xffdde1ff));
      expect(scheme.tertiary, const Color(0xff2b6952));
      expect(scheme.tertiaryContainer, const Color(0xffb0f0d2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9ff));
      expect(scheme.surfaceContainer, const Color(0xffeaeefa));
    });

    test(
        'FCS7.024-l-mono: GIVEN a SeedColorScheme.fromSeeds using six seeds '
        'and vibrant content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: Colors.black,
        secondaryKey: secondarySeedColor,
        tertiaryKey: tertiarySeedColor,
        errorKey: errorSeedColor,
        neutralKey: neutralSeedColor,
        neutralVariantKey: neutralVariantSeedColor,
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.vibrant,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff565d7e));
      expect(scheme.secondaryContainer, const Color(0xffdde1ff));
      expect(scheme.tertiary, const Color(0xff2b6952));
      expect(scheme.tertiaryContainer, const Color(0xffb0f0d2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfff9f9ff));
      expect(scheme.surfaceContainer, const Color(0xffeaeefa));
    });

    test(
        'FCS7.024-l-mono: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and vibrant content for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xFFAAAAAA),
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.vibrant,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xFF5E5E5E));
      expect(scheme.secondaryContainer, const Color(0xFFE2E2E2));
      expect(scheme.tertiary, const Color(0xFF5E5E5E));
      expect(scheme.tertiaryContainer, const Color(0xffe2e2e2));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xFFF9F9F9));
      expect(scheme.surfaceContainer, const Color(0xFFEEEEEE));
    });

    test(
        'FCS7.025-l-mono: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and chroma for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xFFAAAAAA),
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.chroma,
      );
      expect(scheme.primary, const Color(0xff5e5e5e));
      expect(scheme.primaryContainer, const Color(0xffc6c6c6));
      expect(scheme.secondary, const Color(0xff777777));
      expect(scheme.secondaryContainer, const Color(0xffe8e8e8));
      expect(scheme.tertiary, const Color(0xff777777));
      expect(scheme.tertiaryContainer, const Color(0xfff1f1f1));
      expect(scheme.error, const Color(0xffba1a1a));
      expect(scheme.errorContainer, const Color(0xffffdad6));
      expect(scheme.surface, const Color(0xfffcfcfc));
      expect(scheme.surfaceContainer, const Color(0xFFEEEEEE));
    });

    test(
        'FCS7.025-d-mono: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and chroma for a light scheme '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: const Color(0xFFAAAAAA),
        respectMonochromeSeed: true,
        variant: FlexSchemeVariant.chroma,
      );
      expect(scheme.primary, const Color(0xffc6c6c6));
      expect(scheme.primaryContainer, const Color(0xff5e5e5e));
      expect(scheme.secondary, const Color(0xffababab));
      expect(scheme.secondaryContainer, const Color(0xff777777));
      expect(scheme.tertiary, const Color(0xffdadada));
      expect(scheme.tertiaryContainer, const Color(0xff474747));
      expect(scheme.error, const Color(0xffffb4ab));
      expect(scheme.errorContainer, const Color(0xff93000a));
      expect(scheme.surface, const Color(0xff0e0e0e));
      expect(scheme.surfaceContainer, const Color(0xff1f1f1f));
    });

    test(
        'FCS7.025-l-mono-2: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and chroma for a light scheme and error mono '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: const Color(0xFFAAAAAA),
        errorKey: const Color(0xFF888888),
        respectMonochromeSeed: true,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.ultraContrast,
      );
      expect(scheme.primary, const Color(0xff303030));
      expect(scheme.primaryContainer, const Color(0xffe2e2e2));
      expect(scheme.secondary, const Color(0xff5e5e5e));
      expect(scheme.secondaryContainer, const Color(0xffe2e2e2));
      expect(scheme.tertiary, const Color(0xff474747));
      expect(scheme.tertiaryContainer, const Color(0xfff1f1f1));
      expect(scheme.error, const Color(0xff5e5e5e));
      expect(scheme.errorContainer, const Color(0xfff1f1f1));
      expect(scheme.surface, const Color(0xffffffff));
      expect(scheme.surfaceContainer, const Color(0xfff3f3f3));
    });

    test(
        'FCS7.025-d-mono-2: GIVEN a SeedColorScheme.fromSeeds using one seed '
        'and chroma for a light scheme and error mono '
        'EXPECT this given checked color result', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: const Color(0xFFAAAAAA),
        errorKey: const Color(0xFF888888),
        respectMonochromeSeed: true,
        useExpressiveOnContainerColors: true,
        variant: FlexSchemeVariant.ultraContrast,
      );
      expect(scheme.primary, const Color(0xffe2e2e2));
      expect(scheme.primaryContainer, const Color(0xff474747));
      expect(scheme.secondary, const Color(0xfff1f1f1));
      expect(scheme.secondaryContainer, const Color(0xff474747));
      expect(scheme.tertiary, const Color(0xfff1f1f1));
      expect(scheme.tertiaryContainer, const Color(0xff474747));
      expect(scheme.error, const Color(0xffc6c6c6));
      expect(scheme.errorContainer, const Color(0xff474747));
      expect(scheme.surface, const Color(0xff070707));
      expect(scheme.surfaceContainer, const Color(0xff1f1f1f));
    });

    test(
        'FCS7.026-l: GIVEN a SeedColorScheme.fromSeeds using primary seed '
        'and variant material3Legacy for a light scheme '
        'EXPECT it to be equal to one made with tone material3Legacy', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        variant: FlexSchemeVariant.material3Legacy,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        tones: FlexTones.material3Legacy(Brightness.light),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.026-d: GIVEN a SeedColorScheme.fromSeeds using primary seed '
        'and variant material3Legacy for a dark scheme '
        'EXPECT it to be equal to one made with tone material3Legacy', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        variant: FlexSchemeVariant.material3Legacy,
      );
      final ColorScheme scheme2 = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        tones: FlexTones.material3Legacy(Brightness.dark),
      );
      expect(scheme, scheme2);
    });

    test(
        'FCS7.027-l: GIVEN a SeedColorScheme.fromSeeds using primary seed '
        'and variant material3Legacy for a light scheme '
        'EXPECT its colors to be equal colors in a scheme made with legacy '
        'MCU Scheme for colors that existed in it', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.light,
        primaryKey: primarySeedColor,
        variant: FlexSchemeVariant.material3Legacy,
      );
      final Scheme scheme2 = Scheme.light(primarySeedColor.value32bit);
      expect(scheme.primary, Color(scheme2.primary));
      expect(scheme.onPrimary, Color(scheme2.onPrimary));
      expect(scheme.primaryContainer, Color(scheme2.primaryContainer));
      expect(scheme.onPrimaryContainer, Color(scheme2.onPrimaryContainer));
      expect(scheme.primaryFixed, Color(scheme2.primaryFixed));
      expect(scheme.primaryFixedDim, Color(scheme2.primaryFixedDim));
      expect(scheme.onPrimaryFixed, Color(scheme2.onPrimaryFixed));
      expect(
          scheme.onPrimaryFixedVariant, Color(scheme2.onPrimaryFixedVariant));
      //
      expect(scheme.secondary, Color(scheme2.secondary));
      expect(scheme.onSecondary, Color(scheme2.onSecondary));
      expect(scheme.secondaryContainer, Color(scheme2.secondaryContainer));
      expect(scheme.onSecondaryContainer, Color(scheme2.onSecondaryContainer));
      expect(scheme.secondaryFixed, Color(scheme2.secondaryFixed));
      expect(scheme.secondaryFixedDim, Color(scheme2.secondaryFixedDim));
      expect(scheme.onSecondaryFixed, Color(scheme2.onSecondaryFixed));
      expect(scheme.onSecondaryFixedVariant,
          Color(scheme2.onSecondaryFixedVariant));
      //
      expect(scheme.tertiary, Color(scheme2.tertiary));
      expect(scheme.onTertiary, Color(scheme2.onTertiary));
      expect(scheme.tertiaryContainer, Color(scheme2.tertiaryContainer));
      expect(scheme.onTertiaryContainer, Color(scheme2.onTertiaryContainer));
      expect(scheme.tertiaryFixed, Color(scheme2.tertiaryFixed));
      expect(scheme.tertiaryFixedDim, Color(scheme2.tertiaryFixedDim));
      expect(scheme.onTertiaryFixed, Color(scheme2.onTertiaryFixed));
      expect(
          scheme.onTertiaryFixedVariant, Color(scheme2.onTertiaryFixedVariant));
      //
      expect(scheme.error, Color(scheme2.error));
      expect(scheme.onError, Color(scheme2.onError));
      expect(scheme.errorContainer, Color(scheme2.errorContainer));
      expect(scheme.onErrorContainer, Color(scheme2.onErrorContainer));
      //
      expect(scheme.outline, Color(scheme2.outline));
      expect(scheme.outlineVariant, Color(scheme2.outlineVariant));
      //
      expect(scheme.surface, Color(scheme2.surface));
      expect(scheme.surfaceDim, Color(scheme2.surfaceDim));
      expect(scheme.surfaceBright, Color(scheme2.surfaceBright));
      expect(
          scheme.surfaceContainerLowest, Color(scheme2.surfaceContainerLowest));
      expect(scheme.surfaceContainerLow, Color(scheme2.surfaceContainerLow));
      expect(scheme.surfaceContainer, Color(scheme2.surfaceContainer));
      expect(scheme.surfaceContainerHigh, Color(scheme2.surfaceContainerHigh));
      expect(scheme.surfaceContainerHighest,
          Color(scheme2.surfaceContainerHighest));
      //
      expect(scheme.onSurface, Color(scheme2.onSurface));
      expect(scheme.onSurfaceVariant, Color(scheme2.onSurfaceVariant));
      expect(scheme.inverseSurface, Color(scheme2.inverseSurface));
      expect(scheme.onInverseSurface, Color(scheme2.inverseOnSurface));
      expect(scheme.inversePrimary, Color(scheme2.inversePrimary));
      //
      expect(scheme.shadow, Color(scheme2.shadow));
      expect(scheme.scrim, Color(scheme2.scrim));
      expect(scheme.surfaceTint, Color(scheme2.primary));
    });

    test(
        'FCS7.027-2: GIVEN a SeedColorScheme.fromSeeds using primary seed '
        'and variant material3Legacy for a dark scheme '
        'EXPECT its colors to be equal colors in a scheme made with legacy '
        'MCU Scheme for colors that existed in it', () {
      final ColorScheme scheme = SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: primarySeedColor,
        variant: FlexSchemeVariant.material3Legacy,
      );
      final Scheme scheme2 = Scheme.dark(primarySeedColor.value32bit);
      expect(scheme.primary, Color(scheme2.primary));
      expect(scheme.onPrimary, Color(scheme2.onPrimary));
      expect(scheme.primaryContainer, Color(scheme2.primaryContainer));
      expect(scheme.onPrimaryContainer, Color(scheme2.onPrimaryContainer));
      expect(scheme.primaryFixed, Color(scheme2.primaryFixed));
      expect(scheme.primaryFixedDim, Color(scheme2.primaryFixedDim));
      expect(scheme.onPrimaryFixed, Color(scheme2.onPrimaryFixed));
      expect(
          scheme.onPrimaryFixedVariant, Color(scheme2.onPrimaryFixedVariant));
      //
      expect(scheme.secondary, Color(scheme2.secondary));
      expect(scheme.onSecondary, Color(scheme2.onSecondary));
      expect(scheme.secondaryContainer, Color(scheme2.secondaryContainer));
      expect(scheme.onSecondaryContainer, Color(scheme2.onSecondaryContainer));
      expect(scheme.secondaryFixed, Color(scheme2.secondaryFixed));
      expect(scheme.secondaryFixedDim, Color(scheme2.secondaryFixedDim));
      expect(scheme.onSecondaryFixed, Color(scheme2.onSecondaryFixed));
      expect(scheme.onSecondaryFixedVariant,
          Color(scheme2.onSecondaryFixedVariant));
      //
      expect(scheme.tertiary, Color(scheme2.tertiary));
      expect(scheme.onTertiary, Color(scheme2.onTertiary));
      expect(scheme.tertiaryContainer, Color(scheme2.tertiaryContainer));
      expect(scheme.onTertiaryContainer, Color(scheme2.onTertiaryContainer));
      expect(scheme.tertiaryFixed, Color(scheme2.tertiaryFixed));
      expect(scheme.tertiaryFixedDim, Color(scheme2.tertiaryFixedDim));
      expect(scheme.onTertiaryFixed, Color(scheme2.onTertiaryFixed));
      expect(
          scheme.onTertiaryFixedVariant, Color(scheme2.onTertiaryFixedVariant));
      //
      expect(scheme.error, Color(scheme2.error));
      expect(scheme.onError, Color(scheme2.onError));
      expect(scheme.errorContainer, Color(scheme2.errorContainer));
      // We can now test this color since we fixed it. MCU has always
      // used the wrong tone here. Whereas FSS has used the one from the spec.
      // It it should be tone 90, original MCU uses 80, which is wrong. Even
      // way back machine on web shows that it was always 90, at least
      // for a few years back. We corrected it in FSS resurrected Scheme.
      expect(scheme.onErrorContainer, Color(scheme2.onErrorContainer));
      //
      expect(scheme.outline, Color(scheme2.outline));
      expect(scheme.outlineVariant, Color(scheme2.outlineVariant));
      //
      expect(scheme.surface, Color(scheme2.surface));
      expect(scheme.surfaceDim, Color(scheme2.surfaceDim));
      expect(scheme.surfaceBright, Color(scheme2.surfaceBright));
      expect(
          scheme.surfaceContainerLowest, Color(scheme2.surfaceContainerLowest));
      expect(scheme.surfaceContainerLow, Color(scheme2.surfaceContainerLow));
      expect(scheme.surfaceContainer, Color(scheme2.surfaceContainer));
      expect(scheme.surfaceContainerHigh, Color(scheme2.surfaceContainerHigh));
      expect(scheme.surfaceContainerHighest,
          Color(scheme2.surfaceContainerHighest));
      //
      expect(scheme.onSurface, Color(scheme2.onSurface));
      expect(scheme.onSurfaceVariant, Color(scheme2.onSurfaceVariant));
      expect(scheme.inverseSurface, Color(scheme2.inverseSurface));
      expect(scheme.onInverseSurface, Color(scheme2.inverseOnSurface));
      expect(scheme.inversePrimary, Color(scheme2.inversePrimary));
      //
      expect(scheme.shadow, Color(scheme2.shadow));
      expect(scheme.scrim, Color(scheme2.scrim));
      expect(scheme.surfaceTint, Color(scheme2.primary));
    });
  });
}
