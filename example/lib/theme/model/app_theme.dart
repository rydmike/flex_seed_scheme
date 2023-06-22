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
      // Tone chroma config and tone mapping is optional. If you do not add it
      // you get a config matching Flutter's Material 3 ColorScheme.fromSeed.
      //
      // Use tone style and mapping, for light mode.
      // Make both main On and all On surfaces colors black and white if
      // opted in on that setting.
      tones: controller.usedTone
          .tones(Brightness.light)
          .onMainsUseBW(controller.keepMainOnColorsBW)
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW),
    );

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
  /// Same input seed colors mode, but with brightness set to dark
  static ThemeData dark(ThemeController controller) {
    final ColorScheme colorScheme = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: controller.primarySeedColor,
      secondaryKey:
          controller.useSecondaryKey ? controller.secondarySeedColor : null,
      tertiaryKey:
          controller.useTertiaryKey ? controller.tertiarySeedColor : null,
      tones: controller.usedTone
          .tones(Brightness.dark)
          .onMainsUseBW(controller.keepMainOnColorsBW)
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW),
    );

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
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW),
    );

    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      // Toggle M2/M3 mode.
      useMaterial3: controller.useMaterial3,
    );
  }

  // Factory to build our example high contrast dark theme.
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
          .onSurfacesUseBW(controller.keepSurfaceOnColorsBW),
    );

    return ThemeData(
      colorScheme: colorScheme,
      // Fix the divider color.
      dividerColor: colorScheme.outlineVariant,
      useMaterial3: controller.useMaterial3,
    );
  }
}
