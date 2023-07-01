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

// ignore_for_file: omit_local_variable_types
// rationale: This library relies heavily on numeric computation, and a key
// requirement is that it is 'the same' as implementations in different
// languages. Including variable types, though sometimes unnecessary, is a
// powerful help to verification and avoiding hard-to-debug issues.

import '../utils/color_utils.dart';
import 'quantizer.dart';
import 'quantizer_map.dart';

/// QuantizerWu Quantizer.
class QuantizerWu implements Quantizer {
  /// weights
  List<int> weights = <int>[];

  /// momentsR
  List<int> momentsR = <int>[];

  /// momentsG
  List<int> momentsG = <int>[];

  /// momentsB
  List<int> momentsB = <int>[];

  /// moments
  List<double> moments = <double>[];

  /// cubes
  List<Box> cubes = <Box>[];

  // A histogram of all the input colors is constructed. It has the shape of a
  // cube. The cube would be too large if it contained all 16 million colors:
  // historical best practice is to use 5 bits  of the 8 in each channel,
  // reducing the histogram to a volume of ~32,000.

  /// indexBits
  static const int indexBits = 5;

  /// maxIndex
  static const int maxIndex = 32;

  /// sideLength
  static const int sideLength = 33;

  /// totalSize
  static const int totalSize = 35937;

  @override
  Future<QuantizerResult> quantize(Iterable<int> pixels, int colorCount) async {
    final QuantizerResult result =
        await QuantizerMap().quantize(pixels, colorCount);
    constructHistogram(result.colorToCount);
    computeMoments();
    final CreateBoxesResult createBoxesResult = createBoxes(colorCount);
    final List<int> results = createResult(createBoxesResult.resultCount);
    return QuantizerResult(
      Map<int, int>.fromEntries(
        results.map(
          (int e) => MapEntry<int, int>(e, 0),
        ),
      ),
    );
  }

  /// Get index.
  static int getIndex(int r, int g, int b) {
    return (r << (indexBits * 2)) +
        (r << (indexBits + 1)) +
        (g << indexBits) +
        r +
        g +
        b;
  }

  /// constructHistogram.
  void constructHistogram(Map<int, int> pixels) {
    weights = List<int>.filled(totalSize, 0, growable: false);
    momentsR = List<int>.filled(totalSize, 0, growable: false);
    momentsG = List<int>.filled(totalSize, 0, growable: false);
    momentsB = List<int>.filled(totalSize, 0, growable: false);
    moments = List<double>.filled(totalSize, 0, growable: false);
    for (final MapEntry<int, int> entry in pixels.entries) {
      final int pixel = entry.key;
      final int count = entry.value;
      final int red = ColorUtils.redFromArgb(pixel);
      final int green = ColorUtils.greenFromArgb(pixel);
      final int blue = ColorUtils.blueFromArgb(pixel);
      const int bitsToRemove = 8 - indexBits;
      final int iR = (red >> bitsToRemove) + 1;
      final int iG = (green >> bitsToRemove) + 1;
      final int iB = (blue >> bitsToRemove) + 1;
      final int index = getIndex(iR, iG, iB);
      weights[index] += count;
      momentsR[index] += red * count;
      momentsG[index] += green * count;
      momentsB[index] += blue * count;
      moments[index] += count * ((red * red) + (green * green) + (blue * blue));
    }
  }

