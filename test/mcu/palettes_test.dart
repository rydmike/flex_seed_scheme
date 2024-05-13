// Copyright 2021 Google LLC
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

void main() {
  group('TonalPalette', () {
    group('[.of and .fromList constructors]', () {
      // Regression test for
      // https://github.com/material-foundation/material-color-utilities/issues/56
      test('operator ==', () {
        final TonalPalette a1 = TonalPalette.of(1, 1);
        final TonalPalette a2 = TonalPalette.of(1, 1);
        final TonalPalette b1 = TonalPalette.fromList(
            TonalPalette.commonTones.map((int e) => 0xDEADBEEF).toList());
        final TonalPalette b2 = TonalPalette.fromList(
            TonalPalette.commonTones.map((int e) => 0xDEADBEEF).toList());
        expect(a1 == b1, isFalse);
        expect(b1 == a1, isFalse);
        expect(a1 != b1, isTrue);
        expect(b1 != a1, isTrue);
        expect(a1 == a2, isTrue);
        expect(b1 == b2, isTrue);

        final TonalPalette c1 = TonalPalette.fromList(
            TonalPalette.commonTones.map((int e) => 123).toList());

        final TonalPalette c2 = TonalPalette.fromList(TonalPalette.commonTones
            .map((int e) => e < 15 ? 456 : 123)
            .toList());

        expect(c1.get(50), c2.get(50));
        expect(c1 == c2, isFalse);

        // Rydmike - toString test
        expect(
          a1.toString(),
          equals('TonalPalette.of(1.0, 1.0)'),
        );
        expect(
          c1.toString(),
          equals(
            'TonalPalette.fromList([123, 123, 123, 123, 123, 123, '
            '123, 123, 123, 123, 123, 123, 123])',
          ),
        );
      });
    });

    group('[.of constructor]', () {
      test('tones of blue', () async {
        final Hct hct = Hct.fromInt(0xff0000ff);
        final TonalPalette tones = TonalPalette.of(hct.hue, hct.chroma);

        expect(tones.get(0), 0xff000000);
        expect(tones.get(10), 0xff00006e);
        expect(tones.get(20), 0xff0001ac);
        expect(tones.get(30), 0xff0000ef);
        expect(tones.get(40), 0xff343dff);
        expect(tones.get(50), 0xff5a64ff);
        expect(tones.get(60), 0xff7c84ff);
        expect(tones.get(70), 0xff9da3ff);
        expect(tones.get(80), 0xffbec2ff);
        expect(tones.get(90), 0xffe0e0ff);
        expect(tones.get(95), 0xfff1efff);
        expect(tones.get(99), 0xfffffbff);
        expect(tones.get(100), 0xffffffff);

        // Tone not in [TonalPalette.commonTones]
        expect(tones.get(3), 0xff00003c);

        // RydMike Extra tests
        //
        // Verify example HCT tones
        expect(tones.getHct(0), Hct.from(0, 0, 0));
        expect(tones.getHct(100), Hct.from(0, 0, 100));
      });

      test('asList', () {
        final Hct hct = Hct.fromInt(0xff0000ff);
        final TonalPalette tones = TonalPalette.of(hct.hue, hct.chroma);

        expect(tones.asList, <int>[
          0xff000000,
          0xff00006e,
          0xff0001ac,
          0xff0000ef,
          0xff343dff,
          0xff5a64ff,
          0xff7c84ff,
          0xff9da3ff,
          0xffbec2ff,
          0xffe0e0ff,
          0xfff1efff,
          0xfffffbff,
          0xffffffff,
        ]);
      });

      test('operator == and hashCode', () {
        final Hct hctAB = Hct.fromInt(0xff0000ff);
        final TonalPalette tonesA = TonalPalette.of(hctAB.hue, hctAB.chroma);
        final TonalPalette tonesB = TonalPalette.of(hctAB.hue, hctAB.chroma);
        final Hct hctC = Hct.fromInt(0xff123456);
        final TonalPalette tonesC = TonalPalette.of(hctC.hue, hctC.chroma);

        expect(tonesA, tonesB);
        expect(tonesB, isNot(tonesC));

        expect(tonesA.hashCode, tonesB.hashCode);
        expect(tonesB.hashCode, isNot(tonesC.hashCode));
      });
    });

    group('[.fromList constructor]', () {
      test('tones of i', () async {
        final List<int> ints =
            List<int>.generate(TonalPalette.commonSize, (int i) => i);
        final TonalPalette tones = TonalPalette.fromList(ints);

        expect(tones.get(100), 12);
        expect(tones.get(99), 11);
        expect(tones.get(95), 10);
        expect(tones.get(90), 9);
        expect(tones.get(80), 8);
        expect(tones.get(70), 7);
        expect(tones.get(60), 6);
        expect(tones.get(50), 5);
        expect(tones.get(40), 4);
        expect(tones.get(30), 3);
        expect(tones.get(20), 2);
        expect(tones.get(10), 1);
        expect(tones.get(0), 0);

        /// Tone not in [TonalPalette.commonTones]
        /// Before version 2.0.0 this would have thrown an exception.
        /// but now we can get any tone.
        expect(tones.get(3), 4278716699);

        // RydMike Extra tests
        //
        // Verify example HCT tones.
        expect(tones.getHct(0).toInt(), 0);
        expect(tones.getHct(10).toInt(), 1);
        expect(tones.getHct(20).toInt(), 2);
        expect(tones.getHct(30).toInt(), 3);
        expect(tones.getHct(40).toInt(), 4);
        expect(tones.getHct(50).toInt(), 5);
        expect(tones.getHct(60).toInt(), 6);
        expect(tones.getHct(70).toInt(), 7);
        expect(tones.getHct(80).toInt(), 8);
        expect(tones.getHct(90).toInt(), 9);
        expect(tones.getHct(95).toInt(), 10);
        expect(tones.getHct(99).toInt(), 11);
        expect(tones.getHct(100).toInt(), 12);

        /// Tone not in [TonalPalette.commonTones]
        /// Before version 2.0.0 this would have thrown an exception.
        /// but now we can get any tone.
        expect(tones.getHct(3).toInt(), 4278716699);
        expect(tones.get(3), 4278716699);
      });

      test('asList', () {
        final List<int> ints =
            List<int>.generate(TonalPalette.commonSize, (int i) => i);
        final TonalPalette tones = TonalPalette.fromList(ints);
        expect(tones.asList, ints);
      });

      test('operator == and hashCode', () {
        final List<int> intsAB =
            List<int>.generate(TonalPalette.commonSize, (int i) => i);
        final TonalPalette tonesA = TonalPalette.fromList(intsAB);
        final TonalPalette tonesB = TonalPalette.fromList(intsAB);
        final List<int> intsC =
            List<int>.generate(TonalPalette.commonSize, (int i) => 1);
        final TonalPalette tonesC = TonalPalette.fromList(intsC);

        expect(tonesA, tonesB);
        expect(tonesB, isNot(tonesC));

        expect(tonesA.hashCode, tonesB.hashCode);
        expect(tonesB.hashCode, isNot(tonesC.hashCode));
      });
    });
  });

  group('CorePalette', () {
    test('asList', () {
      final List<int> ints = List<int>.generate(
          CorePalette.size * TonalPalette.commonSize, (int i) => i);
      final CorePalette corePalette = CorePalette.fromList(ints);
      expect(corePalette.asList(), ints);
    });

    test('operator == and hashCode', () {
      final CorePalette corePaletteA = CorePalette.of(0xff0000ff);
      final CorePalette corePaletteB = CorePalette.of(0xff0000ff);
      final CorePalette corePaletteC = CorePalette.of(0xff123456);

      expect(corePaletteA, corePaletteB);
      expect(corePaletteB, isNot(corePaletteC));

      expect(corePaletteA.hashCode, corePaletteB.hashCode);
      expect(corePaletteB.hashCode, isNot(corePaletteC.hashCode));
    });

    test('of blue', () {
      final CorePalette core = CorePalette.of(0xff0000ff);

      expect(core.primary.get(100), 0xffffffff);
      expect(core.primary.get(95), 0xfff1efff);
      expect(core.primary.get(90), 0xffe0e0ff);
      expect(core.primary.get(80), 0xffbec2ff);
      expect(core.primary.get(70), 0xff9da3ff);
      expect(core.primary.get(60), 0xff7c84ff);
      expect(core.primary.get(50), 0xff5a64ff);
      expect(core.primary.get(40), 0xff343dff);
      expect(core.primary.get(30), 0xff0000ef);
      expect(core.primary.get(20), 0xff0001ac);
      expect(core.primary.get(10), 0xff00006e);
      expect(core.primary.get(0), 0xff000000);
      expect(core.secondary.get(100), 0xffffffff);
      expect(core.secondary.get(95), 0xfff1efff);
      expect(core.secondary.get(90), 0xffe1e0f9);
      expect(core.secondary.get(80), 0xffc5c4dd);
      expect(core.secondary.get(70), 0xffa9a9c1);
      expect(core.secondary.get(60), 0xff8f8fa6);
      expect(core.secondary.get(50), 0xff75758b);
      expect(core.secondary.get(40), 0xff5c5d72);
      expect(core.secondary.get(30), 0xff444559);
      expect(core.secondary.get(20), 0xff2e2f42);
      expect(core.secondary.get(10), 0xff191a2c);
      expect(core.secondary.get(0), 0xff000000);

      expect(
          core.toString(),
          'primary: TonalPalette.of(282.78817956187277, 87.23069368032536)\n'
          'secondary: TonalPalette.of(282.78817956187277, 16.0)\n'
          'tertiary: TonalPalette.of(342.78817956187277, 24.0)\n'
          'neutral: TonalPalette.of(282.78817956187277, 4.0)\n'
          'neutralVariant: TonalPalette.of(282.78817956187277, 8.0)\n'
          'error: TonalPalette.of(25.0, 84.0)\n');
    });

    test('content of blue', () {
      final CorePalette core = CorePalette.contentOf(0xff0000ff);

      expect(core.primary.get(100), 0xffffffff);
      expect(core.primary.get(95), 0xfff1efff);
      expect(core.primary.get(90), 0xffe0e0ff);
      expect(core.primary.get(80), 0xffbec2ff);
      expect(core.primary.get(70), 0xff9da3ff);
      expect(core.primary.get(60), 0xff7c84ff);
      expect(core.primary.get(50), 0xff5a64ff);
      expect(core.primary.get(40), 0xff343dff);
      expect(core.primary.get(30), 0xff0000ef);
      expect(core.primary.get(20), 0xff0001ac);
      expect(core.primary.get(10), 0xff00006e);
      expect(core.primary.get(0), 0xff000000);
      expect(core.secondary.get(100), 0xffffffff);
      expect(core.secondary.get(95), 0xfff1efff);
      expect(core.secondary.get(90), 0xffe0e0ff);
      expect(core.secondary.get(80), 0xffc1c3f4);
      expect(core.secondary.get(70), 0xffa5a7d7);
      expect(core.secondary.get(60), 0xff8b8dbb);
      expect(core.secondary.get(50), 0xff7173a0);
      expect(core.secondary.get(40), 0xff585b86);
      expect(core.secondary.get(30), 0xff40436d);
      expect(core.secondary.get(20), 0xff2a2d55);
      expect(core.secondary.get(10), 0xff14173f);
      expect(core.secondary.get(0), 0xff000000);
    });
  });
}
