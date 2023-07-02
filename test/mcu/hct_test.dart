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

import 'dart:ui';

import 'package:flex_seed_scheme/src/mcu/hct/src/hct_solver.dart';
import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';
import 'package:test/test.dart';

import './utils/color_matcher.dart';

const int black = 0xff000000;
const int white = 0xffffffff;
const int red = 0xffff0000;
const int green = 0xff00ff00;
const int blue = 0xff0000ff;
const int midgray = 0xff777777;

bool _colorIsOnBoundary(int argb) {
  return ColorUtils.redFromArgb(argb) == 0 ||
      ColorUtils.redFromArgb(argb) == 255 ||
      ColorUtils.greenFromArgb(argb) == 0 ||
      ColorUtils.greenFromArgb(argb) == 255 ||
      ColorUtils.blueFromArgb(argb) == 0 ||
      ColorUtils.blueFromArgb(argb) == 255;
}

void main() {
  test('==, hashCode basics', () {
    expect(Hct.fromInt(123), Hct.fromInt(123));
    expect(Hct.fromInt(123).hashCode, Hct.fromInt(123).hashCode);
  });

  test('conversions_areReflexive', () {
    final Cam16 cam = Cam16.fromInt(red);
    final int color = cam.viewed(ViewingConditions.standard);
    expect(color, equals(red));
  });

  test('y_midgray', () {
    expect(18.418, closeTo(ColorUtils.yFromLstar(50.0), 0.001));
  });

  test('y_black', () {
    expect(0.0, closeTo(ColorUtils.yFromLstar(0.0), 0.001));
  });

  test('y_white', () {
    expect(100.0, closeTo(ColorUtils.yFromLstar(100.0), 0.001));
  });

  test('cam_red', () {
    final Cam16 cam = Cam16.fromInt(red);
    expect(46.445, closeTo(cam.j, 0.001));
    expect(113.357, closeTo(cam.chroma, 0.001));
    expect(27.408, closeTo(cam.hue, 0.001));
    expect(89.494, closeTo(cam.m, 0.001));
    expect(91.889, closeTo(cam.s, 0.001));
    expect(105.988, closeTo(cam.q, 0.001));
  });

  test('cam_green', () {
    final Cam16 cam = Cam16.fromInt(green);
    expect(79.331, closeTo(cam.j, 0.001));
    expect(108.410, closeTo(cam.chroma, 0.001));
    expect(142.139, closeTo(cam.hue, 0.001));
    expect(85.587, closeTo(cam.m, 0.001));
    expect(78.604, closeTo(cam.s, 0.001));
    expect(138.520, closeTo(cam.q, 0.001));
  });

  test('cam_blue', () {
    final Cam16 cam = Cam16.fromInt(blue);
    expect(25.465, closeTo(cam.j, 0.001));
    expect(87.230, closeTo(cam.chroma, 0.001));
    expect(282.788, closeTo(cam.hue, 0.001));
    expect(68.867, closeTo(cam.m, 0.001));
    expect(93.674, closeTo(cam.s, 0.001));
    expect(78.481, closeTo(cam.q, 0.001));
  });

  test('cam_black', () {
    final Cam16 cam = Cam16.fromInt(black);
    expect(0.0, closeTo(cam.j, 0.001));
    expect(0.0, closeTo(cam.chroma, 0.001));
    expect(0.0, closeTo(cam.hue, 0.001));
    expect(0.0, closeTo(cam.m, 0.001));
    expect(0.0, closeTo(cam.s, 0.001));
    expect(0.0, closeTo(cam.q, 0.001));
  });

  test('cam_white', () {
    final Cam16 cam = Cam16.fromInt(white);
    expect(100.0, closeTo(cam.j, 0.001));
    expect(2.869, closeTo(cam.chroma, 0.001));
    expect(209.492, closeTo(cam.hue, 0.001));
    expect(2.265, closeTo(cam.m, 0.001));
    expect(12.068, closeTo(cam.s, 0.001));
    expect(155.521, closeTo(cam.q, 0.001));
  });

  test('gamutMap_red', () {
    const int colorToTest = red;
    final Cam16 cam = Cam16.fromInt(colorToTest);
    final int color =
        Hct.from(cam.hue, cam.chroma, ColorUtils.lstarFromArgb(colorToTest))
            .toInt();
    expect(colorToTest, equals(color));
  });

  test('gamutMap_green', () {
    const int colorToTest = green;
    final Cam16 cam = Cam16.fromInt(colorToTest);
    final int color =
        Hct.from(cam.hue, cam.chroma, ColorUtils.lstarFromArgb(colorToTest))
            .toInt();
    expect(colorToTest, equals(color));
  });

  test('gamutMap_blue', () {
    const int colorToTest = blue;
    final Cam16 cam = Cam16.fromInt(colorToTest);
    final int color =
        Hct.from(cam.hue, cam.chroma, ColorUtils.lstarFromArgb(colorToTest))
            .toInt();
    expect(colorToTest, equals(color));
  });

  test('gamutMap_white', () {
    const int colorToTest = white;
    final Cam16 cam = Cam16.fromInt(colorToTest);
    final int color =
        Hct.from(cam.hue, cam.chroma, ColorUtils.lstarFromArgb(colorToTest))
            .toInt();
    expect(colorToTest, equals(color));
  });

  test('gamutMap_midgray', () {
    const int colorToTest = green;
    final Cam16 cam = Cam16.fromInt(colorToTest);
    final int color =
        Hct.from(cam.hue, cam.chroma, ColorUtils.lstarFromArgb(colorToTest))
            .toInt();
    expect(colorToTest, equals(color));
  });

  test('HCT returns a sufficiently close color', () {
    for (int hue = 15; hue < 360; hue += 30) {
      for (int chroma = 0; chroma <= 100; chroma += 10) {
        for (int tone = 20; tone <= 80; tone += 10) {
          final String hctRequestDescription = 'H$hue C$chroma T$tone';
          final Hct hctColor = Hct.from(
            hue.toDouble(),
            chroma.toDouble(),
            tone.toDouble(),
          );

          if (chroma > 0) {
            expect(
              hctColor.hue,
              closeTo(hue, 4.0),
              reason: 'Hue should be close for $hctRequestDescription',
            );
          }

          expect(
            hctColor.chroma,
            inInclusiveRange(0.0, chroma + 2.5),
            reason: 'Chroma should be close or less for $hctRequestDescription',
          );

          if (hctColor.chroma < chroma - 2.5) {
            expect(
              _colorIsOnBoundary(hctColor.toInt()),
              true,
              reason: 'HCT request for non-sRGB color should return '
                  'a color on the boundary of the sRGB cube '
                  'for $hctRequestDescription, but got '
                  '${StringUtils.hexFromArgb(hctColor.toInt())} instead',
            );
          }

          expect(
            hctColor.tone,
            closeTo(tone, 0.5),
            reason: 'Tone should be close for $hctRequestDescription',
          );
        }
      }
    }
  });

  group('CAM16 to XYZ', () {
    test('without array', () {
      const int colorToTest = red;
      final Cam16 cam = Cam16.fromInt(colorToTest);
      final List<double> xyz =
          cam.xyzInViewingConditions(ViewingConditions.sRgb);
      expect(xyz[0], closeTo(41.23, 0.01));
      expect(xyz[1], closeTo(21.26, 0.01));
      expect(xyz[2], closeTo(1.93, 0.01));
    });

    test('with array', () {
      const int colorToTest = red;
      final Cam16 cam = Cam16.fromInt(colorToTest);
      final List<double> xyz = cam.xyzInViewingConditions(
          ViewingConditions.sRgb,
          array: <double>[0, 0, 0]);
      expect(xyz[0], closeTo(41.23, 0.01));
      expect(xyz[1], closeTo(21.26, 0.01));
      expect(xyz[2], closeTo(1.93, 0.01));
    });
  });

  group('Color Relativity', () {
    test('red in black', () {
      const int colorToTest = red;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xff9F5C51));
    });

    test('red in white', () {
      const int colorToTest = red;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xffFF5D48));
    });

    test('green in black', () {
      const int colorToTest = green;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xffACD69D));
    });

    test('green in white', () {
      const int colorToTest = green;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xff8EFF77));
    });

    test('blue in black', () {
      const int colorToTest = blue;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xff343654));
    });

    test('blue in white', () {
      const int colorToTest = blue;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xff3F49FF));
    });

    test('white in black', () {
      const int colorToTest = white;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xffFFFFFF));
    });

    test('white in white', () {
      const int colorToTest = white;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xffFFFFFF));
    });

    test('midgray in black', () {
      const int colorToTest = midgray;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xff605F5F));
    });

    test('midgray in white', () {
      const int colorToTest = midgray;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xff8E8E8E));
    });

    test('black in black', () {
      const int colorToTest = black;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(ViewingConditions.make(backgroundLstar: 0.0))
              .toInt(),
          isColor(0xff000000));
    });

    test('black in white', () {
      const int colorToTest = black;
      final Hct hct = Hct.fromInt(colorToTest);
      expect(
          hct
              .inViewingConditions(
                  ViewingConditions.make(backgroundLstar: 100.0))
              .toInt(),
          isColor(0xff000000));
    });
  });
  //
  // Rydmike added extra coverage tests Cam16 and Hct
  //
  group('Color HCT', () {
    test('HCT solveToCam', () {
      final Cam16 cam = HctSolver.solveToCam(45, 50, 30);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff793000)));
    });
    test('HCT.from set(hue) set(chroma) set(tone)', () {
      final Hct hct = Hct.from(45, 50, 30);
      hct.chroma = 30;
      expect(Color(hct.toInt()), equals(const Color(0xff6b3a20)));
      hct.hue = 100;
      expect(Color(hct.toInt()), equals(const Color(0xff51470b)));
      hct.tone = 85;
      expect(Color(hct.toInt()), equals(const Color(0xffe4d58c)));
    });
  });
  group('Color Distance', () {
    test('Blue to blue distance is 0', () {
      const int colorToTest = blue;
      const int distanceToColor = blue;
      final Cam16 cam = Cam16.fromInt(colorToTest);
      final Cam16 camTo = Cam16.fromInt(distanceToColor);
      expect(cam.distance(camTo), equals(0.0));
    });
    test('Blue to red distance is > 21', () {
      const int colorToTest = blue;
      const int distanceToColor = red;
      final Cam16 cam = Cam16.fromInt(colorToTest);
      final Cam16 camTo = Cam16.fromInt(distanceToColor);
      expect(cam.distance(camTo), greaterThan(21));
    });
  });
  group('Cam from fromJch', () {
    test('fromJch(0.2, 30, 20)', () {
      final Cam16 cam = Cam16.fromJch(0.2, 30, 20);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff010000)));
    });
    test('fromJch(10, 55, 45)', () {
      final Cam16 cam = Cam16.fromJch(10, 55, 45);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff450400)));
    });
    test('fromJch(20, 60, 380)', () {
      final Cam16 cam = Cam16.fromJch(20, 60, 380);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff79131c)));
    });
    test('fromJch(00, 60, 380)', () {
      final Cam16 cam = Cam16.fromJch(0, 60, 380);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff000000)));
    });
    test('fromJch(090, 60, 380)', () {
      final Cam16 cam = Cam16.fromJch(90, 60, 380);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xffffb7b4)));
    });
    test('fromJch(100, 60, 500)', () {
      final Cam16 cam = Cam16.fromJch(100, 60, 500);
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xffc6ffa3)));
    });
  });
  group('Cam from fromXyzInViewingConditions', () {
    test(
        'fromXyzInViewingConditions(0, 12000, -12000, '
        'ViewingConditions.make)', () {
      final Cam16 cam = Cam16.fromXyzInViewingConditions(
          0, 12000, -12000, ViewingConditions.make());
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff00ff00)));
    });
    test(
        'fromXyzInViewingConditions(10, 20, 40, '
        'ViewingConditions.make)', () {
      final Cam16 cam = Cam16.fromXyzInViewingConditions(
          10, 20, 40, ViewingConditions.make(surround: 0.4));
      final int camToInt = cam.toInt();
      expect(Color(camToInt), equals(const Color(0xff00a7ba)));
    });
  });
}
