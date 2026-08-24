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

import 'utils/color_matcher.dart';

void main() {
  group(TemperatureCache, () {
    test('raw temperature', () {
      final double blueTemp = TemperatureCache.rawTemperature(Hct.fromInt(0xff0000ff));
      expect(blueTemp, closeTo(-1.393, 0.001));

      final double redTemp = TemperatureCache.rawTemperature(Hct.fromInt(0xffff0000));
      expect(redTemp, closeTo(2.351, 0.001));

      final double greenTemp = TemperatureCache.rawTemperature(Hct.fromInt(0xff00ff00));
      expect(greenTemp, closeTo(-0.267, 0.001));

      final double whiteTemp = TemperatureCache.rawTemperature(Hct.fromInt(0xffffffff));
      expect(whiteTemp, closeTo(-0.5, 0.001));

      final double blackTemp = TemperatureCache.rawTemperature(Hct.fromInt(0xff000000));
      expect(blackTemp, closeTo(-0.5, 0.001));
    });

    test('relative temperature', () {
      final double blueTemp = TemperatureCache(Hct.fromInt(0xff0000ff)).inputRelativeTemperature;
      expect(blueTemp, closeTo(0.0, 0.001));

      final double redTemp = TemperatureCache(Hct.fromInt(0xffff0000)).inputRelativeTemperature;
      expect(redTemp, closeTo(1.0, 0.001));

      final double greenTemp = TemperatureCache(Hct.fromInt(0xff00ff00)).inputRelativeTemperature;
      expect(greenTemp, closeTo(0.467, 0.001));

      final double whiteTemp = TemperatureCache(Hct.fromInt(0xffffffff)).inputRelativeTemperature;
      expect(whiteTemp, closeTo(0.5, 0.001));

      final double blackTemp = TemperatureCache(Hct.fromInt(0xff000000)).inputRelativeTemperature;
      expect(blackTemp, closeTo(0.5, 0.001));
    });

    test('complement', () {
      final int blueComplement = TemperatureCache(Hct.fromInt(0xff0000ff)).complement.toInt();
      expect(blueComplement, isColor(0xff9D0002));

      final int redComplement = TemperatureCache(Hct.fromInt(0xffff0000)).complement.toInt();
      expect(redComplement, isColor(0xff007BFC));

      final int greenComplement = TemperatureCache(Hct.fromInt(0xff00ff00)).complement.toInt();
      expect(greenComplement, isColor(0xffFFD2C9));

      final int whiteComplement = TemperatureCache(Hct.fromInt(0xffffffff)).complement.toInt();
      expect(whiteComplement, isColor(0xffffffff));

      final int blackComplement = TemperatureCache(Hct.fromInt(0xff000000)).complement.toInt();
      expect(blackComplement, isColor(0xff000000));

      // Make another whiteComplement2 to hit cache.
      final int whiteComplement2 = TemperatureCache(Hct.fromInt(0xffffffff)).complement.toInt();
      expect(whiteComplement2, isColor(0xffffffff));
    });

    test('analogous', () {
      final List<int> blueAnalogous = TemperatureCache(
        Hct.fromInt(0xff0000ff),
      ).analogous().map((Hct e) => e.toInt()).toList();
      expect(blueAnalogous[0], isColor(0xff00590C));
      expect(blueAnalogous[1], isColor(0xff00564E));
      expect(blueAnalogous[2], isColor(0xff0000ff));
      expect(blueAnalogous[3], isColor(0xff6700CC));
      expect(blueAnalogous[4], isColor(0xff81009F));

      final List<int> redAnalogous = TemperatureCache(
        Hct.fromInt(0xffff0000),
      ).analogous().map((Hct e) => e.toInt()).toList();
      expect(redAnalogous[0], isColor(0xffF60082));
      expect(redAnalogous[1], isColor(0xffFC004C));
      expect(redAnalogous[2], isColor(0xffff0000));
      expect(redAnalogous[3], isColor(0xffD95500));
      expect(redAnalogous[4], isColor(0xffAF7200));

      final List<int> greenAnalogous = TemperatureCache(
        Hct.fromInt(0xff00ff00),
      ).analogous().map((Hct e) => e.toInt()).toList();
      expect(greenAnalogous[0], isColor(0xffCEE900));
      expect(greenAnalogous[1], isColor(0xff92F500));
      expect(greenAnalogous[2], isColor(0xff00ff00));
      expect(greenAnalogous[3], isColor(0xff00FD6F));
      expect(greenAnalogous[4], isColor(0xff00FAB3));

      final List<int> blackAnalogous = TemperatureCache(
        Hct.fromInt(0xff000000),
      ).analogous().map((Hct e) => e.toInt()).toList();
      expect(blackAnalogous[0], isColor(0xff000000));
      expect(blackAnalogous[1], isColor(0xff000000));
      expect(blackAnalogous[2], isColor(0xff000000));
      expect(blackAnalogous[3], isColor(0xff000000));
      expect(blackAnalogous[4], isColor(0xff000000));

      final List<int> whiteAnalogous = TemperatureCache(
        Hct.fromInt(0xffffffff),
      ).analogous().map((Hct e) => e.toInt()).toList();
      expect(whiteAnalogous[0], isColor(0xffffffff));
      expect(whiteAnalogous[1], isColor(0xffffffff));
      expect(whiteAnalogous[2], isColor(0xffffffff));
      expect(whiteAnalogous[3], isColor(0xffffffff));
      expect(whiteAnalogous[4], isColor(0xffffffff));
    });

    // Extra tests below not covered by MCU upstream.
    test('analogous with more divisions than the 360 hue steps pads the '
        'division list and still returns the requested count', () {
      final List<Hct> result = TemperatureCache(
        Hct.fromInt(0xff0000ff),
      ).analogous(count: 5, divisions: 400);
      expect(result, hasLength(5));
    });
    test('analogous with divisions larger than the 360 hue walk completes '
        'via the hue walk exit for various inputs', () {
      for (final List<int> config in <List<int>>[
        <int>[0xffff0000, 999],
        <int>[0xff808082, 1000],
        <int>[0xff123456, 725],
        <int>[0xff0000ff, 363],
        <int>[0xff804040, 500],
      ]) {
        final List<Hct> result = TemperatureCache(
          Hct.fromInt(config[0]),
        ).analogous(count: 3, divisions: config[1]);
        expect(result, hasLength(3));
      }
    });
    test('analogous with a count larger than divisions wraps around the '
        'division list and returns the requested count', () {
      final List<Hct> result = TemperatureCache(
        Hct.fromInt(0xff0000ff),
      ).analogous(count: 8, divisions: 3);
      expect(result, hasLength(8));
      // The input color is always included in the answers.
      expect(result.map((Hct h) => h.toInt()), contains(0xff0000ff));
    });
    test('complement and inputRelativeTemperature return cached values on '
        'repeated calls', () {
      final TemperatureCache cache = TemperatureCache(Hct.fromInt(0xff0000ff));
      final Hct first = cache.complement;
      final Hct second = cache.complement;
      expect(first.toInt(), isColor(0xff9d0002));
      expect(identical(first, second), true);
      final double rel1 = cache.inputRelativeTemperature;
      final double rel2 = cache.inputRelativeTemperature;
      // Blue is the coldest color, its relative temperature is 0.
      expect(rel1, 0.0);
      expect(rel2, rel1);
    });
  });
}
