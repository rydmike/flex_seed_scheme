import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // FlexSchemeVariant unit tests.
  //****************************************************************************
  group('FSVA1: WITH FlexSchemeVariant ', () {
    const Brightness brightness = Brightness.light;
    FlexTones tones;
    for (final FlexSchemeVariant variant in FlexSchemeVariant.values) {
      final FlexTones flexTones = variant.tones(brightness);

      test(
          'FSVA1.01: GIVEN a FlexSchemeVariant EXPECT variant to return '
          'correct tones for the FlexSchemeVariant', () {
        switch (variant) {
          case FlexSchemeVariant.tonalSpot:
          case FlexSchemeVariant.fidelity:
          case FlexSchemeVariant.monochrome:
          case FlexSchemeVariant.neutral:
          case FlexSchemeVariant.vibrant:
          case FlexSchemeVariant.expressive:
          case FlexSchemeVariant.content:
          case FlexSchemeVariant.rainbow:
          case FlexSchemeVariant.fruitSalad:
          case FlexSchemeVariant.material:
            tones = FlexTones.material(brightness);
          case FlexSchemeVariant.material3Legacy:
            tones = FlexTones.material3Legacy(brightness);
          case FlexSchemeVariant.soft:
            tones = FlexTones.soft(brightness);
          case FlexSchemeVariant.vivid:
            tones = FlexTones.vivid(brightness);
          case FlexSchemeVariant.vividSurfaces:
            tones = FlexTones.vividSurfaces(brightness);
          case FlexSchemeVariant.highContrast:
            tones = FlexTones.highContrast(brightness);
          case FlexSchemeVariant.ultraContrast:
            tones = FlexTones.ultraContrast(brightness);
          case FlexSchemeVariant.jolly:
            tones = FlexTones.jolly(brightness);
          case FlexSchemeVariant.vividBackground:
            tones = FlexTones.vividBackground(brightness);
          case FlexSchemeVariant.oneHue:
            tones = FlexTones.oneHue(brightness);
          case FlexSchemeVariant.candyPop:
            tones = FlexTones.candyPop(brightness);
          case FlexSchemeVariant.chroma:
            tones = FlexTones.chroma(brightness);
        }
        expect(flexTones, tones);
      });
    }
  });
}