  /// computeMoments.
  void computeMoments() {
    for (int r = 1; r < sideLength; ++r) {
      final List<int> area = List<int>.filled(sideLength, 0, growable: false);
      final List<int> areaR = List<int>.filled(sideLength, 0, growable: false);
      final List<int> areaG = List<int>.filled(sideLength, 0, growable: false);
      final List<int> areaB = List<int>.filled(sideLength, 0, growable: false);
      final List<double> area2 =
          List<double>.filled(sideLength, 0.0, growable: false);
      for (int g = 1; g < sideLength; g++) {
        int line = 0;
        int lineR = 0;
        int lineG = 0;
        int lineB = 0;
        double line2 = 0.0;
        for (int b = 1; b < sideLength; b++) {
          final int index = getIndex(r, g, b);
          line += weights[index];
          lineR += momentsR[index];
          lineG += momentsG[index];
          lineB += momentsB[index];
          line2 += moments[index];

          area[b] += line;
          areaR[b] += lineR;
          areaG[b] += lineG;
          areaB[b] += lineB;
          area2[b] += line2;

          final int previousIndex = getIndex(r - 1, g, b);
          weights[index] = weights[previousIndex] + area[b];
          momentsR[index] = momentsR[previousIndex] + areaR[b];
          momentsG[index] = momentsG[previousIndex] + areaG[b];
          momentsB[index] = momentsB[previousIndex] + areaB[b];
          moments[index] = moments[previousIndex] + area2[b];
        }
      }
    }
  }

  /// createBoxes.
  CreateBoxesResult createBoxes(int maxColorCount) {
    cubes = List<Box>.generate(maxColorCount, (int index) => Box());
    cubes[0] = Box(
        r0: 0, r1: maxIndex, g0: 0, g1: maxIndex, b0: 0, b1: maxIndex, vol: 0);

    final List<double> volumeVariance =
        List<double>.filled(maxColorCount, 0.0, growable: false);
    int next = 0;
    int generatedColorCount = maxColorCount;
    for (int i = 1; i < maxColorCount; i++) {
      if (cut(cubes[next], cubes[i])) {
        volumeVariance[next] =
            (cubes[next].vol > 1) ? variance(cubes[next]) : 0.0;
        volumeVariance[i] = (cubes[i].vol > 1) ? variance(cubes[i]) : 0.0;
      } else {
        volumeVariance[next] = 0.0;
        i--;
      }

      next = 0;
      double temp = volumeVariance[0];
      for (int j = 1; j <= i; j++) {
        if (volumeVariance[j] > temp) {
          temp = volumeVariance[j];
          next = j;
        }
      }
      if (temp <= 0.0) {
        generatedColorCount = i + 1;
        break;
      }
    }

    return CreateBoxesResult(
        requestedCount: maxColorCount, resultCount: generatedColorCount);
  }

  /// perform createResult.
  List<int> createResult(int colorCount) {
    final List<int> colors = <int>[];
    for (int i = 0; i < colorCount; ++i) {
      final Box cube = cubes[i];
      final int weight = volume(cube, weights);
      if (weight > 0) {
        final int r = (volume(cube, momentsR) / weight).round();
        final int g = (volume(cube, momentsG) / weight).round();
        final int b = (volume(cube, momentsB) / weight).round();
        final int color = ColorUtils.argbFromRgb(r, g, b);
        colors.add(color);
      }
    }
    return colors;
  }

  /// calculate variance.
  double variance(Box cube) {
    final int dr = volume(cube, momentsR);
    final int dg = volume(cube, momentsG);
    final int db = volume(cube, momentsB);
    final double xx = moments[getIndex(cube.r1, cube.g1, cube.b1)] -
        moments[getIndex(cube.r1, cube.g1, cube.b0)] -
        moments[getIndex(cube.r1, cube.g0, cube.b1)] +
        moments[getIndex(cube.r1, cube.g0, cube.b0)] -
        moments[getIndex(cube.r0, cube.g1, cube.b1)] +
        moments[getIndex(cube.r0, cube.g1, cube.b0)] +
        moments[getIndex(cube.r0, cube.g0, cube.b1)] -
        moments[getIndex(cube.r0, cube.g0, cube.b0)];

    final int hypotenuse = dr * dr + dg * dg + db * db;
    final int volume_ = volume(cube, weights);
    return xx - hypotenuse / volume_;
  }

