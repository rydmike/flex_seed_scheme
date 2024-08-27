import 'package:flex_seed_scheme/src/flex/flex_tonal_palette.dart';
import 'package:flex_seed_scheme/src/mcu/hct/hct.dart';
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
            'FlexTonalPalette.fromList([4278190080, 4280616704, 4281798144, 4284095488, 4286524160, 4288692500, 4290795563, 4292964674, 4294937692, 4294948249, 4294958030, 4294962663, 4294965494, 4294966271, 4294967295], FlexPaletteType.common)'),
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
        expect(
          m5.getHct(FlexTonalPalette.commonTones[i].toDouble()).toInt(),
          equals(m5List[i]),
        );
      }
    });
    test(
        'FTP1.U10: GIVEN a FlexTonalPalette.fromList '
        'EXPECT accessing none existing to tone to return a computed implied '
        'tone value', () {
      expect(
        m5.getHct(7).toInt(),
        4281141760,
      );
      expect(
        m5.get(7),
        4281141760,
      );
    });
    //
    //*************************************************************************
    // Extended palette tests
    //*************************************************************************
    //
    group('FTP2: WITH FlexTonalPalette extended palette ', () {
      test(
          'FTP2.U00: GIVEN the value of extendedSize '
          'EXPECT it to be equal to extendedTones.length', () {
        expect(
          FlexTonalPalette.extendedSize,
          equals(FlexTonalPalette.extendedTones.length),
        );
      });

      // m1, is tonal palettes using FlexTonalPalette.
      final FlexTonalPalette m1 =
          FlexTonalPalette.of(40, 55, FlexPaletteType.extended);
      final FlexTonalPalette m2 =
          FlexTonalPalette.of(40, 55, FlexPaletteType.extended);
      // m3, is tonal palettes using TonalPalette.
      final TonalPalette m3 = TonalPalette.of(40, 55);
      // print(m1.asList);
      // m4, is tonal palette from list
      final FlexTonalPalette m4 = FlexTonalPalette.fromList(const <int>[
        4278190080,
        4279567104,
        4280354304,
        4280616704,
        4280879360,
        4281798144,
        4282257664,
        4283373568,
        4284095488,
        4284555008,
        4285014528,
        4286524160,
        4288692500,
        4290795563,
        4292964674,
        4294016333,
        4294937692,
        4294943100,
        4294948249,
        4294952367,
        4294955198,
        4294958030,
        4294959832,
        4294961634,
        4294962663,
        4294963692,
        4294964465,
        4294965494,
        4294966271,
        4294967295,
      ], FlexPaletteType.extended);
      // m5, is tonal palette from list, same as m4
      final FlexTonalPalette m5 = FlexTonalPalette.fromList(const <int>[
        4278190080,
        4279567104,
        4280354304,
        4280616704,
        4280879360,
        4281798144,
        4282257664,
        4283373568,
        4284095488,
        4284555008,
        4285014528,
        4286524160,
        4288692500,
        4290795563,
        4292964674,
        4294016333,
        4294937692,
        4294943100,
        4294948249,
        4294952367,
        4294955198,
        4294958030,
        4294959832,
        4294961634,
        4294962663,
        4294963692,
        4294964465,
        4294965494,
        4294966271,
        4294967295,
      ], FlexPaletteType.extended);

      test(
          'FTP2.U01a: GIVEN to identical FlexTonalPalette.of extended '
          'EXPECT them to be equal', () {
        expect(
          m1,
          equals(m2),
        );
      });
      test(
          'FTP2.U01b: GIVEN two identical FlexTonalPalette.of extended '
          'EXPECT them to have identity', () {
        expect(identical(m1, m1), true);
      });
      test(
          'FTP2.U01c: GIVEN to identical FlexTonalPalette.of extended '
          'EXPECT them to have equality with operator', () {
        expect(m1 == m2, true);
      });
      test('FTP2.U01d: Test lexTonalPalette.of extended hashCode has value.',
          () {
        expect(m1.hashCode, isNotNull);
      });
      test(
          'FTP2.U02a: GIVEN to identical FlexTonalPalette.fromList extended '
          'EXPECT them to be equal', () {
        expect(
          m4,
          equals(m5),
        );
      });
      test(
          'FTP2.U02b: GIVEN two identical FlexTonalPalette.fromList extended '
          'EXPECT them to have identity', () {
        expect(identical(m4, m4), true);
      });
      test(
          'FTP2.U02c: GIVEN to identical FlexTonalPalette.fromList extended '
          'EXPECT them to have equality with operator', () {
        expect(m4 == m5, true);
      });
      test(
          'FTP2.U02d: Test lexTonalPalette.fromList extended '
          'hashCode has value.', () {
        expect(m4.hashCode, isNotNull);
      });
      test(
          'FTP2.U03: GIVEN to identical FlexTonalPalette extended '
          'EXPECT their asList to be equal', () {
        expect(
          m1.asList,
          equals(m2.asList),
        );
      });
      test(
          'FTP2.U04: GIVEN a '
          'FlexTonalPalette.of(40.0, 55.0, FlexPaletteType.extended) '
          'EXPECT its toString to be '
          'FlexTonalPalette.of(40.0, 55.0, FlexPaletteType.extended)', () {
        expect(
          m1.toString(),
          equals('FlexTonalPalette.of(40.0, 55.0, FlexPaletteType.extended)'),
        );
      });
      test(
          'FTP2.U05: GIVEN same FlexTonalPalette.of extended and '
          'TonalPalette.of extendedTones using same input color '
          'EXPECT palette lists to be equal without extended tones', () {
        // If we remove the extended tones that MaterialColorUtilities
        // CorePalette.of does not include, extended tones list should be equal.
        final List<int> m1List = m1.asList;
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
              FlexTonalPalette.extendedTones[i] != 65 &&
              FlexTonalPalette.extendedTones[i] != 75 &&
              FlexTonalPalette.extendedTones[i] != 84 &&
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
          equals(m3.asList),
        );
      });
      test(
          'FTP2.U06: GIVEN to FlexTonalPalette fromList extended '
          'EXPECT it to be equal to same created '
          'with FlexTonalPalette.of extended ', () {
        expect(
          m1,
          equals(m4),
        );
      });
      test(
          'FCP2.U07: GIVEN a FlexTonalPalette.fromList extended '
          'EXPECT its toString to be '
          '"FlexTonalPalette.fromList(...extended)"', () {
        // ignore: lines_longer_than_80_chars
        expect(
          m4.toString(),
          equals(
              // ignore: lines_longer_than_80_chars
              'FlexTonalPalette.fromList([4278190080, 4279567104, 4280354304, 4280616704, 4280879360, 4281798144, 4282257664, 4283373568, 4284095488, 4284555008, 4285014528, 4286524160, 4288692500, 4290795563, 4292964674, 4294016333, 4294937692, 4294943100, 4294948249, 4294952367, 4294955198, 4294958030, 4294959832, 4294961634, 4294962663, 4294963692, 4294964465, 4294965494, 4294966271, 4294967295], FlexPaletteType.extended)'),
        );
      });
      test(
          'FTP2.U08: GIVEN same FlexTonalPalette.of extended '
          'EXPECT each of its tones to match output asList via get', () {
        const List<int> m1List = <int>[
          4278190080,
          4279567104,
          4280354304,
          4280616704,
          4280879360,
          4281798144,
          4282257664,
          4283373568,
          4284095488,
          4284555008,
          4285014528,
          4286524160,
          4288692500,
          4290795563,
          4292964674,
          4294016333,
          4294937692,
          4294943100,
          4294948249,
          4294952367,
          4294955198,
          4294958030,
          4294959832,
          4294961634,
          4294962663,
          4294963692,
          4294964465,
          4294965494,
          4294966271,
          4294967295,
        ];
        for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
          expect(
            m1.get(FlexTonalPalette.extendedTones[i]),
            equals(m1List[i]),
          );
        }
      });
      test(
          'FTP2.U09: GIVEN same FlexTonalPalette.fromList extended '
          'EXPECT each of its tones to match output asList via get', () {
        const List<int> m5List = <int>[
          4278190080,
          4279567104,
          4280354304,
          4280616704,
          4280879360,
          4281798144,
          4282257664,
          4283373568,
          4284095488,
          4284555008,
          4285014528,
          4286524160,
          4288692500,
          4290795563,
          4292964674,
          4294016333,
          4294937692,
          4294943100,
          4294948249,
          4294952367,
          4294955198,
          4294958030,
          4294959832,
          4294961634,
          4294962663,
          4294963692,
          4294964465,
          4294965494,
          4294966271,
          4294967295,
        ];
        for (int i = 0; i <= FlexTonalPalette.extendedTones.length - 1; i++) {
          expect(
            m5.get(FlexTonalPalette.extendedTones[i]),
            equals(m5List[i]),
          );
        }
      });
      test(
          'FTP2.U10: GIVEN a FlexTonalPalette.fromList extended '
          'EXPECT accessing none existing tone to return implied computed '
          'tone value', () {
        expect(
          m5.get(7),
          4281141760,
        );
      });

      ///
      test(
          'FTP1.U11: GIVEN a FlexTonalPalette of and from HCT common tones '
          'EXPECT equal tonal palettes', () {
        final Hct hct = Hct.fromInt(4294961634);
        final FlexTonalPalette tonal = FlexTonalPalette.of(hct.hue, hct.chroma);
        final FlexTonalPalette tonalHct = FlexTonalPalette.fromHct(hct);
        expect(
          tonal,
          tonalHct,
        );
      });
      test(
          'FTP1.U12: GIVEN a FlexTonalPalette of and from HCT extended tones '
          'EXPECT equal tonal palettes', () {
        final Hct hct = Hct.fromInt(4294961634);
        final FlexTonalPalette tonal =
            FlexTonalPalette.of(hct.hue, hct.chroma, FlexPaletteType.extended);
        final FlexTonalPalette tonalHct =
            FlexTonalPalette.fromHct(hct, FlexPaletteType.extended);
        expect(
          tonal,
          tonalHct,
        );
      });
    });
    //
  });
}
