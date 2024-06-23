import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';

/// The theme for this app is defined in
class AppTheme {
  AppTheme._();

  /// Function to build our example light theme.
  static ThemeData light(ThemeController controller) {
    //
    // Use [SeedColorScheme.fromSeeds] instead of ColorScheme.fromSeed],
    // to generate the ColorScheme.
    // We often need the colors in the ColorScheme we will use in our
    // ThemeData to customize color mappings in ThemeData and components,
    // so we define it first.
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      // Make a seeded ColorScheme for light mode
      brightness: Brightness.light,
      // Primary key color is required, like seed in ColorScheme.fromSeed.
      primaryKey: controller.primarySeedColor,
      // We can opt in on using secondary and tertiary seed key colors.
      secondaryKey:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiaryKey:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      errorKey: controller.useErrorKey ? controller.errorSeedColor : null,
      neutralKey: controller.useNeutralKey ? controller.neutralSeedColor : null,
      neutralVariantKey:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
      variant: controller.usedVariant.isFlutterScheme
          ? controller.usedVariant
          : null,
      // The contrast level only has any effect when using above variant based
      // scheming strategy and the variant is one where isFlutterScheme is true.
      contrastLevel: controller.contrastLevel,
      // Use expressive on container colors if opted in on that setting.
      // Used as new default in Material-3 after MCU v0.12.0. Flutter stable
      // 3.22.x and master 3.23.x do not yet use this design.
      useExpressiveOnContainerColors: controller.useExpressiveOn,
      // Tone chroma config and tone mapping is optional. If you do not add it
      // you get a config matching Flutter's Material 3 ColorScheme.fromSeed.
      //
      // Use tone style and mapping, for light mode.
      // Make both main On and all On surfaces colors black and white if
      // opted in on that setting.
      tones: controller.usedVariant.isFlutterScheme
          ? null
          : controller.usedVariant
              .tones(Brightness.light)
              .monochromeSurfaces(controller.useMonoSurfaces)
              .onMainsUseBW(controller.keepMainOnColorsBW)
              .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
              .surfacesUseBW(controller.keepLightSurfaceColorsWhite)
              // This is equivalent to useExpressiveOnContainerColors = true,
              // but for tones based schemes.
              .expressiveOnContainer(controller.useExpressiveOn),
      // Pin input seed colors in light mode to corresponding main colors
      // when set to be pinned in the UI.
      primary: controller.pinPrimary ? controller.primarySeedColor : null,
      secondary: controller.pinSecondary && controller.useSecondaryKey
          ? controller.secondarySeedColor
          : null,
      tertiary: controller.pinTertiary && controller.useTertiaryKey
          ? controller.tertiarySeedColor
          : null,
      error: controller.pinError && controller.useErrorKey
          ? controller.errorSeedColor
          : null,
      surfaceTint:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
    );

    // Light mode theme
    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      // Toggle M2/M3 mode.
      useMaterial3: controller.useMaterial3,
    );
  }

  /// Function to build our example dark theme.
  ///
  /// Same input seed colors mode, but with brightness set to dark and using
  /// own dark mode property for surfacesUseBW, just as an example and because
  /// usually you may not want to use this feature in dark mode, but you
  /// may often want it in light mode for un-tinted white backgrounds with
  /// any seed strategy.
  static ThemeData dark(ThemeController controller) {
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: controller.primarySeedColor,
      secondaryKey:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiaryKey:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      errorKey: controller.useErrorKey ? controller.errorSeedColor : null,
      neutralKey: controller.useNeutralKey ? controller.neutralSeedColor : null,
      neutralVariantKey:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
      variant: controller.usedVariant.isFlutterScheme
          ? controller.usedVariant
          : null,
      contrastLevel: controller.contrastLevel,
      tones: controller.usedVariant.isFlutterScheme
          ? null
          : controller.usedVariant
              .tones(Brightness.dark)
              .monochromeSurfaces(controller.useMonoSurfaces)
              .onMainsUseBW(controller.keepMainOnColorsBW)
              .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
              .surfacesUseBW(controller.keepDarkSurfaceColorsBlack)
              .expressiveOnContainer(controller.useExpressiveOn),
      // Pin input seed colors in dark mode to corresponding container colors
      // when set to be pinned in the UI.
      // Typically input seed "brand" colors have high chroma and ar dark, hence
      // they usually will not fit on the main colors in dark mode, but often
      // they work well on the containers. This can be used to bring a touch
      // of the source "brand" colors to the dark mode.
      primaryContainer:
          controller.pinPrimary ? controller.primarySeedColor : null,
      secondaryContainer: controller.pinSecondary && controller.useSecondaryKey
          ? controller.secondarySeedColor
          : null,
      tertiaryContainer: controller.pinTertiary && controller.useTertiaryKey
          ? controller.tertiarySeedColor
          : null,
      errorContainer: controller.pinError && controller.useErrorKey
          ? controller.errorSeedColor
          : null,
      surfaceTint:
          controller.useNeutralKey ? controller.neutralSeedColor : null,
    );

    // Dark mode theme
    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      // Toggle M2/M3 mode.
      useMaterial3: controller.useMaterial3,
    );
  }

  // Define accessibility high contrast versions using same color base.
  //
  // The theme below is same as selecting the ultra contrast option in the
  // popup.
  //
  // By providing a theme on these properties, it will be auto selected
  // when platform accessibility theme is requested. Some host platforms
  // (for example, iOS, so far only iOS supports this in Flutter) allow the
  // users to increase contrast through an  accessibility setting.
  //
  // If the user requested a high contrast between foreground and background
  // content on iOS, via Settings -> Accessibility -> Increase Contrast.
  // This is currently only supported on iOS devices that are running
  // iOS 13 or above.
  //
  // If you make the selection on an iOS device, you will get the high
  // contrast scheme based ThemeData versions below, regardless of what
  // is selected in the popup in this demo app. This demonstrates how to
  // follow device accessibility setting on iOS, while still using a theme
  // with ColorScheme based on your theme design goal used for your standard
  // contrast.

  /// Function to build our example high contrast light theme.
  ///
  // In this example we use FlexTones.highContrast.
  static ThemeData highContrastLight(ThemeController controller) {
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      primaryKey: controller.primarySeedColor,
      secondaryKey:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiaryKey:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      tones: FlexTones.highContrast(Brightness.light)
          .onMainsUseBW(controller.keepMainOnColorsBW)
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
          .surfacesUseBW(controller.keepLightSurfaceColorsWhite),
    );

    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      // Toggle M2/M3 mode.
      useMaterial3: controller.useMaterial3,
    );
  }

  // Factory to build our example ultra high contrast dark theme.
  //
  // In this example we use FlexTones.ultraContrast.
  // Same input seed colors mode, but with brightness set to dark
  static ThemeData highContrastDark(ThemeController controller) {
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: controller.primarySeedColor,
      secondaryKey:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiaryKey:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      tones: FlexTones.ultraContrast(Brightness.dark)
          .onMainsUseBW(controller.keepMainOnColorsBW)
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW)
          .surfacesUseBW(controller.keepDarkSurfaceColorsBlack),
    );

    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      // Toggle M2/M3 mode.
      useMaterial3: controller.useMaterial3,
    );
  }
}
