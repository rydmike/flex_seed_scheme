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
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.light,
          primaryKey: primarySeedColor,
        ),
        equals(ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: primarySeedColor,
        )),
      );
    });
    test(
        'FCS7.001-d: GIVEN a ColorScheme.fromSeeds using only one seed '
        'EXPECT equal to ColorScheme.fromSeed using same color as key.', () {
      expect(
        SeedColorScheme.fromSeeds(
          brightness: Brightness.dark,
          primaryKey: primarySeedColor,
        ),
        equals(ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: primarySeedColor,
        )),
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.light, primary: Color(0xff6750a4), onPrimary: Color(0xffffffff), primaryContainer: Color(0xffe9ddff), onPrimaryContainer: Color(0xff22005d), secondary: Color(0xff555f71), onSecondary: Color(0xffffffff), secondaryContainer: Color(0xffd9e3f8), onSecondaryContainer: Color(0xff121c2b), tertiary: Color(0xff7e5260), onTertiary: Color(0xffffffff), tertiaryContainer: Color(0xffffd9e3), onTertiaryContainer: Color(0xff31101d), error: Color(0xffba1a1a), onError: Color(0xffffffff), errorContainer: Color(0xffffdad6), onErrorContainer: Color(0xff410002), background: Color(0xfffffbff), onBackground: Color(0xff1c1b1e), surface: Color(0xfffffbff), onSurface: Color(0xff1c1b1e), surfaceVariant: Color(0xffe7e0eb), onSurfaceVariant: Color(0xff49454e), outline: Color(0xff7a757f), outlineVariant: Color(0xffcac4cf), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xff313033), onInverseSurface: Color(0xfff4eff4), inversePrimary: Color(0xffcfbcff), primaryVariant: Color(0xff6750a4), secondaryVariant: Color(0xff555f71), surfaceTint: Color(0xff6750a4))',
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.dark, primary: Color(0xffcfbcff), onPrimary: Color(0xff381e72), primaryContainer: Color(0xff4f378a), onPrimaryContainer: Color(0xffe9ddff), secondary: Color(0xffbdc7dc), onSecondary: Color(0xff273141), secondaryContainer: Color(0xff3d4758), onSecondaryContainer: Color(0xffd9e3f8), tertiary: Color(0xffefb8c8), onTertiary: Color(0xff4a2532), tertiaryContainer: Color(0xff633b48), onTertiaryContainer: Color(0xffffd9e3), error: Color(0xffffb4ab), onError: Color(0xff690005), errorContainer: Color(0xff93000a), onErrorContainer: Color(0xffffb4ab), background: Color(0xff1c1b1e), onBackground: Color(0xffe6e1e6), surface: Color(0xff1c1b1e), onSurface: Color(0xffe6e1e6), surfaceVariant: Color(0xff49454e), onSurfaceVariant: Color(0xffcac4cf), outline: Color(0xff948f99), outlineVariant: Color(0xff49454e), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xffe6e1e6), onInverseSurface: Color(0xff313033), inversePrimary: Color(0xff6750a4), primaryVariant: Color(0xffcfbcff), secondaryVariant: Color(0xffbdc7dc), surfaceTint: Color(0xffcfbcff))',
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.light, primary: Color(0xff6750a4), onPrimary: Color(0xffffffff), primaryContainer: Color(0xffe9ddff), onPrimaryContainer: Color(0xff22005d), secondary: Color(0xff555f71), onSecondary: Color(0xffffffff), secondaryContainer: Color(0xffd9e3f8), onSecondaryContainer: Color(0xff121c2b), tertiary: Color(0xff4f6442), onTertiary: Color(0xffffffff), tertiaryContainer: Color(0xffd1eabe), onTertiaryContainer: Color(0xff0d2005), error: Color(0xffba1a1a), onError: Color(0xffffffff), errorContainer: Color(0xffffdad6), onErrorContainer: Color(0xff410002), background: Color(0xfffffbff), onBackground: Color(0xff1c1b1e), surface: Color(0xfffffbff), onSurface: Color(0xff1c1b1e), surfaceVariant: Color(0xffe7e0eb), onSurfaceVariant: Color(0xff49454e), outline: Color(0xff7a757f), outlineVariant: Color(0xffcac4cf), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xff313033), onInverseSurface: Color(0xfff4eff4), inversePrimary: Color(0xffcfbcff), primaryVariant: Color(0xff6750a4), secondaryVariant: Color(0xff555f71), surfaceTint: Color(0xff6750a4))',
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.dark, primary: Color(0xffcfbcff), onPrimary: Color(0xff381e72), primaryContainer: Color(0xff4f378a), onPrimaryContainer: Color(0xffe9ddff), secondary: Color(0xffbdc7dc), onSecondary: Color(0xff273141), secondaryContainer: Color(0xff3d4758), onSecondaryContainer: Color(0xffd9e3f8), tertiary: Color(0xffb5cea4), onTertiary: Color(0xff223518), tertiaryContainer: Color(0xff384c2c), onTertiaryContainer: Color(0xffd1eabe), error: Color(0xffffb4ab), onError: Color(0xff690005), errorContainer: Color(0xff93000a), onErrorContainer: Color(0xffffb4ab), background: Color(0xff1c1b1e), onBackground: Color(0xffe6e1e6), surface: Color(0xff1c1b1e), onSurface: Color(0xffe6e1e6), surfaceVariant: Color(0xff49454e), onSurfaceVariant: Color(0xffcac4cf), outline: Color(0xff948f99), outlineVariant: Color(0xff49454e), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xffe6e1e6), onInverseSurface: Color(0xff313033), inversePrimary: Color(0xff6750a4), primaryVariant: Color(0xffcfbcff), secondaryVariant: Color(0xffbdc7dc), surfaceTint: Color(0xffcfbcff))',
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.light, primary: Color(0xff3a0a8c), onPrimary: Color(0xffffffff), primaryContainer: Color(0xffe9ddff), onPrimaryContainer: Color(0xff160041), secondary: Color(0xff005eb2), onSecondary: Color(0xffffffff), secondaryContainer: Color(0xffd5e3ff), onSecondaryContainer: Color(0xff001129), tertiary: Color(0xff1b5200), onTertiary: Color(0xffffffff), tertiaryContainer: Color(0xffceffb2), onTertiaryContainer: Color(0xff031500), error: Color(0xffba1a1a), onError: Color(0xffffffff), errorContainer: Color(0xffffedea), onErrorContainer: Color(0xff2d0001), background: Color(0xfffffbff), onBackground: Color(0xff000000), surface: Color(0xfffffbff), onSurface: Color(0xff000000), surfaceVariant: Color(0xfff5eff7), onSurfaceVariant: Color(0xff1d1b20), outline: Color(0xff605d64), outlineVariant: Color(0xffaea9b1), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xff313032), onInverseSurface: Color(0xfffffbff), inversePrimary: Color(0xffe9ddff), primaryVariant: Color(0xff3a0a8c), secondaryVariant: Color(0xff005eb2), surfaceTint: Color(0xff3a0a8c))',
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
          // ignore: lines_longer_than_80_chars
          'ColorScheme#00000(brightness: Brightness.dark, primary: Color(0xffe9ddff), onPrimary: Color(0xff160041), primaryContainer: Color(0xff512da3), onPrimaryContainer: Color(0xfffdf7ff), secondary: Color(0xffebf1ff), onSecondary: Color(0xff001129), secondaryContainer: Color(0xff004788), onSecondaryContainer: Color(0xfff9f9ff), tertiary: Color(0xffceffb2), onTertiary: Color(0xff031500), tertiaryContainer: Color(0xff1b5200), onTertiaryContainer: Color(0xffeeffde), error: Color(0xffffb4ab), onError: Color(0xff2d0001), errorContainer: Color(0xff93000a), onErrorContainer: Color(0xfffff8f7), background: Color(0xff111013), onBackground: Color(0xfffffbff), surface: Color(0xff111013), onSurface: Color(0xfffffbff), surfaceVariant: Color(0xff322f35), onSurfaceVariant: Color(0xfff5eff7), outline: Color(0xffcac5cc), outlineVariant: Color(0xff79767d), shadow: Color(0xff000000), scrim: Color(0xff000000), inverseSurface: Color(0xffe6e1e4), onInverseSurface: Color(0xff1c1b1e), inversePrimary: Color(0xff6948bc), primaryVariant: Color(0xffe9ddff), secondaryVariant: Color(0xffebf1ff), surfaceTint: Color(0xffe9ddff))',
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
      expect(scheme.onSecondary, Colors.white);
      expect(scheme.onSecondaryContainer, Colors.black);
      expect(scheme.onTertiary, Colors.white);
      expect(scheme.onTertiaryContainer, Colors.black);
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
      expect(scheme.onSecondary, Colors.black);
      expect(scheme.onSecondaryContainer, Colors.white);
      expect(scheme.onTertiary, Colors.black);
      expect(scheme.onTertiaryContainer, Colors.white);
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
      expect(scheme.onBackground, Colors.black);
      expect(scheme.onSurface, Colors.black);
      expect(scheme.onSurfaceVariant, Colors.black);
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
      expect(scheme.onBackground, Colors.white);
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
      expect(scheme.background, Colors.white);
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
      expect(scheme.background, Colors.black);
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
        'EXPECT scheme equal to neutral 4 and variant 8', () {
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
          neutralChroma: 4,
          neutralVariantChroma: 8,
        ),
      );
      expect(scheme, scheme2);
    });
    test(
        'FCS7.009-d: GIVEN a SeedColorScheme.fromSeeds using five seeds '
        'and tones map FlexTones.material for a dark scheme with '
        'error no neutral and variant chroma set  '
        'EXPECT scheme equal to neutral 4 and variant 8', () {
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
          neutralChroma: 4,
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
  });
}
