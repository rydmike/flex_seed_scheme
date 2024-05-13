import 'dart:ui';

import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //
  //****************************************************************************
  // FlexCorePalette unit tests.
  //****************************************************************************
  group('FCP1: WITH FlexCorePalette ', () {
    // m1, is tonal palettes using FlexCorePalette.fromSeeds with one color
    // and M3 based defaults.
    final FlexCorePalette m1 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
    );
    // m2, makes tonal palette using CorePalette.of
    final CorePalette m2 = CorePalette.of(const Color(0xFF6750A4).value);
    // Do identity tests
    test(
        'FCP1.01: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT primary palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.primary.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.primary.asList),
      );
    });
    test(
        'FCP1.02: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT secondary palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.secondary.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.secondary.asList),
      );
    });
    test(
        'FCP1.03: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT tertiary palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.tertiary.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.tertiary.asList),
      );
    });
    test(
        'FCP1.04: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT error palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.error.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.error.asList),
      );
    });
    test(
        'FCP1.05: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT neutral palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.neutral.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.neutral.asList),
      );
    });
    test(
        'FCP1.06: GIVEN same FlexCorePalette.fromSeeds default and '
        'CorePalette.of using same input color '
        'EXPECT neutralVariant palette lists to be equal', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.neutralVariant.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m2.neutralVariant.asList),
      );
    });

    // Use 3 input values
    final FlexCorePalette m3 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondary: const Color(0xFF625B71).value,
      tertiary: const Color(0xFF7D5260).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
    );
    test(
        'FCP1.07: GIVEN FlexCorePalette.fromSeeds with 3 colors and defaults '
        'EXPECT a given list result', () {
      expect(m3.asList(), <int>[
        4278190080,
        4279631937,
        4280418397,
        4281867890,
        4283381642,
        4284960932,
        4286605759,
        4288316379,
        4290158072,
        4291804415,
        4293516799,
        4294373119,
        4294834175,
        4294966271,
        4294967295,
        4278190080,
        4279438880,
        4280162603,
        4281544001,
        4283057240,
        4284636016,
        4286280842,
        4287991204,
        4289767359,
        4291609307,
        4293451512,
        4294372863,
        4294899711,
        4294966271,
        4294967295,
        4278190080,
        4280550930,
        4281405469,
        4283049266,
        4284693320,
        4286468704,
        4288244345,
        4290085778,
        4291993005,
        4293900488,
        4294957539,
        4294962416,
        4294965496,
        4294966271,
        4294967295,
        4278190080,
        4279373844,
        4280032030,
        4281413683,
        4282926666,
        4284505442,
        4286150266,
        4287860628,
        4289637038,
        4291478986,
        4293321190,
        4294242292,
        4294834429,
        4294966271,
        4294967295,
        4278190080,
        4279373847,
        4280097314,
        4281478968,
        4282991950,
        4284570982,
        4286215551,
        4287926169,
        4289702324,
        4291478735,
        4293386475,
        4294307578,
        4294834175,
        4294966271,
        4294967295,
        4278190080,
        4281139201,
        4282449922,
        4285071365,
        4287823882,
        4290386458,
        4292753200,
        4294923337,
        4294936957,
        4294948011,
        4294957782,
        4294962666,
        4294965495,
        4294966271,
        4294967295,
      ]);
    });

    // Use 3 input values and use chroma from secondary and tertiary
    final FlexCorePalette m4 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondary: const Color(0xFF625B71).value,
      tertiary: const Color(0xFF7D5260).value,
      secondaryChroma: null,
      tertiaryChroma: null,
    );
    test(
        'FCP1.08: GIVEN FlexCorePalette.fromSeeds with 3 colors and using '
        'chroma from secondary and tertiary '
        'EXPECT a given result', () {
      expect(
        m4.asList(),
        <int>[
          4278190080,
          4279631937,
          4280418397,
          4281867890,
          4283381642,
          4284960932,
          4286605759,
          4288316379,
          4290158072,
          4291804415,
          4293516799,
          4294373119,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4279438880,
          4280162603,
          4281544001,
          4283056984,
          4284636017,
          4286280586,
          4287991205,
          4289767360,
          4291609308,
          4293451513,
          4294372863,
          4294899711,
          4294966271,
          4294967295,
          4278190080,
          4280550930,
          4281405725,
          4282983730,
          4284693320,
          4286403168,
          4288178809,
          4290020242,
          4291927469,
          4293834952,
          4294957539,
          4294962416,
          4294965496,
          4294966271,
          4294967295,
          4278190080,
          4279373844,
          4280032030,
          4281413683,
          4282926666,
          4284505442,
          4286150266,
          4287860628,
          4289637038,
          4291478986,
          4293321190,
          4294242292,
          4294834429,
          4294966271,
          4294967295,
          4278190080,
          4279373847,
          4280097314,
          4281478968,
          4282991950,
          4284570982,
          4286215551,
          4287926169,
          4289702324,
          4291478735,
          4293386475,
          4294307578,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4281139201,
          4282449922,
          4285071365,
          4287823882,
          4290386458,
          4292753200,
          4294923337,
          4294936957,
          4294948011,
          4294957782,
          4294962666,
          4294965495,
          4294966271,
          4294967295,
        ],
      );
    });
    // m5, is tonal palettes using FlexCorePalette.fromSeeds with one color
    // and default parameters, equal to m1.
    final FlexCorePalette m5 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
    );
    test(
        'FCP1.U01a: GIVEN two identical FlexCorePalette '
        'EXPECT them to be equal', () {
      expect(
        m1,
        equals(m5),
      );
    });
    test(
        'FCP1.U01b: GIVEN two identical FlexCorePalette '
        'EXPECT them to have identity', () {
      expect(identical(m1, m1), true);
    });
    test(
        'FCP1.U01c: GIVEN to identical FlexCorePalette '
        'EXPECT them to have equality with operator', () {
      expect(m1 == m5, true);
    });
    test('FCP1.U01c: Test hashCode has value.', () {
      expect(m1.hashCode, isNotNull);
    });
    test(
        'FCP1.U02: GIVEN to identical FlexCorePalette '
        'EXPECT their asList to be equal', () {
      expect(
        m1.asList(),
        equals(m5.asList()),
      );
    });
    test(
        'FCP1.U03: GIVEN to identical FlexCorePalette '
        'EXPECT their toString to be equal', () {
      expect(
        m1.toString(),
        equals(m5.toString()),
      );
    });
    test(
        'FCP1.U05: GIVEN FlexCorePalette.of() '
        'EXPECT it to be equal to same FlexCorePalette.fromSeed() ', () {
      expect(
        m1,
        equals(FlexCorePalette.of(const Color(0xFF6750A4).value)),
      );
    });
    test(
        'FCP1.U06: GIVEN FlexCorePalette.of() '
        'EXPECT it to be equal to same FlexCorePalette.fromHueChroma() ', () {
      expect(
        FlexCorePalette.fromHueChroma(40, 82),
        equals(
          FlexCorePalette(
            primary: FlexTonalPalette.of(40.0, 82.0),
            secondary: FlexTonalPalette.of(40.0, 16.0),
            tertiary: FlexTonalPalette.of(100.0, 24.0),
            neutral: FlexTonalPalette.of(40.0, 4.0),
            neutralVariant: FlexTonalPalette.of(40.0, 8.0),
          ),
        ),
      );
    });
    test(
        'FCP1.U07: GIVEN a FlexCorePalette from a List '
        'EXPECT it to be equal to one created from same seed Based one', () {
      expect(
        m3,
        equals(FlexCorePalette.fromList(const <int>[
          4278190080,
          4279631937,
          4280418397,
          4281867890,
          4283381642,
          4284960932,
          4286605759,
          4288316379,
          4290158072,
          4291804415,
          4293516799,
          4294373119,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4279438880,
          4280162603,
          4281544001,
          4283057240,
          4284636016,
          4286280842,
          4287991204,
          4289767359,
          4291609307,
          4293451512,
          4294372863,
          4294899711,
          4294966271,
          4294967295,
          4278190080,
          4280550930,
          4281405469,
          4283049266,
          4284693320,
          4286468704,
          4288244345,
          4290085778,
          4291993005,
          4293900488,
          4294957539,
          4294962416,
          4294965496,
          4294966271,
          4294967295,
          4278190080,
          4279373844,
          4280032030,
          4281413683,
          4282926666,
          4284505442,
          4286150266,
          4287860628,
          4289637038,
          4291478986,
          4293321190,
          4294242292,
          4294834429,
          4294966271,
          4294967295,
          4278190080,
          4279373847,
          4280097314,
          4281478968,
          4282991950,
          4284570982,
          4286215551,
          4287926169,
          4289702324,
          4291478735,
          4293386475,
          4294307578,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4281139201,
          4282449922,
          4285071365,
          4287823882,
          4290386458,
          4292753200,
          4294923337,
          4294936957,
          4294948011,
          4294957782,
          4294962666,
          4294965495,
          4294966271,
          4294967295,
        ])),
      );
    });
    // Custom Error tests
    final FlexCorePalette mError01 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
    );
    test('FCP1.Err01: GIVEN no error input EXPECT DEFAULT (25, 84)', () {
      expect(
        mError01.error,
        FlexTonalPalette.of(25, 84),
      );
    });
    final FlexCorePalette mError02 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      errorChroma: 60,
    );
    test('FCP1.Err02: GIVEN error Chroma 60 EXPECT (25, 60)', () {
      expect(
        mError02.error,
        FlexTonalPalette.of(25, 60),
      );
    });
    final FlexCorePalette mError03 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      errorChroma: 62,
      errorMinChroma: 75,
    );
    test('FCP1.Err03: GIVEN error Chroma 62, min 75 EXPECT (25, 75)', () {
      expect(
        mError03.error,
        FlexTonalPalette.of(25, 75),
      );
    });
    final FlexCorePalette mError04 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
    );
    test(
        'FCP1.Err04: GIVEN error Color #CC1839 EXPECT '
        '(17.23982263982711, 87.83137466032304)', () {
      expect(
        mError04.error,
        FlexTonalPalette.of(17.23982263982711, 87.83137466032304),
      );
    });
    final FlexCorePalette mError05 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorChroma: 62,
    );
    test(
        'FCP1.Err05: GIVEN error Color #CC1839, chroma 62 EXPECT '
        '(17.23982263982711, 62)', () {
      expect(
        mError05.error,
        FlexTonalPalette.of(17.23982263982711, 62),
      );
    });
    final FlexCorePalette mError06 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorMinChroma: 82,
    );
    test(
        'FCP1.Err06: GIVEN error Color #CC1839, min chroma 82 EXPECT '
        '(17.23982263982711, 62)', () {
      expect(
        mError06.error,
        FlexTonalPalette.of(17.23982263982711, 87.83137466032304),
      );
    });
    final FlexCorePalette mError07 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorChroma: 62,
    );
    test(
        'FCP1.Err07: GIVEN error Color #CC1839, chroma 62 EXPECT '
        '(17.23982263982711, 62)', () {
      expect(
        mError07.error,
        FlexTonalPalette.of(17.23982263982711, 62),
      );
    });
    final FlexCorePalette mError08 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorChroma: 62,
      errorMinChroma: 45,
    );
    test(
        'FCP1.Err08: GIVEN error Color #CC1839, chroma 62. min 45 EXPECT '
        '(17.23982263982711, 62)', () {
      expect(
        mError08.error,
        FlexTonalPalette.of(17.23982263982711, 62),
      );
    });
    final FlexCorePalette mError09 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorChroma: 62,
      errorMinChroma: 72,
    );
    test(
        'FCP1.Err09: GIVEN error Color #CC1839, chroma 62. min 72 EXPECT '
        '(17.23982263982711, 72)', () {
      expect(
        mError09.error,
        FlexTonalPalette.of(17.23982263982711, 72),
      );
    });
    final FlexCorePalette mError10 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      error: const Color(0xFFCC1839).value,
      errorChroma: 62,
      errorMinChroma: 72,
      useCam16: false,
    );
    test(
        'FCP1.Err109: GIVEN error Color #CC1839, chroma 62. min 72 and '
        'use Cam16 is false EXPECT '
        '(17.23982263982711, 72)', () {
      expect(
        mError10.error,
        FlexTonalPalette.of(17.23982263982711, 72),
      );
    });

    //
  });

  //****************************************************************************
  // FlexCorePalette unit tests with extended list.
  //****************************************************************************
  group('FCP2: WITH FlexCorePalette using extended palette', () {
    // m1, is tonal palettes using FlexCorePalette.fromSeeds with one color
    // and M3 based defaults and extended palette.
    final FlexCorePalette m1 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
      paletteType: FlexPaletteType.extended,
    );
    // m2, makes tonal palette using CorePalette.of and extended palette
    final CorePalette m2 = CorePalette.of(const Color(0xFF6750A4).value);
    // Do identity tests
    test(
        'FCP2.01: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT primary palette lists to be equal without extended tones', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.primary.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.primary.asList),
      );
    });
    test(
        'FCP2.02: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT secondary palette lists to be equal without extended tones',
        () {
      // If we remove the tones that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.secondary.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.secondary.asList),
      );
    });
    test(
        'FCP2.03: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT tertiary palette lists to be equal without extended tones', () {
      // If we remove the tones that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.tertiary.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.tertiary.asList),
      );
    });
    test(
        'FCP2.04: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT error palette lists to be equal without extended tones', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.error.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.error.asList),
      );
    });
    test(
        'FCP2.05: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT neutral palette lists to be equal without extended tones', () {
      // If we remove the tones that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.neutral.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.neutral.asList),
      );
    });
    test(
        'FCP2.06: GIVEN same FlexCorePalette.fromSeeds extended and '
        'CorePalette.of using same input color '
        'EXPECT neutralVariant palette lists equal without extended tones', () {
      // If we remove the tones that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.neutralVariant.asList;
      final List<int> m1NoCustomTonesList = <int>[];
      for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
        if (FlexTonalPalette.extendedTones[i] != 2 &&
            FlexTonalPalette.extendedTones[i] != 4 &&
            FlexTonalPalette.extendedTones[i] != 5 &&
            FlexTonalPalette.extendedTones[i] != 6 &&
            FlexTonalPalette.extendedTones[i] != 12 &&
            FlexTonalPalette.extendedTones[i] != 17 &&
            FlexTonalPalette.extendedTones[i] != 22 &&
            FlexTonalPalette.extendedTones[i] != 24 &&
            FlexTonalPalette.extendedTones[i] != 87 &&
            FlexTonalPalette.extendedTones[i] != 92 &&
            FlexTonalPalette.extendedTones[i] != 94 &&
            FlexTonalPalette.extendedTones[i] != 96 &&
            FlexTonalPalette.extendedTones[i] != 97 &&
            FlexTonalPalette.extendedTones[i] != 98) {
          m1NoCustomTonesList.add(m1List[i]);
        }
      }
      expect(
        m1NoCustomTonesList,
        equals(m2.neutralVariant.asList),
      );
    });
    // Use 3 input values
    final FlexCorePalette m3 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondary: const Color(0xFF625B71).value,
      tertiary: const Color(0xFF7D5260).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
      paletteType: FlexPaletteType.extended,
    );
    test(
        'FCP2.07: GIVEN FlexCorePalette.fromSeeds with 3 colors and extended '
        'EXPECT a given list result', () {
      expect(m3.asList(), <int>[
        4278190080,
        4278845480,
        4279435322,
        4279631937,
        4279828552,
        4280418397,
        4280681825,
        4281407084,
        4281867890,
        4282131319,
        4282460284,
        4283381642,
        4284960932,
        4286605759,
        4288316379,
        4290158072,
        4291804415,
        4292989951,
        4293516799,
        4293846271,
        4294175487,
        4294373119,
        4294504959,
        4294702335,
        4294834175,
        4294966271,
        4294967295,
        4278190080,
        4278781205,
        4279241501,
        4279438880,
        4279570466,
        4280162603,
        4280425775,
        4281149242,
        4281544001,
        4281872965,
        4282136138,
        4283057240,
        4284636016,
        4286280842,
        4287991204,
        4289767359,
        4291609307,
        4292925167,
        4293451512,
        4293846270,
        4294175487,
        4294372863,
        4294504959,
        4294702335,
        4294899711,
        4294966271,
        4294967295,
        4278190080,
        4279697673,
        4280353808,
        4280550930,
        4280748053,
        4281405469,
        4281734177,
        4282523436,
        4283049266,
        4283377974,
        4283706939,
        4284693320,
        4286468704,
        4288244345,
        4290085778,
        4291993005,
        4293900488,
        4294954459,
        4294957539,
        4294959592,
        4294961389,
        4294962416,
        4294963442,
        4294964469,
        4294965496,
        4294966271,
        4294967295,
        4278190080,
        4278716170,
        4279176721,
        4279373844,
        4279505686,
        4280032030,
        4280295202,
        4281018669,
        4281413683,
        4281742392,
        4282005564,
        4282926666,
        4284505442,
        4286150266,
        4287860628,
        4289637038,
        4291478986,
        4292729053,
        4293321190,
        4293715947,
        4294110449,
        4294242292,
        4294439671,
        4294637050,
        4294834429,
        4294966271,
        4294967295,
        4278190080,
        4278715917,
        4279176468,
        4279373847,
        4279505434,
        4280097314,
        4280360486,
        4281018673,
        4281478968,
        4281742140,
        4282071104,
        4282991950,
        4284570982,
        4286215551,
        4287926169,
        4289702324,
        4291478735,
        4292794595,
        4293386475,
        4293715697,
        4294110199,
        4294307578,
        4294504957,
        4294702335,
        4294834175,
        4294966271,
        4294967295,
        4278190080,
        4279894016,
        4280811521,
        4281139201,
        4281401345,
        4282449922,
        4282974210,
        4284219396,
        4285071365,
        4285595653,
        4286119942,
        4287823882,
        4290386458,
        4292753200,
        4294923337,
        4294936957,
        4294948011,
        4294954953,
        4294957782,
        4294959838,
        4294961638,
        4294962666,
        4294963438,
        4294964466,
        4294965495,
        4294966271,
        4294967295,
      ]);
    });

    // Use 3 input values and use chroma from secondary and tertiary
    final FlexCorePalette m4 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondary: const Color(0xFF625B71).value,
      tertiary: const Color(0xFF7D5260).value,
      secondaryChroma: null,
      tertiaryChroma: null,
      paletteType: FlexPaletteType.extended,
    );
    test(
        'FCP2.08: GIVEN FlexCorePalette.fromSeeds with 3 colors and using '
        'chroma from secondary and tertiary and extended palette '
        'EXPECT a given result', () {
      expect(
        m4.asList(),
        <int>[
          4278190080,
          4278845480,
          4279435322,
          4279631937,
          4279828552,
          4280418397,
          4280681825,
          4281407084,
          4281867890,
          4282131319,
          4282460284,
          4283381642,
          4284960932,
          4286605759,
          4288316379,
          4290158072,
          4291804415,
          4292989951,
          4293516799,
          4293846271,
          4294175487,
          4294373119,
          4294504959,
          4294702335,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4278781206,
          4279241501,
          4279438880,
          4279636003,
          4280162603,
          4280425775,
          4281149242,
          4281544001,
          4281872966,
          4282136138,
          4283056984,
          4284636017,
          4286280586,
          4287991205,
          4289767360,
          4291609308,
          4292925168,
          4293451513,
          4293846270,
          4294175487,
          4294372863,
          4294504959,
          4294702335,
          4294899711,
          4294966271,
          4294967295,
          4278190080,
          4279697673,
          4280288272,
          4280550930,
          4280748309,
          4281405725,
          4281734433,
          4282523436,
          4282983730,
          4283312438,
          4283641403,
          4284693320,
          4286403168,
          4288178809,
          4290020242,
          4291927469,
          4293834952,
          4294954459,
          4294957539,
          4294959592,
          4294961389,
          4294962416,
          4294963442,
          4294964469,
          4294965496,
          4294966271,
          4294967295,
          4278190080,
          4278716170,
          4279176721,
          4279373844,
          4279505686,
          4280032030,
          4280295202,
          4281018669,
          4281413683,
          4281742392,
          4282005564,
          4282926666,
          4284505442,
          4286150266,
          4287860628,
          4289637038,
          4291478986,
          4292729053,
          4293321190,
          4293715947,
          4294110449,
          4294242292,
          4294439671,
          4294637050,
          4294834429,
          4294966271,
          4294967295,
          4278190080,
          4278715917,
          4279176468,
          4279373847,
          4279505434,
          4280097314,
          4280360486,
          4281018673,
          4281478968,
          4281742140,
          4282071104,
          4282991950,
          4284570982,
          4286215551,
          4287926169,
          4289702324,
          4291478735,
          4292794595,
          4293386475,
          4293715697,
          4294110199,
          4294307578,
          4294504957,
          4294702335,
          4294834175,
          4294966271,
          4294967295,
          4278190080,
          4279894016,
          4280811521,
          4281139201,
          4281401345,
          4282449922,
          4282974210,
          4284219396,
          4285071365,
          4285595653,
          4286119942,
          4287823882,
          4290386458,
          4292753200,
          4294923337,
          4294936957,
          4294948011,
          4294954953,
          4294957782,
          4294959838,
          4294961638,
          4294962666,
          4294963438,
          4294964466,
          4294965495,
          4294966271,
          4294967295,
        ],
      );
    });
    // m5, is tonal palettes using FlexCorePalette.fromSeeds with one color
    // and extended palette parameters, equal to m1.
    final FlexCorePalette m5 = FlexCorePalette.fromSeeds(
      primary: const Color(0xFF6750A4).value,
      secondaryChroma: 16,
      tertiaryChroma: 24,
      paletteType: FlexPaletteType.extended,
    );
    test(
        'FCP2.U01a: GIVEN two identical FlexCorePalette extended palette '
        'EXPECT them to be equal', () {
      expect(
        m1,
        equals(m5),
      );
    });
    test(
        'FCP2.U01b: GIVEN two identical FlexCorePalette extended palette '
        'EXPECT them to have identity', () {
      expect(identical(m1, m1), true);
    });
    test(
        'FCP2.U01c: GIVEN to identical FlexCorePalette extended palette '
        'EXPECT them to have equality with operator', () {
      expect(m1 == m5, true);
    });
    test('FCP1.U01c: Test hashCode has value.', () {
      expect(m1.hashCode, isNotNull);
    });
    test(
        'FCP2.U02: GIVEN to identical FlexCorePalette extended palette '
        'EXPECT their asList to be equal', () {
      expect(
        m1.asList(),
        equals(m5.asList()),
      );
    });
    test(
        'FCP2.U03: GIVEN to identical FlexCorePalette extended palette '
        'EXPECT their toString to be equal', () {
      expect(
        m1.toString(),
        equals(m5.toString()),
      );
    });
    test(
        'FCP2.U05: GIVEN FlexCorePalette.of() extended palette '
        'EXPECT it to be equal to same FlexCorePalette.fromSeed() '
        'extended palette ', () {
      expect(
        m1,
        equals(FlexCorePalette.of(
            const Color(0xFF6750A4).value, FlexPaletteType.extended)),
      );
    });
    test(
        'FCP2.U06: GIVEN FlexCorePalette.of() extended palette '
        'EXPECT it to be equal to same FlexCorePalette.fromHueChroma() '
        'extended palette ', () {
      expect(
        FlexCorePalette.fromHueChroma(40, 82, FlexPaletteType.extended),
        equals(
          FlexCorePalette(
            primary: FlexTonalPalette.of(40.0, 82.0, FlexPaletteType.extended),
            secondary:
                FlexTonalPalette.of(40.0, 16.0, FlexPaletteType.extended),
            tertiary:
                FlexTonalPalette.of(100.0, 24.0, FlexPaletteType.extended),
            neutral: FlexTonalPalette.of(40.0, 4.0, FlexPaletteType.extended),
            neutralVariant:
                FlexTonalPalette.of(40.0, 8.0, FlexPaletteType.extended),
            error: FlexTonalPalette.of(25, 84, FlexPaletteType.extended),
          ),
        ),
      );
    });
    test(
        'FCP1.U07: GIVEN a FlexCorePalette from a extended List '
        'EXPECT it to be equal to one created from same seed Based '
        'extended one', () {
      expect(
        m3,
        equals(
          FlexCorePalette.fromList(const <int>[
            4278190080,
            4278845480,
            4279435322,
            4279631937,
            4279828552,
            4280418397,
            4280681825,
            4281407084,
            4281867890,
            4282131319,
            4282460284,
            4283381642,
            4284960932,
            4286605759,
            4288316379,
            4290158072,
            4291804415,
            4292989951,
            4293516799,
            4293846271,
            4294175487,
            4294373119,
            4294504959,
            4294702335,
            4294834175,
            4294966271,
            4294967295,
            4278190080,
            4278781205,
            4279241501,
            4279438880,
            4279570466,
            4280162603,
            4280425775,
            4281149242,
            4281544001,
            4281872965,
            4282136138,
            4283057240,
            4284636016,
            4286280842,
            4287991204,
            4289767359,
            4291609307,
            4292925167,
            4293451512,
            4293846270,
            4294175487,
            4294372863,
            4294504959,
            4294702335,
            4294899711,
            4294966271,
            4294967295,
            4278190080,
            4279697673,
            4280353808,
            4280550930,
            4280748053,
            4281405469,
            4281734177,
            4282523436,
            4283049266,
            4283377974,
            4283706939,
            4284693320,
            4286468704,
            4288244345,
            4290085778,
            4291993005,
            4293900488,
            4294954459,
            4294957539,
            4294959592,
            4294961389,
            4294962416,
            4294963442,
            4294964469,
            4294965496,
            4294966271,
            4294967295,
            4278190080,
            4278716170,
            4279176721,
            4279373844,
            4279505686,
            4280032030,
            4280295202,
            4281018669,
            4281413683,
            4281742392,
            4282005564,
            4282926666,
            4284505442,
            4286150266,
            4287860628,
            4289637038,
            4291478986,
            4292729053,
            4293321190,
            4293715947,
            4294110449,
            4294242292,
            4294439671,
            4294637050,
            4294834429,
            4294966271,
            4294967295,
            4278190080,
            4278715917,
            4279176468,
            4279373847,
            4279505434,
            4280097314,
            4280360486,
            4281018673,
            4281478968,
            4281742140,
            4282071104,
            4282991950,
            4284570982,
            4286215551,
            4287926169,
            4289702324,
            4291478735,
            4292794595,
            4293386475,
            4293715697,
            4294110199,
            4294307578,
            4294504957,
            4294702335,
            4294834175,
            4294966271,
            4294967295,
            4278190080,
            4279894016,
            4280811521,
            4281139201,
            4281401345,
            4282449922,
            4282974210,
            4284219396,
            4285071365,
            4285595653,
            4286119942,
            4287823882,
            4290386458,
            4292753200,
            4294923337,
            4294936957,
            4294948011,
            4294954953,
            4294957782,
            4294959838,
            4294961638,
            4294962666,
            4294963438,
            4294964466,
            4294965495,
            4294966271,
            4294967295,
          ], FlexPaletteType.extended),
        ),
      );
    });
    //
  });
}
