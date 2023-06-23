import 'package:flex_seed_scheme/src/flex/flex_tonal_palette.dart';
import 'package:flex_seed_scheme/src/mcu/palettes/tonal_palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //
  //****************************************************************************
  // FlexTonalPalette unit tests.
  //****************************************************************************
  group('FTP1: WITH FlexTonalPalette ', () {
    test(
        'FTP1.U00: GIVEN the value of commonSize '
        'EXPECT it to be equal to commonTones.length', () {
      expect(
        FlexTonalPalette.commonSize,
        equals(FlexTonalPalette.commonTones.length),
      );
    });

    // m1, is tonal palettes using FlexTonalPalette.
    final FlexTonalPalette m1 = FlexTonalPalette.of(40, 55);
    final FlexTonalPalette m2 = FlexTonalPalette.of(40, 55);
    // m3, is tonal palettes using TonalPalette.
    final TonalPalette m3 = TonalPalette.of(40, 55);
    // m4, is tonal palette from list
    final FlexTonalPalette m4 = FlexTonalPalette.fromList(const <int>[
      4278190080,
      4280616704,
      4281798144,
      4284095488,
      4286524160,
      4288692500,
      4290795563,
      4292964674,
      4294937692,
      4294948249,
      4294958030,
      4294962663,
      4294965494,
      4294966271,
      4294967295,
    ]);
    // m5, is tonal palette from list, same as m4
    final FlexTonalPalette m5 = FlexTonalPalette.fromList(const <int>[
      4278190080,
      4280616704,
      4281798144,
      4284095488,
      4286524160,
      4288692500,
      4290795563,
      4292964674,
      4294937692,
      4294948249,
      4294958030,
      4294962663,
      4294965494,
      4294966271,
      4294967295,
    ]);

    test(
        'FTP1.U01a: GIVEN to identical FlexTonalPalette.of '
        'EXPECT them to be equal', () {
      expect(
        m1,
        equals(m2),
      );
    });
    test(
        'FTP1.U01b: GIVEN two identical FlexTonalPalette.of '
        'EXPECT them to have identity', () {
      expect(identical(m1, m1), true);
    });
    test(
        'FTP1.U01c: GIVEN to identical FlexTonalPalette.of '
        'EXPECT them to have equality with operator', () {
      expect(m1 == m2, true);
    });
    test('FTP1.U01d: Test lexTonalPalette.of hashCode has value.', () {
      expect(m1.hashCode, isNotNull);
    });
    test(
        'FTP1.U02a: GIVEN to identical FlexTonalPalette.fromList '
        'EXPECT them to be equal', () {
      expect(
        m4,
        equals(m5),
      );
    });
    test(
        'FTP1.U02b: GIVEN two identical FlexTonalPalette.fromList '
        'EXPECT them to have identity', () {
      expect(identical(m4, m4), true);
    });
    test(
        'FTP1.U02c: GIVEN to identical FlexTonalPalette.fromList '
        'EXPECT them to have equality with operator', () {
      expect(m4 == m5, true);
    });
    test('FTP1.U02d: Test lexTonalPalette.fromList hashCode has value.', () {
      expect(m4.hashCode, isNotNull);
    });
    test(
        'FTP1.U03: GIVEN to identical FlexTonalPalette '
        'EXPECT their asList to be equal', () {
      expect(
        m1.asList,
        equals(m2.asList),
      );
    });
    test(
        'FTP1.U04: GIVEN a FlexTonalPalette.of(40.0, 55.0) '
        'EXPECT its toString to be "FlexTonalPalette.of(40.0, 55.0)"', () {
      expect(
        m1.toString(),
        equals('FlexTonalPalette.of(40.0, 55.0, FlexPaletteType.common)'),
      );
    });
    test(
        'FTP1.U05: GIVEN same FlexTonalPalette.of and '
        'TonalPalette.of using same input color '
        'EXPECT palette lists to be equal without tone 5 and 98', () {
      // If we remove the tones 5 and 98 that MaterialColorUtilities
      // CorePalette.of does not include, our custom tones list should be equal.
      final List<int> m1List = m1.asList;
      final List<int> m1No5and98List = <int>[];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        if (FlexTonalPalette.commonTones[i] != 5 &&
            FlexTonalPalette.commonTones[i] != 98) {
          m1No5and98List.add(m1List[i]);
        }
      }
      expect(
        m1No5and98List,
        equals(m3.asList),
      );
    });
    test(
        'FTP1.U06: GIVEN to FlexTonalPalette fromList '
        'EXPECT it to be equal to same created with FlexTonalPalette.of', () {
      expect(
        m1,
        equals(m4),
      );
    });
    test(
        'FCP1.U07: GIVEN a FlexTonalPalette.fromList '
        'EXPECT its toString to be "FlexTonalPalette.fromList(...)"', () {
      // ignore: lines_longer_than_80_chars
      expect(
        m4.toString(),
        equals(
            // ignore: lines_longer_than_80_chars
            'FlexTonalPalette.fromList({0: 4278190080, 5: 4280616704, 10: 4281798144, 20: 4284095488, 30: 4286524160, 40: 4288692500, 50: 4290795563, 60: 4292964674, 70: 4294937692, 80: 4294948249, 90: 4294958030, 95: 4294962663, 98: 4294965494, 99: 4294966271, 100: 4294967295}, FlexPaletteType.common)'),
      );
    });
    test(
        'FTP1.U08: GIVEN same FlexTonalPalette.of '
        'EXPECT each of its tones to match output asList via get', () {
      const List<int> m1List = <int>[
        4278190080,
        4280616704,
        4281798144,
        4284095488,
        4286524160,
        4288692500,
        4290795563,
        4292964674,
        4294937692,
        4294948249,
        4294958030,
        4294962663,
        4294965494,
        4294966271,
        4294967295,
      ];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        expect(
          m1.get(FlexTonalPalette.commonTones[i]),
          equals(m1List[i]),
        );
      }
    });
    test(
        'FTP1.U09: GIVEN same FlexTonalPalette.fromList '
        'EXPECT each of its tones to match output asList via get', () {
      const List<int> m5List = <int>[
        4278190080,
        4280616704,
        4281798144,
        4284095488,
        4286524160,
        4288692500,
        4290795563,
        4292964674,
        4294937692,
        4294948249,
        4294958030,
        4294962663,
        4294965494,
        4294966271,
        4294967295,
      ];
      for (int i = 0; i <= FlexTonalPalette.commonTones.length - 1; i++) {
        expect(
          m5.get(FlexTonalPalette.commonTones[i]),
          equals(m5List[i]),
        );
      }
    });
    test(
        'FTP1.U10: GIVEN a FlexTonalPalette.fromList '
        'EXPECT accessing none existing to tone to throw argument error', () {
      expect(
        () => m5.get(7),
        throwsArgumentError,
      );
    });
  });
}