  /// cut.
  bool cut(Box one, Box two) {
    final int wholeR = volume(one, momentsR);
    final int wholeG = volume(one, momentsG);
    final int wholeB = volume(one, momentsB);
    final int wholeW = volume(one, weights);

    final MaximizeResult maxRResult = maximize(
        one, Direction.red, one.r0 + 1, one.r1, wholeR, wholeG, wholeB, wholeW);
    final MaximizeResult maxGResult = maximize(one, Direction.green, one.g0 + 1,
        one.g1, wholeR, wholeG, wholeB, wholeW);
    final MaximizeResult maxBResult = maximize(one, Direction.blue, one.b0 + 1,
        one.b1, wholeR, wholeG, wholeB, wholeW);

    Direction cutDirection;
    final double maxR = maxRResult.maximum;
    final double maxG = maxGResult.maximum;
    final double maxB = maxBResult.maximum;
    if (maxR >= maxG && maxR >= maxB) {
      cutDirection = Direction.red;
      if (maxRResult.cutLocation < 0) {
        return false;
      }
    } else if (maxG >= maxR && maxG >= maxB) {
      cutDirection = Direction.green;
    } else {
      cutDirection = Direction.blue;
    }

    two.r1 = one.r1;
    two.g1 = one.g1;
    two.b1 = one.b1;

    switch (cutDirection) {
      case Direction.red:
        one.r1 = maxRResult.cutLocation;
        two.r0 = one.r1;
        two.g0 = one.g0;
        two.b0 = one.b0;
      case Direction.green:
        one.g1 = maxGResult.cutLocation;
        two.r0 = one.r0;
        two.g0 = one.g1;
        two.b0 = one.b0;
      case Direction.blue:
        one.b1 = maxBResult.cutLocation;
        two.r0 = one.r0;
        two.g0 = one.g0;
        two.b0 = one.b1;
    }

    one.vol = (one.r1 - one.r0) * (one.g1 - one.g0) * (one.b1 - one.b0);
    two.vol = (two.r1 - two.r0) * (two.g1 - two.g0) * (two.b1 - two.b0);
    return true;
  }

  /// maximize.
  MaximizeResult maximize(Box cube, Direction direction, int first, int last,
      int wholeR, int wholeG, int wholeB, int wholeW) {
    final int bottomR = bottom(cube, direction, momentsR);
    final int bottomG = bottom(cube, direction, momentsG);
    final int bottomB = bottom(cube, direction, momentsB);
    final int bottomW = bottom(cube, direction, weights);

    double max = 0.0;
    int cut = -1;

    for (int i = first; i < last; i++) {
      int halfR = bottomR + top(cube, direction, i, momentsR);
      int halfG = bottomG + top(cube, direction, i, momentsG);
      int halfB = bottomB + top(cube, direction, i, momentsB);
      int halfW = bottomW + top(cube, direction, i, weights);

      if (halfW == 0) {
        continue;
      }

      double tempNumerator =
          ((halfR * halfR) + (halfG * halfG) + (halfB * halfB)).toDouble();
      double tempDenominator = halfW.toDouble();
      double temp = tempNumerator / tempDenominator;

      halfR = wholeR - halfR;
      halfG = wholeG - halfG;
      halfB = wholeB - halfB;
      halfW = wholeW - halfW;
      if (halfW == 0) {
        continue;
      }
      tempNumerator =
          ((halfR * halfR) + (halfG * halfG) + (halfB * halfB)).toDouble();
      tempDenominator = halfW.toDouble();
      temp += tempNumerator / tempDenominator;

      if (temp > max) {
        max = temp;
        cut = i;
      }
    }
    return MaximizeResult(cutLocation: cut, maximum: max);
  }

