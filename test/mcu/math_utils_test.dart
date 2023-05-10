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
import 'package:flex_seed_scheme/src/mcu/utils/math_utils.dart';
import 'package:flex_seed_scheme/src/mcu/utils/string_utils.dart';
import 'package:test/test.dart';

// Original implementation for MathUtils.rotationDirection.
// Included here to test equivalence with new implementation.
double _rotationDirection(double from, double to) {
  final double a = to - from;
  final double b = to - from + 360.0;
  final double c = to - from - 360.0;
  final double aAbs = a.abs();
  final double bAbs = b.abs();
  final double cAbs = c.abs();
  if (aAbs <= bAbs && aAbs <= cAbs) {
    return a >= 0.0 ? 1.0 : -1.0;
  } else if (bAbs <= aAbs && bAbs <= cAbs) {
    return b >= 0.0 ? 1.0 : -1.0;
  } else {
    return c >= 0.0 ? 1.0 : -1.0;
  }
}

void main() {
  test('rotationDirection behaves correctly', () {
    for (double from = 0.0; from < 360.0; from += 15.0) {
      for (double to = 7.5; to < 360.0; to += 15.0) {
        final double expectedAnswer = _rotationDirection(from, to);
        final double actualAnswer = MathUtils.rotationDirection(from, to);
        expect(
          actualAnswer,
          expectedAnswer,
          reason: 'should be $expectedAnswer from $from to $to',
        );
        expect(
          actualAnswer.abs(),
          1.0,
          reason: 'should be either +1.0 or -1.0 '
              'from $from to $to (got $actualAnswer)',
        );
      }
    }
  });
  //
  // RydMike add coverage for isOpaque
  //
  test('sanitizeDegreesInt', () {
    expect(MathUtils.sanitizeDegreesInt(0), equals(0));
    expect(MathUtils.sanitizeDegreesInt(200), equals(200));
    expect(MathUtils.sanitizeDegreesInt(359), equals(359));
    expect(MathUtils.sanitizeDegreesInt(360), equals(0));
    expect(MathUtils.sanitizeDegreesInt(4501), equals(181));
    expect(MathUtils.sanitizeDegreesInt(-0), equals(0));
    expect(MathUtils.sanitizeDegreesInt(-200), equals(160));
    expect(MathUtils.sanitizeDegreesInt(-359), equals(1));
    expect(MathUtils.sanitizeDegreesInt(-360), equals(0));
    expect(MathUtils.sanitizeDegreesInt(-4501), equals(179));
  });
  test('sanitizeDegreesDouble', () {
    expect(MathUtils.sanitizeDegreesDouble(0), equals(0));
    expect(MathUtils.sanitizeDegreesDouble(200), equals(200));
    expect(MathUtils.sanitizeDegreesDouble(359), equals(359));
    expect(MathUtils.sanitizeDegreesDouble(360), equals(0));
    expect(MathUtils.sanitizeDegreesDouble(4501), equals(181));
    expect(MathUtils.sanitizeDegreesDouble(-0), equals(0));
    expect(MathUtils.sanitizeDegreesDouble(-200), equals(160));
    expect(MathUtils.sanitizeDegreesDouble(-359), equals(1));
    expect(MathUtils.sanitizeDegreesDouble(-360), equals(0));
    expect(MathUtils.sanitizeDegreesDouble(-4501), equals(179));
  });
  test('hexFromArgb', () {
    expect(StringUtils.hexFromArgb(0xFFAABBCC), equals('#AABBCC'));
    expect(StringUtils.hexFromArgb(0xFFAABBCC, leadingHashSign: false),
        equals('AABBCC'));
  });
  test('argbFromHex', () {
    expect(StringUtils.argbFromHex('#FFAABBCC'), equals(0xFFAABBCC));
    expect(StringUtils.argbFromHex('#FFAABBCC'), equals(0xFFAABBCC));
  });
}
