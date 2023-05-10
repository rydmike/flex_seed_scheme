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

const int red = 0xffff0000;
const int blue = 0xff0000ff;
const int green = 0xff00ff00;
const int yellow = 0xffffff00;
void main() {
  group('Harmonize', () {
    test('redToBlue', () {
      final int answer = Blend.harmonize(red, blue);
      expect(answer, isColor(0xffFB0057));
    });

    test('redToGreen', () {
      final int answer = Blend.harmonize(red, green);
      expect(answer, isColor(0xffD85600));
    });

    test('redToYellow', () {
      final int answer = Blend.harmonize(red, yellow);
      expect(answer, isColor(0xffD85600));
    });

    test('blueToGreen', () {
      final int answer = Blend.harmonize(blue, green);
      expect(answer, isColor(0xff0047A3));
    });

    test('blueToRed', () {
      final int answer = Blend.harmonize(blue, red);
      expect(answer, isColor(0xff5700DC));
    });

    test('blueToYellow', () {
      final int answer = Blend.harmonize(blue, yellow);
      expect(answer, isColor(0xff0047A3));
    });

    test('greenToBlue', () {
      final int answer = Blend.harmonize(green, blue);
      expect(answer, isColor(0xff00FC94));
    });

    test('greenToRed', () {
      final int answer = Blend.harmonize(green, red);
      expect(answer, isColor(0xffB1F000));
    });

    test('greenToYellow', () {
      final int answer = Blend.harmonize(green, yellow);
      expect(answer, isColor(0xffB1F000));
    });

    test('yellowToBlue', () {
      final int answer = Blend.harmonize(yellow, blue);
      expect(answer, isColor(0xffEBFFBA));
    });

    test('yellowToGreen', () {
      final int answer = Blend.harmonize(yellow, green);
      expect(answer, isColor(0xffEBFFBA));
    });

    test('yellowToRed', () {
      final int answer = Blend.harmonize(yellow, red);
      expect(answer, isColor(0xffFFF6E3));
    });
  });
  //
  // RydMike's own coverage test additions.
  //
  group('hctHue', () {
    test('redToBlue 0', () {
      final int answer = Blend.hctHue(red, blue, 0);
      expect(answer, isColor(red));
    });
    test('redToBlue 0.5', () {
      final int answer = Blend.hctHue(red, blue, 0.5);
      expect(answer, isColor(0xFFE700C9));
    });
    test('redToBlue 1', () {
      final int answer = Blend.hctHue(red, blue, 1);
      expect(answer, isColor(0xFF656FFF));
    });
    test('redToBlue 2', () {
      final int answer = Blend.hctHue(red, blue, 1.5);
      expect(answer, isColor(0xFF828400));
    });
  });
  group('cam16Ucs', () {
    test('redToBlue 0', () {
      final int answer = Blend.cam16Ucs(red, blue, 0);
      expect(answer, isColor(red));
    });
    test('redToBlue 0.5', () {
      final int answer = Blend.cam16Ucs(red, blue, 0.5);
      expect(answer, isColor(0xFF9A4A86));
    });
    test('redToBlue 1', () {
      final int answer = Blend.cam16Ucs(red, blue, 1);
      expect(answer, isColor(0xFF0000FF));
    });
    test('redToBlue 2', () {
      final int answer = Blend.cam16Ucs(red, blue, 1.5);
      expect(answer, isColor(0xFFFCFF00));
    });
  });
}
