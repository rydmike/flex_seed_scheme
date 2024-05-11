import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../theme/controllers/theme_controller.dart';
import 'select_palette_type.dart';
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
    final FlexTones tones = controller.usedVariant.tones(brightness);
    // Type of palette to show.
    final FlexPaletteType paletteType = controller.paletteType;

    // Compute all the FlexCoreTonalPalette tones.
    final FlexCorePalette palettes = FlexCorePalette.fromSeeds(
      primary: controller.primarySeedColor.value,
      // Pass in null if set to not use secondary or tertiary seed keys.
      secondary: controller.useSecondaryKey
          ? controller.secondarySeedColor.value
          : null,
      tertiary:
          controller.useTertiaryKey ? controller.tertiarySeedColor.value : null,
      error: controller.useErrorKey ? controller.errorSeedColor.value : null,
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
      paletteType: paletteType,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'TonalPalettes Tones and Colors',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            SelectPaletteType(controller: controller),
            const SizedBox(width: 12),
          ],
        ),
        TonalPaletteColors(
          name: 'Primary',
          tonalPalette: palettes.primary.asList,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Secondary',
          tonalPalette: palettes.secondary.asList,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Tertiary',
          tonalPalette: palettes.tertiary.asList,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Error',
          tonalPalette: palettes.error.asList,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Neutral',
          tonalPalette: palettes.neutral.asList,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Neutral variant',
          tonalPalette: palettes.neutralVariant.asList,
          paletteType: paletteType,
        ),
      ],
    );
  }
}
