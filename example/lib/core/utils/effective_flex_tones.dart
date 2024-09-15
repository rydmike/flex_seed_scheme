import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../theme/controllers/theme_controller.dart';

/// Return effective FlexTones for the current theme setup and mode.
FlexTones effectiveFlexTones(ThemeController controller, BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final Brightness brightness = theme.brightness;
  final bool isLight = theme.brightness == Brightness.light;

  // Which variant is being used?
  final FlexSchemeVariant usedVariant = controller.usedVariant;

  // Grab active tones and chroma setup.
  final FlexTones tones = controller.usedVariant
      .tones(brightness)
      .higherContrastFixed(controller.higherContrastFixedColors)
      .monochromeSurfaces(controller.useMonoSurfaces)
      .onMainsUseBW(controller.keepMainOnColorsBW)
      .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
      .surfacesUseBW(isLight
          ? controller.keepLightSurfaceColorsWhite
          : controller.keepDarkSurfaceColorsBlack)
      .expressiveOnContainer(controller.useExpressiveOn);

  if (usedVariant.isFlutterScheme) {
    // Get DynamicScheme tones if using Flutter SDK scheme.
    final DynamicScheme dynamicScheme = SeedColorScheme.buildDynamicScheme(
      brightness: brightness,
      primarySeedColor: controller.primarySeedColor,
      secondarySeedColor:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiarySeedColor:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      errorSeedColor: controller.useErrorKey ? controller.errorSeedColor : null,
      neutralSeedColor:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
      neutralVariantSeedColor:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
      variant: usedVariant,
      contrastLevel: controller.contrastLevel,
      useExpressiveOnContainerColors: controller.useExpressiveOn,
      respectMonochromeSeed: controller.respectMonochromeSeed,
    );

    return tones.copyWith(
      primaryTone: MaterialDynamicColors.primary.getTone(dynamicScheme).round(),
      onPrimaryTone:
          MaterialDynamicColors.onPrimary.getTone(dynamicScheme).round(),
      primaryContainerTone:
          MaterialDynamicColors.primaryContainer.getTone(dynamicScheme).round(),
      onPrimaryContainerTone: MaterialDynamicColors.onPrimaryContainer
          .getTone(dynamicScheme)
          .round(),
      primaryFixedTone:
          MaterialDynamicColors.primaryFixed.getTone(dynamicScheme).round(),
      onPrimaryFixedTone:
          MaterialDynamicColors.onPrimaryFixed.getTone(dynamicScheme).round(),
      primaryFixedDimTone:
          MaterialDynamicColors.primaryFixedDim.getTone(dynamicScheme).round(),
      onPrimaryFixedVariantTone: MaterialDynamicColors.onPrimaryFixedVariant
          .getTone(dynamicScheme)
          .round(),
      //
      secondaryTone:
          MaterialDynamicColors.secondary.getTone(dynamicScheme).round(),
      onSecondaryTone:
          MaterialDynamicColors.onSecondary.getTone(dynamicScheme).round(),
      secondaryContainerTone: MaterialDynamicColors.secondaryContainer
          .getTone(dynamicScheme)
          .round(),
      onSecondaryContainerTone: MaterialDynamicColors.onSecondaryContainer
          .getTone(dynamicScheme)
          .round(),
      secondaryFixedTone:
          MaterialDynamicColors.secondaryFixed.getTone(dynamicScheme).round(),
      onSecondaryFixedTone:
          MaterialDynamicColors.onSecondaryFixed.getTone(dynamicScheme).round(),
      secondaryFixedDimTone: MaterialDynamicColors.secondaryFixedDim
          .getTone(dynamicScheme)
          .round(),
      onSecondaryFixedVariantTone: MaterialDynamicColors.onSecondaryFixedVariant
          .getTone(dynamicScheme)
          .round(),
      //
      tertiaryTone:
          MaterialDynamicColors.tertiary.getTone(dynamicScheme).round(),
      onTertiaryTone:
          MaterialDynamicColors.onTertiary.getTone(dynamicScheme).round(),
      tertiaryContainerTone: MaterialDynamicColors.tertiaryContainer
          .getTone(dynamicScheme)
          .round(),
      onTertiaryContainerTone: MaterialDynamicColors.onTertiaryContainer
          .getTone(dynamicScheme)
          .round(),
      tertiaryFixedTone:
          MaterialDynamicColors.tertiaryFixed.getTone(dynamicScheme).round(),
      onTertiaryFixedTone:
          MaterialDynamicColors.onTertiaryFixed.getTone(dynamicScheme).round(),
      tertiaryFixedDimTone:
          MaterialDynamicColors.tertiaryFixedDim.getTone(dynamicScheme).round(),
      onTertiaryFixedVariantTone: MaterialDynamicColors.onTertiaryFixedVariant
          .getTone(dynamicScheme)
          .round(),
      //
      errorTone: MaterialDynamicColors.error.getTone(dynamicScheme).round(),
      onErrorTone: MaterialDynamicColors.onError.getTone(dynamicScheme).round(),
      errorContainerTone:
          MaterialDynamicColors.errorContainer.getTone(dynamicScheme).round(),
      onErrorContainerTone:
          MaterialDynamicColors.onErrorContainer.getTone(dynamicScheme).round(),
      //
      surfaceTone: MaterialDynamicColors.surface.getTone(dynamicScheme).round(),
      onSurfaceTone:
          MaterialDynamicColors.onSurface.getTone(dynamicScheme).round(),
      surfaceDimTone:
          MaterialDynamicColors.surfaceDim.getTone(dynamicScheme).round(),
      surfaceBrightTone:
          MaterialDynamicColors.surfaceBright.getTone(dynamicScheme).round(),
      surfaceContainerLowestTone: MaterialDynamicColors.surfaceContainerLowest
          .getTone(dynamicScheme)
          .round(),
      surfaceContainerLowTone: MaterialDynamicColors.surfaceContainerLow
          .getTone(dynamicScheme)
          .round(),
      surfaceContainerTone:
          MaterialDynamicColors.surfaceContainer.getTone(dynamicScheme).round(),
      surfaceContainerHighTone: MaterialDynamicColors.surfaceContainerHigh
          .getTone(dynamicScheme)
          .round(),
      surfaceContainerHighestTone: MaterialDynamicColors.surfaceContainerHighest
          .getTone(dynamicScheme)
          .round(),
      //
      inverseSurfaceTone:
          MaterialDynamicColors.inverseSurface.getTone(dynamicScheme).round(),
      onInverseSurfaceTone:
          MaterialDynamicColors.inverseOnSurface.getTone(dynamicScheme).round(),
      outlineTone: MaterialDynamicColors.outline.getTone(dynamicScheme).round(),
      outlineVariantTone:
          MaterialDynamicColors.outlineVariant.getTone(dynamicScheme).round(),
      //
      shadowTone: MaterialDynamicColors.shadow.getTone(dynamicScheme).round(),
      scrimTone: MaterialDynamicColors.scrim.getTone(dynamicScheme).round(),
      //
      inversePrimaryTone:
          MaterialDynamicColors.inversePrimary.getTone(dynamicScheme).round(),
      surfaceTintTone:
          MaterialDynamicColors.surfaceTint.getTone(dynamicScheme).round(),
    );
  }

  return tones;
}