  /// volume.
  static int volume(Box cube, List<int> moment) {
    return moment[getIndex(cube.r1, cube.g1, cube.b1)] -
        moment[getIndex(cube.r1, cube.g1, cube.b0)] -
        moment[getIndex(cube.r1, cube.g0, cube.b1)] +
        moment[getIndex(cube.r1, cube.g0, cube.b0)] -
        moment[getIndex(cube.r0, cube.g1, cube.b1)] +
        moment[getIndex(cube.r0, cube.g1, cube.b0)] +
        moment[getIndex(cube.r0, cube.g0, cube.b1)] -
        moment[getIndex(cube.r0, cube.g0, cube.b0)];
  }

  /// bottom.
  static int bottom(Box cube, Direction direction, List<int> moment) {
    switch (direction) {
      case Direction.red:
        return -moment[getIndex(cube.r0, cube.g1, cube.b1)] +
            moment[getIndex(cube.r0, cube.g1, cube.b0)] +
            moment[getIndex(cube.r0, cube.g0, cube.b1)] -
            moment[getIndex(cube.r0, cube.g0, cube.b0)];
      case Direction.green:
        return -moment[getIndex(cube.r1, cube.g0, cube.b1)] +
            moment[getIndex(cube.r1, cube.g0, cube.b0)] +
            moment[getIndex(cube.r0, cube.g0, cube.b1)] -
            moment[getIndex(cube.r0, cube.g0, cube.b0)];
      case Direction.blue:
        return -moment[getIndex(cube.r1, cube.g1, cube.b0)] +
            moment[getIndex(cube.r1, cube.g0, cube.b0)] +
            moment[getIndex(cube.r0, cube.g1, cube.b0)] -
            moment[getIndex(cube.r0, cube.g0, cube.b0)];
    }
  }

  /// top.
  static int top(
      Box cube, Direction direction, int position, List<int> moment) {
    switch (direction) {
      case Direction.red:
        return moment[getIndex(position, cube.g1, cube.b1)] -
            moment[getIndex(position, cube.g1, cube.b0)] -
            moment[getIndex(position, cube.g0, cube.b1)] +
            moment[getIndex(position, cube.g0, cube.b0)];
      case Direction.green:
        return moment[getIndex(cube.r1, position, cube.b1)] -
            moment[getIndex(cube.r1, position, cube.b0)] -
            moment[getIndex(cube.r0, position, cube.b1)] +
            moment[getIndex(cube.r0, position, cube.b0)];
      case Direction.blue:
        return moment[getIndex(cube.r1, cube.g1, position)] -
            moment[getIndex(cube.r1, cube.g0, position)] -
            moment[getIndex(cube.r0, cube.g1, position)] +
            moment[getIndex(cube.r0, cube.g0, position)];
    }
  }
}

/// Direction in RGB value.
enum Direction {
  /// Red direction.
  red,

  /// Green direction.
  green,

  /// Blue direction.
  blue,
}

/// MaximizeResult.
class MaximizeResult {
  /// cutLocation.
  ///
  /// < 0 if cut impossible
  int cutLocation;

  /// maximum.
  double maximum;

  /// Default MaximizeResult constructor.
  MaximizeResult({required this.cutLocation, required this.maximum});
}

/// CreateBoxesResult.
class CreateBoxesResult {
  /// requestedCount.
  int requestedCount;

  /// resultCount.
  int resultCount;

  /// Default CreateBoxesResult constructor.
  CreateBoxesResult({required this.requestedCount, required this.resultCount});
}

/// Box.
class Box {
  /// r0
  int r0;

  /// r1
  int r1;

  /// g0
  int g0;

  /// g1
  int g1;

  /// b0
  int b0;

  /// b1
  int b1;

  /// vol
  int vol;

  /// Default Box constructor.
  Box(
      {this.r0 = 0,
      this.r1 = 0,
      this.g0 = 0,
      this.g1 = 0,
      this.b0 = 0,
      this.b1 = 0,
      this.vol = 0});

  @override
  String toString() {
    return 'Box: R $r0 -> $r1 G  $g0 -> $g1 B $b0 -> $b1 VOL = $vol';
  }
}
