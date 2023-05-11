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
const int random = 0xff426088;
const int maxColors = 256;

void main() {
  test('1Rando', () {
    final QuantizerResult result =
        QuantizerWsmeans.quantize(<int>[0xff141216], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(0xff141216));
  });

  test('1R', () {
    final QuantizerResult result =
        QuantizerWsmeans.quantize(<int>[red], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
  });
  test('1R', () {
    final QuantizerResult result =
        QuantizerWsmeans.quantize(<int>[red], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(red));
  });
  test('1G', () {
    final QuantizerResult result =
        QuantizerWsmeans.quantize(<int>[green], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(green));
  });
  test('1B', () {
    final QuantizerResult result =
        QuantizerWsmeans.quantize(<int>[blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(blue));
  });

  test('5B', () {
    final QuantizerResult result = QuantizerWsmeans.quantize(
        <int>[blue, blue, blue, blue, blue], maxColors);
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(1));
    expect(colors[0], equals(blue));
  });

  //
  // Rydmike coverage addition,
  //
  test('Mixed 1, with pixels print', () {
    final QuantizerResult result = QuantizerWsmeans.quantize(
      <int>[blue, blue, blue, blue, blue, red, red, green, random],
      maxColors,
      returnInputPixelToClusterPixel: true,
    );
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(4));
    expect(colors[0], equals(red));
  });
  test('Mixed 2, with pixels print', () {
    final QuantizerResult result = QuantizerWsmeans.quantize(
      <int>[
        blue,
        blue,
        blue,
        blue,
        blue,
        red,
        blue1,
        blue1,
        red,
        green,
        random
      ],
      maxColors,
      returnInputPixelToClusterPixel: true,
    );
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(5));
    expect(colors[0], equals(green));
  });
  test('Mixed 3, with pixels print', () {
    final QuantizerResult result = QuantizerWsmeans.quantize(
      <int>[],
      maxColors,
      returnInputPixelToClusterPixel: true,
    );
    final List<int> colors = result.colorToCount.keys.toList();
    expect(colors.length, equals(0));
    expect(colors.isEmpty, equals(true));
  });
}
