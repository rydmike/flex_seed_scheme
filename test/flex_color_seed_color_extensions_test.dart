import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // FlexColorSeedColorExtensions unit tests.
  //****************************************************************************
  group('FCSCE01: WITH Color Black ', () {
    const Color blackInt = Color(0xFF000000);
    const Color blackDouble =
        Color.from(alpha: 1.0, red: 0.0, green: 0.0, blue: 0.0);

    test('FCSCE01.01: GIVEN blackInt EXPECT equal to blackDouble', () {
      expect(blackInt, equals(blackDouble));
    });
    test('FCSCE01.02: GIVEN blackInt EXPECT correct 32-bit value', () {
      expect(blackInt.value32bit, equals(0xFF000000));
    });
    test('FCSCE01.03: GIVEN blackInt EXPECT correct alpha 8-bit value', () {
      expect(blackInt.alpha8bit, equals(0xFF));
    });
    test('FCSCE01.04: GIVEN blackInt EXPECT correct red 8-bit value', () {
      expect(blackInt.red8bit, equals(0x00));
    });
    test('FCSCE01.05: GIVEN blackInt EXPECT correct green 8-bit value', () {
      expect(blackInt.green8bit, equals(0x00));
    });
    test('FCSCE01.06: GIVEN blackInt EXPECT correct blue 8-bit value', () {
      expect(blackInt.blue8bit, equals(0x00));
    });
    test('FCSCE01.07: GIVEN blackDouble EXPECT correct 32-bit value', () {
      expect(blackDouble.value32bit, equals(0xFF000000));
    });
    test('FCSCE01.08: GIVEN blackDouble EXPECT correct alpha 8-bit value', () {
      expect(blackDouble.alpha8bit, equals(0xFF));
    });
    test('FCSCE01.09: GIVEN blackDouble EXPECT correct red 8-bit value', () {
      expect(blackDouble.red8bit, equals(0x00));
    });
    test('FCSCE01.10: GIVEN blackDouble EXPECT correct green 8-bit value', () {
      expect(blackDouble.green8bit, equals(0x00));
    });
    test('FCSCE01.11: GIVEN blackDouble EXPECT correct blue 8-bit value', () {
      expect(blackDouble.blue8bit, equals(0x00));
    });
  });
  group('FCSCE02: WITH Color White ', () {
    const Color whiteInt = Color(0xFFFFFFFF);
    const Color whiteDouble =
        Color.from(alpha: 1.0, red: 1.0, green: 1.0, blue: 1.0);

    test('FCSCE02.01: GIVEN whiteInt EXPECT equal to blackDouble', () {
      expect(whiteInt, equals(whiteDouble));
    });
    test('FCSCE02.02: GIVEN whiteInt EXPECT correct 32-bit value', () {
      expect(whiteInt.value32bit, equals(0xFFFFFFFF));
    });
    test('FCSCE02.03: GIVEN whiteInt EXPECT correct alpha 8-bit value', () {
      expect(whiteInt.alpha8bit, equals(0xFF));
    });
    test('FCSCE02.04: GIVEN whiteInt EXPECT correct red 8-bit value', () {
      expect(whiteInt.red8bit, equals(0xFF));
    });
    test('FCSCE02.05: GIVEN whiteInt EXPECT correct green 8-bit value', () {
      expect(whiteInt.green8bit, equals(0xFF));
    });
    test('FCSCE02.06: GIVEN whiteInt EXPECT correct blue 8-bit value', () {
      expect(whiteInt.blue8bit, equals(0xFF));
    });
    test('FCSCE02.07: GIVEN whiteDouble EXPECT correct 32-bit value', () {
      expect(whiteDouble.value32bit, equals(0xFFFFFFFF));
    });
    test('FCSCE02.08: GIVEN whiteDouble EXPECT correct alpha 8-bit value', () {
      expect(whiteDouble.alpha8bit, equals(0xFF));
    });
    test('FCSCE02.09: GIVEN whiteDouble EXPECT correct red 8-bit value', () {
      expect(whiteDouble.red8bit, equals(0xFF));
    });
    test('FCSCE02.10: GIVEN whiteDouble EXPECT correct green 8-bit value', () {
      expect(whiteDouble.green8bit, equals(0xFF));
    });
    test('FCSCE02.11: GIVEN whiteDouble EXPECT correct blue 8-bit value', () {
      expect(whiteDouble.blue8bit, equals(0xFF));
    });
  });

  group('FCSCE02: WITH Color Grey 40% and translucent 40% ', () {
    const Color grey40Int = Color(0x66666666);
    const Color grey40Double =
        Color.from(alpha: 0.4, red: 0.4, green: 0.4, blue: 0.4);

    test('FCSCE02.01: GIVEN grey40Int EXPECT equal to grey40Double', () {
      expect(grey40Int, equals(grey40Double));
    });
    test('FCSCE02.02: GIVEN grey40Int EXPECT correct 32-bit value', () {
      expect(grey40Int.value32bit, equals(0x66666666));
    });
    test('FCSCE02.03: GIVEN grey40Int EXPECT correct alpha 8-bit value', () {
      expect(grey40Int.alpha8bit, equals(0x66));
    });
    test('FCSCE02.04: GIVEN grey40Int EXPECT correct red 8-bit value', () {
      expect(grey40Int.red8bit, equals(0x66));
    });
    test('FCSCE02.05: GIVEN grey40Int EXPECT correct green 8-bit value', () {
      expect(grey40Int.green8bit, equals(0x66));
    });
    test('FCSCE02.06: GIVEN grey40Int EXPECT correct blue 8-bit value', () {
      expect(grey40Int.blue8bit, equals(0x66));
    });
    test('FCSCE02.07: GIVEN grey40Double EXPECT correct 32-bit value', () {
      expect(grey40Double.value32bit, equals(0x66666666));
    });
    test('FCSCE02.08: GIVEN grey40Double EXPECT correct alpha 8-bit value', () {
      expect(grey40Double.alpha8bit, equals(0x66));
    });
    test('FCSCE02.09: GIVEN grey40Double EXPECT correct red 8-bit value', () {
      expect(grey40Double.red8bit, equals(0x66));
    });
    test('FCSCE02.10: GIVEN grey40Double EXPECT correct green 8-bit value', () {
      expect(grey40Double.green8bit, equals(0x66));
    });
    test('FCSCE02.11: GIVEN grey40Double EXPECT correct blue 8-bit value', () {
      expect(grey40Double.blue8bit, equals(0x66));
    });
  });
}
