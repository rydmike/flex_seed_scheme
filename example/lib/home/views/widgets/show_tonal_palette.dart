import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../theme/controllers/theme_controller.dart';
import 'tonal_palette_colors.dart';

class ShowTonalPalette extends StatelessWidget {
  const ShowTonalPalette({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = theme.brightness;
    // Get the FlexTones setup
    final FlexTones tones = controller.usedTone.tones(brightness);
    // Compute all the FlexCoreTonalPalette tones.
    final FlexCorePalette palettes = FlexCorePalette.fromSeeds(
      primary: controller.primarySeedColor.value,
      // Pass in null if set to not use secondary or tertiary seed keys.
      secondary: controller.useSecondaryKey
          ? controller.secondarySeedColor.value
          : null,
      tertiary:
          controller.useTertiaryKey ? controller.tertiarySeedColor.value : null,
      // Tone config details we get from active FlexTones.
      primaryChroma: tones.primaryChroma,
      primaryMinChroma: tones.primaryMinChroma,
      secondaryChroma: tones.secondaryChroma,
      secondaryMinChroma: tones.secondaryMinChroma,
      tertiaryChroma: tones.tertiaryChroma,
      tertiaryMinChroma: tones.tertiaryMinChroma,
      tertiaryHueRotation: tones.tertiaryHueRotation,
      neutralChroma: tones.neutralChroma,
      neutralVariantChroma: tones.neutralVariantChroma,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'TonalPalettes Tones and Colors',
            style: theme.textTheme.titleMedium,
          ),
        ),
        TonalPaletteColors(
          name: 'Primary',
          tonalPalette: palettes.primary.asList,
        ),
        TonalPaletteColors(
          name: 'Secondary',
          tonalPalette: palettes.secondary.asList,
        ),
        TonalPaletteColors(
          name: 'Tertiary',
          tonalPalette: palettes.tertiary.asList,
        ),
        TonalPaletteColors(
          name: 'Error',
          tonalPalette: palettes.error.asList,
        ),
        TonalPaletteColors(
          name: 'Neutral',
          tonalPalette: palettes.neutral.asList,
        ),
        TonalPaletteColors(
          name: 'Neutral variant',
          tonalPalette: palettes.neutralVariant.asList,
        ),
      ],
    );
  }
}
