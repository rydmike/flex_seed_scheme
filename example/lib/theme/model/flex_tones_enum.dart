import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'custom_tones.dart';

/// Enum used to return and describes properties of used [FlexTones].
///
/// By using [tones] and a given [Brightness], it returns the corresponding
/// [FlexTones] made with same named constructor or even a custom option.
///
/// Contains used icon for each tone and shade value to adjust used
/// color value on the icon, used by UI building.
///
/// Also a small demonstration of how we can use Dart 2.17 enhanced enums.
enum FlexTonesEnum {
  custom(
    toneLabel: 'Custom',
    describe: 'A custom mapping and chroma config made for this example.',
    setup: 'Primary - Chroma from key color, but min 55, tone 30/70\n'
        'Secondary - Chroma from key color, but min 25\n'
        'Tertiary - Chroma from key color, but min 40\n'
        'Neutral - Chroma set to 7\n'
        'Neutral variant - Chroma set to 14\n',
    icon: Icons.texture_outlined,
    shade: 1,
  ),
  material(
    toneLabel: 'Material 3',
    describe: 'Default Material 3 design tone map and chroma setup',
    setup: 'Primary - Chroma from key color, but min 48\n'
        'Secondary - Chroma set to 16\n'
        'Tertiary - Chroma set to 24\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8',
    icon: Icons.blur_circular,
    shade: -5,
  ),
  soft(
    toneLabel: 'Soft',
    describe: 'Softer and more earth like tones than Material 3 defaults',
    setup: 'Primary - Chroma set to 30\n'
        'Secondary - Chroma set to 14\n'
        'Tertiary - Chroma set to 20\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8',
    icon: Icons.blur_on,
    shade: 2,
  ),
  vivid(
    toneLabel: 'Vivid',
    describe: 'More Vivid colors than Material 3 defaults',
    setup: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8',
    icon: Icons.tonality,
    shade: 6,
  ),
  vividSurfaces(
    toneLabel: 'Vivid surfaces',
    describe: 'Like Vivid, but with more colorful containers, onColors and '
        'surface tones. Creates alpha blend like effect without '
        'any blend level',
    setup: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10',
    icon: Icons.radio_button_checked,
    shade: 10,
  ),
  highContrast(
    toneLabel: 'High contrast',
    describe: 'High contrast version, may be useful for accessibility',
    setup: 'Primary - Chroma from key color, but min 65\n'
        'Secondary - Chroma from key color, but min 55\n'
        'Tertiary - Chroma from key color, but min 55\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8',
    icon: Icons.contrast,
    shade: 14,
  ),
  ultraContrast(
    toneLabel: 'Ultra contrast',
    describe: 'Ultra high contrast version, useful for accessibility, '
        'less colorful than high contrast, especially dark mode',
    setup: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 70\n'
        'Tertiary - Chroma from key color, but min 65\n'
        'Neutral - Chroma set to 3\n'
        'Neutral variant - Chroma set to 6',
    icon: Icons.lens,
    shade: 20,
  ),
  jolly(
    toneLabel: 'Jolly',
    describe: 'Jolly color tones with more chroma and pop in them',
    setup: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma from key color, but min 40\n'
        'Tertiary - Chroma set to 40\n'
        'Neutral - Chroma set to 6\n'
        'Neutral variant - Chroma set to 10',
    icon: Icons.sunny,
    shade: 8,
  ),
  vividBackground(
    toneLabel: 'Vivid background',
    describe: 'Like Vivid surfaces, but with tone mapping for surface '
        'and background swapped',
    setup: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10',
    icon: Icons.panorama_wide_angle_select_rounded,
    shade: 10,
  ),
  oneHue(
    toneLabel: 'One hue',
    describe: 'If only primary key color given, scheme uses only one hue',
    setup: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma set to 26\n'
        'Tertiary - Chroma set to 36, no Hue rotation\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8',
    icon: Icons.looks_one_rounded,
    shade: 7,
  );

  const FlexTonesEnum({
    required this.toneLabel,
    required this.describe,
    required this.setup,
    required this.icon,
    required this.shade,
  });

  final String toneLabel;
  final String describe;
  final String setup;
  final IconData icon;
  final int shade;

  FlexTones tones(Brightness brightness) {
    switch (this) {
      case FlexTonesEnum.custom:
        return brightness == Brightness.light ? myLightTones : myDarkTones;
      case FlexTonesEnum.material:
        return FlexTones.material(brightness);
      case FlexTonesEnum.soft:
        return FlexTones.soft(brightness);
      case FlexTonesEnum.vivid:
        return FlexTones.vivid(brightness);
      case FlexTonesEnum.vividSurfaces:
        return FlexTones.vividSurfaces(brightness);
      case FlexTonesEnum.highContrast:
        return FlexTones.highContrast(brightness);
      case FlexTonesEnum.ultraContrast:
        return FlexTones.ultraContrast(brightness);
      case FlexTonesEnum.jolly:
        return FlexTones.jolly(brightness);
      case FlexTonesEnum.vividBackground:
        return FlexTones.vividBackground(brightness);
      case FlexTonesEnum.oneHue:
        return FlexTones.oneHue(brightness);
    }
  }
}
