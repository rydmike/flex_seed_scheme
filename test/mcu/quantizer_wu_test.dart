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

const int red = 0xffff0000;
const int green = 0xff00ff00;
const int blue = 0xff0000ff;
const int blue1 = 0xff0000fe;
const int maxColors = 256;

void main() {
  test('1R', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result = await wu.quantize(<int>[red], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
  });
  test('1Rando', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result =
        await wu.quantize(<int>[0xff141216], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(0xff141216));
  });
  test('1R', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result = await wu.quantize(<int>[red], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(red));
  });
  test('1G', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result = await wu.quantize(<int>[green], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(green));
  });
  test('1B', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result = await wu.quantize(<int>[blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(blue));
  });

  test('5B', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result =
        await wu.quantize(<int>[blue, blue, blue, blue, blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(blue));
  });

  test('2R 3G', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result =
        await wu.quantize(<int>[red, red, green, green, green], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(Set<int>.from(colors).length, equals(2));
    expect(colors[0], green);
    expect(colors[1], red);
  });

  test('1R 1G 1B', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result =
        await wu.quantize(<int>[red, green, blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(Set<int>.from(colors).length, equals(3));
    expect(colors[0], blue);
    expect(colors[1], red);
    expect(colors[2], green);
  });

  //
  // Rydmike coverage tests
  //
  test('1R 1G 4B', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result =
        await wu.quantize(<int>[red, blue, green, blue, blue, blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(Set<int>.from(colors).length, equals(3));
    expect(colors[0], green);
    expect(colors[1], blue);
    expect(colors[2], red);
    //
    expect(
        Box().toString(), equals('Box: R 0 -> 0 G  0 -> 0 B 0 -> 0 VOL = 0'));
  });
  test('1R 1G 4B', () async {
    final QuantizerWu wu = QuantizerWu();
    final QuantizerResult result = await wu.quantize(<int>[
      red,
      blue,
      green,
      blue,
      blue,
      blue,
      blue,
      green,
      green,
      blue1,
      blue1
    ], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(Set<int>.from(colors).length, equals(3));
    expect(colors[0], green);
    expect(colors[1], blue);
    expect(colors[2], red);
    //
  });
}
