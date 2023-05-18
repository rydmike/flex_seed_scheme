import 'dart:ui';

import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flex_seed_scheme/src/flex/flex_tonal_palette.dart';
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
    //
  });
}
