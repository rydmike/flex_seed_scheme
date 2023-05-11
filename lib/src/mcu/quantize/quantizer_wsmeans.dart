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

import 'dart:math' as math show Random, min;

import 'package:flutter/foundation.dart';

import 'quantizer.dart';
import 'src/point_provider.dart';
import 'src/point_provider_lab.dart';

/// DistanceAndIndex.
class DistanceAndIndex implements Comparable<DistanceAndIndex> {
  /// Default DistanceAndIndex constructor.
  DistanceAndIndex(this.distance, this.index);

  /// distance.
  double distance;

  /// index.
  int index;

  @override
  int compareTo(DistanceAndIndex other) {
    if (distance < other.distance) {
      return -1;
    } else if (distance > other.distance) {
      return 1;
    } else {
      return 0;
    }
  }
}

/// QuantizerWsmeans.
class QuantizerWsmeans {
  /// debug.
  static const bool debug = false;

  /// debugLog.
  static void debugLog(String log) {
    if (debug) {
      if (kDebugMode) {
        print(log); // coverage:ignore-line
      }
    }
  }

  /// Do quantize.
  static QuantizerResult quantize(
    Iterable<int> inputPixels,
    int maxColors, {
    List<int> startingClusters = const <int>[],
    PointProvider pointProvider = const PointProviderLab(),
    int maxIterations = 5,
    bool returnInputPixelToClusterPixel = false,
  }) {
    final Map<int, int> pixelToCount = <int, int>{};
    final List<List<double>> points = <List<double>>[];
    final List<int> pixels = <int>[];
    int pointCount = 0;
    for (final int inputPixel in inputPixels) {
      final int pixelCount = pixelToCount
          .update(inputPixel, (int value) => value + 1, ifAbsent: () => 1);
      if (pixelCount == 1) {
        pointCount++;
        points.add(pointProvider.fromInt(inputPixel));
        pixels.add(inputPixel);
      }
    }

    final List<int> counts = List<int>.filled(pointCount, 0);
    for (int i = 0; i < pointCount; i++) {
      final int pixel = pixels[i];
      final int count = pixelToCount[pixel]!;
      counts[i] = count;
    }

    final int clusterCount = math.min(maxColors, pointCount);

    final List<List<double>> clusters =
        startingClusters.map((int e) => pointProvider.fromInt(e)).toList();
    final int additionalClustersNeeded = clusterCount - clusters.length;
    if (additionalClustersNeeded > 0) {
      final math.Random random = math.Random(0x42688);
      final List<int> indices = <int>[];
      for (int i = 0; i < additionalClustersNeeded; i++) {
        // Use existing points rather than generating random centroids.
        //
        // KMeans is extremely sensitive to initial clusters. This quantizer
        // is meant to be used with a Wu quantizer that provides initial
        // centroids, but Wu is very slow on unscaled images and when extracting
        // more than 256 colors.
        //
        // Here, we can safely assume that more than 256 colors were requested
        // for extraction. Generating random centroids tends to lead to many
        // "empty" centroids, as the random centroids are nowhere near any
        // pixels in the image, and the centroids from Wu are very refined and
        // close to pixels in the image.
        //
        // Rather than generate random centroids, we'll pick centroids that
        // are actual pixels in the image, and avoid duplicating centroids.
        int index = random.nextInt(points.length);
        while (indices.contains(index)) {
          index = random.nextInt(points.length);
        }
        indices.add(index);
      }
      for (final int index in indices) {
        clusters.add(points[index]);
      }
    }
    debugLog(
      'have ${clusters.length} starting clusters, ${points.length} points',
    );
    final List<int> clusterIndices =
        List<int>.generate(pointCount, (int index) => index % clusterCount);
    final List<List<int>> indexMatrix = List<List<int>>.generate(
      clusterCount,
      (_) => List<int>.filled(clusterCount, 0),
    );

    final List<List<DistanceAndIndex>> distanceToIndexMatrix =
        List<List<DistanceAndIndex>>.generate(
      clusterCount,
      (int index) => List<DistanceAndIndex>.generate(
        clusterCount,
        (int index) => DistanceAndIndex(0, index),
      ),
    );

    final List<int> pixelCountSums = List<int>.filled(clusterCount, 0);
    for (int iteration = 0; iteration < maxIterations; iteration++) {
      // coverage:ignore-start
      if (debug) {
        for (int i = 0; i < clusterCount; i++) {
          pixelCountSums[i] = 0;
        }
        for (int i = 0; i < pointCount; i++) {
          final int clusterIndex = clusterIndices[i];
          final int count = counts[i];
          pixelCountSums[clusterIndex] += count;
        }
        int emptyClusters = 0;
        for (int cluster = 0; cluster < clusterCount; cluster++) {
          if (pixelCountSums[cluster] == 0) {
            emptyClusters++;
          }
        }
        debugLog(
          'starting iteration ${iteration + 1}; $emptyClusters clusters '
          'are empty of $clusterCount',
        );
        // coverage:ignore-end
      }

      int pointsMoved = 0;
      for (int i = 0; i < clusterCount; i++) {
        for (int j = i + 1; j < clusterCount; j++) {
          final double distance =
              pointProvider.distance(clusters[i], clusters[j]);
          distanceToIndexMatrix[j][i].distance = distance;
          distanceToIndexMatrix[j][i].index = i;
          distanceToIndexMatrix[i][j].distance = distance;
          distanceToIndexMatrix[i][j].index = j;
        }
        distanceToIndexMatrix[i].sort();
        for (int j = 0; j < clusterCount; j++) {
          indexMatrix[i][j] = distanceToIndexMatrix[i][j].index;
        }
      }

      for (int i = 0; i < pointCount; i++) {
        final List<double> point = points[i];
        final int previousClusterIndex = clusterIndices[i];
        final List<double> previousCluster = clusters[previousClusterIndex];
        final double previousDistance =
            pointProvider.distance(point, previousCluster);
        double minimumDistance = previousDistance;
        int newClusterIndex = -1;
        for (int j = 0; j < clusterCount; j++) {
          if (distanceToIndexMatrix[previousClusterIndex][j].distance >=
              4 * previousDistance) {
            continue;
          }
          final double distance = pointProvider.distance(point, clusters[j]);
          if (distance < minimumDistance) {
            minimumDistance = distance;
            newClusterIndex = j;
          }
        }
        if (newClusterIndex != -1) {
          pointsMoved++;
          clusterIndices[i] = newClusterIndex;
        }
      }

      if (pointsMoved == 0 && iteration > 0) {
        debugLog('terminated after $iteration k-means iterations');
        break;
      }

      debugLog('iteration ${iteration + 1} moved $pointsMoved');
      final List<double> componentASums = List<double>.filled(clusterCount, 0);
      final List<double> componentBSums = List<double>.filled(clusterCount, 0);
      final List<double> componentCSums = List<double>.filled(clusterCount, 0);

      for (int i = 0; i < clusterCount; i++) {
        pixelCountSums[i] = 0;
      }
      for (int i = 0; i < pointCount; i++) {
        final int clusterIndex = clusterIndices[i];
        final List<double> point = points[i];
        final int count = counts[i];
        pixelCountSums[clusterIndex] += count;
        componentASums[clusterIndex] += point[0] * count;
        componentBSums[clusterIndex] += point[1] * count;
        componentCSums[clusterIndex] += point[2] * count;
      }
      for (int i = 0; i < clusterCount; i++) {
        final int count = pixelCountSums[i];
        if (count == 0) {
          clusters[i] = <double>[0.0, 0.0, 0.0]; // coverage:ignore-line
          continue;
        }
        final double a = componentASums[i] / count;
        final double b = componentBSums[i] / count;
        final double c = componentCSums[i] / count;
        clusters[i] = <double>[a, b, c];
      }
    }

    final List<int> clusterArgbs = <int>[];
    final List<int> clusterPopulations = <int>[];
    for (int i = 0; i < clusterCount; i++) {
      final int count = pixelCountSums[i];
      if (count == 0) {
        continue;
      }

      final int possibleNewCluster = pointProvider.toInt(clusters[i]);
      if (clusterArgbs.contains(possibleNewCluster)) {
        continue;
      }

      clusterArgbs.add(possibleNewCluster);
      clusterPopulations.add(count);
    }
    debugLog(
      'kmeans finished and generated ${clusterArgbs.length} '
      'clusters; $clusterCount were requested',
    );

    final Map<int, int> inputPixelToClusterPixel = <int, int>{};
    if (returnInputPixelToClusterPixel) {
      final Stopwatch stopwatch = Stopwatch()..start();
      for (int i = 0; i < pixels.length; i++) {
        final int inputPixel = pixels[i];
        final int clusterIndex = clusterIndices[i];
        final List<double> cluster = clusters[clusterIndex];
        final int clusterPixel = pointProvider.toInt(cluster);
        inputPixelToClusterPixel[inputPixel] = clusterPixel;
      }
      debugLog(
        'took ${stopwatch.elapsedMilliseconds} ms to create '
        'input to cluster map',
      );
    }

    return QuantizerResult(
      Map<int, int>.fromIterables(clusterArgbs, clusterPopulations),
      inputPixelToClusterPixel: inputPixelToClusterPixel,
    );
  }
}
