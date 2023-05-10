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

import './utils/color_matcher.dart';

void main() {
  test('prioritizes chroma when proportions equal', () async {
    final Map<int, int> colorsToPopulation = <int, int>{
      0xffff0000: 1,
      0xff00ff00: 1,
      0xff0000ff: 1
    };
    final List<int> ranked = Score.score(colorsToPopulation, desired: 4);

    expect(ranked[0], isColor(0xffff0000));
    expect(ranked[1], isColor(0xff00ff00));
    expect(ranked[2], isColor(0xff0000ff));
  });

  test('generates gBlue when no colors available', () async {
    final Map<int, int> colorsToPopulation = <int, int>{0xff000000: 1};
    final List<int> ranked = Score.score(colorsToPopulation, desired: 4);

    expect(ranked[0], isColor(0xff4285F4));
  });

  test('dedupes nearby hues', () async {
    final Map<int, int> colorsToPopulation = <int, int>{
      0xff008772: 1, // H 180 C 42 T 50
      0xff318477: 1 // H 184 C 35 T 50
    };
    final List<int> ranked = Score.score(colorsToPopulation, desired: 4);

    expect(ranked.length, equals(1));
    expect(ranked[0], isColor(0xff008772));
  });

  test('maximizes hue distance', () async {
    final Map<int, int> colorsToPopulation = <int, int>{
      0xff008772: 1, // H 180 C 42 T 50
      0xff008587: 1, // H 198 C 50 T 50
      0xff007EBC: 1 // H 245 C 50 T 50
    };
    final List<int> ranked = Score.score(colorsToPopulation, desired: 2);
    expect(ranked.length, equals(2));
    expect(ranked[0], isColor(0xff007EBC));
    expect(ranked[1], isColor(0xff008772));
  });

  //
  // Rydmike extra coverage tests
  //
  test('prioritizes chroma when proportions equal', () async {
    final Map<int, int> colorsToPopulation = <int, int>{
      0xffff0000: 1,
      0xff00ff00: 1,
      0xff0000ff: 1
    };
    final List<int> ranked = Score.score(
      colorsToPopulation,
      desired: 4,
      filter: false,
    );

    expect(ranked[0], isColor(0xffff0000));
    expect(ranked[1], isColor(0xff00ff00));
    expect(ranked[2], isColor(0xff0000ff));
  });
  test('prioritizes highest count', () async {
    final Map<int, int> colorsToPopulation = <int, int>{
      0xffff0000: 1,
      0xff00ff00: 8,
      0xff0000ff: 5,
      0xff00aaff: 5,
      0xffffffff: 1,
      0xfffffffe: 1,
      0xff000000: 1,
      0xff000001: 1,
    };
    final List<int> ranked = Score.score(
      colorsToPopulation,
      desired: 4,
      filter: true,
    );
    expect(ranked[0], isColor(0xff00ff00));
    expect(ranked[1], isColor(0xff0000ff));
    expect(ranked[2], isColor(0xffff0000));
    expect(ranked[3], isColor(0xff00aaff));
  });

  test('argbToProportion', () {
    final Map<int, int> argbToCount = <int, int>{
      0xffff0000: 10,
      0xff00ff00: 75,
      0xff0000ff: 15,
    };
    expect(
        Score.argbToProportion(argbToCount),
        equals(<int, double>{
          4294901760: 0.1,
          4278255360: 0.75,
          4278190335: 0.15
        }));
  });
}
