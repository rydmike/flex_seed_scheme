import 'package:flutter/material.dart';

import 'flex_seed_scheme.dart';
import 'flex_tones.dart';

/// Enum used to return and describe properties of the [FlexSchemeVariant]
/// variants to invoke different color scheme generation algorithms
/// in [SeedColorScheme.fromSeeds], when passed to its [FlexSchemeVariant]
/// property variant.
///
/// [FlexSchemeVariant] values that use [isFlutterScheme] set to true, use the
/// Flutter SDK and MCU algorithm to construct a [ColorScheme] identical to
/// [ColorScheme.fromSeed] and its variant property that was added in
/// Flutter 3.22.2.
///
/// The [tonalSpot] is variant is the default Flutter 3.22 and later, it builds
/// the default Material-3 style scheme colors. These colors are mapped to light
/// or dark tones to achieve visually accessible color pairings with sufficient
/// contrast between foreground and background elements.
///
/// In some cases, the tones can prevent colors from appearing as intended,
/// such as when a color is too light to offer enough contrast for
/// accessibility. The [fidelity] variant is a feature that adjusts
/// tones in these cases to produce the intended visual results without harming
/// visual contrast.
///
/// Variants that use [isFlutterScheme] set to false, use FlexSeedScheme's own
/// algorithm to construct a [ColorScheme] based on the provided seed colors.
/// These variants are mapped to built-in [FlexTones] configurations that can
/// be used to construct a [ColorScheme] with a more flexible algorithm than
/// the Flutter SDK's [ColorScheme.fromSeed].
///
/// By using the [tones] function and a given [Brightness], it will return the
/// corresponding [FlexTones] made with same named [FlexTones] constructor, for
/// cases where [isFlutterScheme] set to false.
///
/// If you want to make use your own custom [FlexTones] configuration, do not
/// assign any value to `variant` in [SeedColorScheme.fromSeeds] and instead
/// provide your own custom [FlexTones] configuration to the [FlexTones]
/// property `tones` in [SeedColorScheme.fromSeeds].
///
/// This enum also contains labels for variant names, a short description and
/// configuration details, as well as an icon for each tone and shade value to
/// adjust used color value on the icon.
///
/// These properties can optionally be
/// used when building UIs that present the different scheme variants. They
/// serve no other purpose. They can also be ignored and you can use the enum
/// values as input and use them to build your own UI for selecting and
/// describing the scheme variants. These values are used in the example app
/// and also in the `FlexColorScheme` package example apps, like the
/// Themes Playground. Any changes in releases in the enum property values
/// [variantName],[description], [configDetails], [icon] and [shade] are not
/// considered breaking changes, only patches.
enum FlexSchemeVariant {
  /// A Dynamic Color theme with low to medium colorfulness and a Tertiary
  /// Tonal Palette]with a hue related to the source color. The default
  /// Material You theme on Android 12 and 13.
  ///
  /// This is the default seed generation used by Flutter SDK starting from
  /// Flutter 3.22. The tonal palette used before Flutter 3.22 was slightly
  /// different and can be selected with [material3Legacy].
  ///
  /// This modified palette uses chroma 36 on primary palette, previous one used
  /// 48. It uses chroma 6 on neutral palette, where the previous one used 4.
  tonalSpot(
    variantName: 'Tonal spot',
    description: 'Default Material-3 pastel colors with low chroma',
    configDetails: 'Primary - Chroma from key color, but min 36\n'
        'Secondary - Chroma 16\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 6\n'
        'Neutral variant - Chroma 8\n'
        'Variant style: MaterialColorUtilities (MCU)',
    icon: Icons.looks_3_outlined,
    shade: -6,
    isFlutterScheme: true,
  ),

  /// A scheme that places the source/seed color in primaryContainer.
  ///
  /// Primary Container is the source color, adjusted for color relativity.
  /// It maintains constant appearance in light mode and dark mode.
  /// This adds ~5 tone in light mode, and subtracts ~5 tone in dark mode.
  ///
  /// Tertiary Container is the complement to the source color, using
  /// TemperatureCache. It also maintains constant appearance.
  fidelity(
    variantName: 'Fidelity',
    description: 'Color palettes match seed color, also when '
        'it is bright and uses high chroma. Seed appears as primary container',
    configDetails: 'Primary - Chroma from key color\n'
        'Secondary - Max of: chroma from key -32 or *0.5\n'
        'Tertiary - TemperatureCache complement hue or key hue and chroma\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma from key div 8\n'
        'Neutral variant - Chroma from key div 8 plus 4\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.grain_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// All colors are grayscale, no chroma.
  monochrome(
    variantName: 'Monochrome',
    description: 'All colors are grayscale, no chroma',
    configDetails: 'Primary - Chroma 0\n'
        'Secondary - Chroma 0\n'
        'Tertiary - Chroma 0\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 0\n'
        'Neutral variant - Chroma 0\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.filter_b_and_w_outlined,
    shade: 10,
    isFlutterScheme: true,
  ),

  /// A scheme that is near grayscale.
  neutral(
    variantName: 'Neutral',
    description: 'Close to grayscale, only a hint of chroma',
    configDetails: 'Primary - Chroma 12\n'
        'Secondary - Chroma 8\n'
        'Tertiary - Chroma 16\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 2\n'
        'Neutral variant - Chroma 2\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.gradient_outlined,
    shade: -10,
    isFlutterScheme: true,
  ),

  /// A scheme that maxes out colorfulness at each position in the
  /// Primary TonalPalette.
  ///
  /// The primary palette's chroma is at maximum. Use `fidelity` instead if
  /// tokens should alter their tone to match the palette vibrancy.
  vibrant(
    variantName: 'Vibrant',
    description: 'Maxed out colorfulness for primaries. Secondary and '
        'tertiary hues intentionally differ from their seed colors',
    configDetails: 'Primary - Chroma 200\n'
        'Secondary - Chroma 24, Hue rotated 10-18 degrees\n'
        'Tertiary - Chroma 32, Hue rotated 20-35 degrees\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 10\n'
        'Neutral variant - Chroma 12\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.flare_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A scheme that is intentionally detached from the input color.
  /// The primary palette's hue is different from the seed color, for variety.
  expressive(
    variantName: 'Expressive',
    description: 'Hue are intentionally different from the '
        'seed colors',
    configDetails: 'Primary - Hue rotated 240 degrees, Chroma 40\n'
        'Secondary - Chroma 24, Hue rotated 20-95 degrees\n'
        'Tertiary - Chroma 32, Hue rotated 20-120 degrees\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Hue rotated 15 degrees, Chroma 8\n'
        'Neutral variant - Hue rotated 15 degrees, Chroma 12\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.shuffle_on_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// Almost identical to `fidelity`. Tokens and palettes match the seed color.
  ///
  /// [ColorScheme.primaryContainer] is the seed color, adjusted to ensure
  /// contrast with surfaces. The tertiary palette is analogue of the seed
  /// color.
  ///
  /// Primary Container is the source color, adjusted for color relativity.
  /// It maintains constant appearance in light mode and dark mode.
  /// This adds ~5 tone in light mode, and subtracts ~5 tone in dark mode.
  ///
  /// Tertiary Container is an analogous color, specifically, the analog of a
  /// color wheel divided into 6, and the precise analog is the one found by
  /// increasing hue. It also maintains constant appearance.
  content(
    variantName: 'Content',
    description: 'Color palettes match seed color, use with image '
        'extracted seed color',
    configDetails: 'Primary - Chroma from key color\n'
        'Secondary - Max of: chroma from key -32 or *0.5\n'
        'Tertiary - TemperatureCache analogous last\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma from key div 8\n'
        'Neutral variant - Chroma from key div 8 plus 4\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.image_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A playful theme - the seed color's chroma is fixed.
  rainbow(
    variantName: 'Rainbow',
    description: "A playful theme, the seed color's chroma is fixed",
    configDetails: 'Primary - Chroma 48\n'
        'Secondary - Chroma 16\n'
        'Tertiary - Hue+60 or seed hue, Chroma 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 0\n'
        'Neutral variant - Chroma 0\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.looks_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A playful theme - the seed color's hue does not appear in the theme.
  fruitSalad(
    variantName: 'Fruit salad',
    description: 'A playful theme, the primary and secondary seed color hues '
        'are not in the theme',
    configDetails: 'Primary - Hue rotated -50 degrees, Chroma 48\n'
        'Secondary - Hue rotated -50 degrees, Chroma 36\n'
        'Tertiary - Chroma 36\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 10\n'
        'Neutral variant - Chroma 16\n'
        'Variant style: Material Color Utilities (MCU)',
    icon: Icons.filter_vintage_outlined,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A Material-3 standard tonal palette tones extraction using HCT
  /// based chroma.
  ///
  /// This setup will when only one seed color is used, produce the same result
  /// as Flutter SDK does when using [ColorScheme.fromSeed] in
  /// Flutter version 3.22 and later.
  ///
  /// It should be noted that the Material-3 implementation in Flutter uses
  /// DynamicSchemeVariant tonalSpot as default for the Material-3 design
  /// seed generated ColorScheme. There might be some slight differences in
  /// its results and using this selection in some edge cases, but none have
  /// been observed in normal use cases. If an exact match is critical, use
  /// [tonalSpot] as used in the Flutter SDK 3.22 and later.
  ///
  /// If you want to use multiple seed colors to generate a ColorScheme, you
  /// will need to use [FlexTones] based configurations, the ones based on
  /// Flutter SDK DynamicSchemeVariant and MCU do not provide that feature-set.
  material(
    variantName: 'Material-3',
    description: 'Material-3 design tones and chroma setup',
    configDetails: 'Primary - Chroma from key color, but min 36\n'
        'Secondary - Chroma 16\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma 6\n'
        'Neutral variant - Chroma 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.looks_3_outlined,
    shade: -6,
    isFlutterScheme: false,
  ),

  /// A Material-3 standard tonal palette tones extraction using Cam16
  /// based chroma.
  ///
  /// This setup will when only one seed color is used, produce the same result
  /// as Flutter SDK does when using [ColorScheme.fromSeed] in
  /// Flutter version 3.19 and earlier.
  ///
  /// Prior to FlexSeedScheme 2.0.0, this was the default setup used by the
  /// [FlexTones.material] configuration. However, [FlexTones.material] was in
  /// FSS version 2.0.0 modified to match the new actual and revised Material-3
  /// configuration in Flutter 3.22 and later. This factory is provided if you
  /// need and want to use the older Material-3 seed generation setup used in
  /// Flutter 3.19 and earlier versions.
  material3Legacy(
    variantName: 'Material-3 legacy',
    description: 'Legacy Material-3 tones and chroma, used '
        'before Flutter 3.22',
    configDetails: 'Primary - Chroma from key color, but min 48\n'
        'Secondary - Chroma 16\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.filter_3,
    shade: -5,
    isFlutterScheme: false,
  ),

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with softer colors than Material-3 defaults.
  ///
  /// Primary chroma is 30, secondary 14 and tertiary 20. Tones are same as
  /// in Material 3 default setup.
  soft(
    variantName: 'Soft',
    description: 'Softer and more earth like tones than Material-3 defaults',
    configDetails: 'Primary - Chroma set to 30\n'
        'Secondary - Chroma set to 14\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma set to 20\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.blur_on,
    shade: 2,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with more vivid colors.
  ///
  /// Primary tone is one tone darker than in Material 3 standard setup in light
  /// mode. As in M3 default, primary uses its own chroma, but with a minimum
  /// value of 50. Secondary and tertiary key colors use their own chroma
  /// with no min limits, making the secondary and tertiary mid tones closer
  /// to their used key colors.
  vivid(
    variantName: 'Vivid',
    description: 'More vivid colors than Material-3 defaults',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.tonality,
    shade: 6,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vivid] on main colors, but
  /// double chroma on neutrals and more color tinted surfaces and onColors.
  ///
  /// Primary tone is one tone darker than in Material 3 standard setup in light
  /// mode. As in M3 default, primary uses its own chroma, but with a minimum
  /// value of 50.  Secondary and tertiary key colors use their own chroma
  /// with no min limits, making the secondary and tertiary mid tones closer
  /// to their used key colors.
  /// Chroma for neutral is 8 and neutralVariant 16, doubled from M3 defaults.
  ///
  /// The tones are modified for more colorful container, onColors color tones
  /// and for using higher tones on surfaces and backgrounds. This creates
  /// an alpha blend like of effect of primary on surfaces, without using any
  /// blend level in FlexColorScheme. You can apply alpha blends to this tones
  /// setup too, but it is easy to overdo it with these surfaces and
  /// backgrounds as starting points.
  vividSurfaces(
    variantName: 'Vivid surfaces',
    description: 'Like Vivid, but more colorful surfaces and containers',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.radio_button_checked,
    shade: 10,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with high contrast between color versus its on-color and
  /// main color, versus its container color.
  ///
  /// Primary, Secondary and tertiary key colors use their own chroma, but
  /// with minimum limit of 65 on primary and 55 on secondary and tertiary.
  ///
  /// Used tones are also modified from M3 defaults for increased contrast.
  ///
  /// This tonal configuration can be used to turn any M3 theme into one
  /// that may be more accessibility since it offers increased contrast.
  /// You could apply a variant of the active theme with this tonal map to
  /// the high contrast theme data, thus providing increased contrast, but in
  /// the spirit of the original theme. It may still be useful to also
  /// provide purposefully designed optional extremely high contrast
  /// themes as options for the high contrast accessibility themes.
  highContrast(
    variantName: 'High contrast',
    description: 'High contrast theme, useful for accessibility',
    configDetails: 'Primary - Chroma from key color, but min 65\n'
        'Secondary - Chroma from key color, but min 55\n'
        'Tertiary - Hue rotated 60 degrees or key hue, '
        'Chroma from key color, but min 55\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.contrast,
    shade: 14,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in a very high
  /// contrast version of selected ColorsSchemes.
  ultraContrast(
    variantName: 'Ultra contrast',
    description: 'Ultra high contrast theme, useful for accessibility',
    configDetails: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 70\n'
        'Tertiary - Hue rotated 60 degrees or key hue, '
        'Chroma from key color, but min 65\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 3\n'
        'Neutral variant - Chroma set to 6\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.lens,
    shade: 20,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in a more jolly
  /// colorful ColorsSchemes.
  jolly(
    variantName: 'Jolly',
    description: 'Jolly colors with more chroma and pop',
    configDetails: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma from key color, but min 40\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma 40\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 6\n'
        'Neutral variant - Chroma set to 10\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.sunny,
    shade: 8,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vividSurfaces], but
  /// tone mapping surface and background are swapped.
  ///
  /// This variant and its used [FlexTones.vividBackground] will be
  /// deprecated when Flutter SDK stops using the deprecated background color.
  vividBackground(
    variantName: 'Vivid background',
    description: 'Like Vivid surfaces, but tone mapping for surface '
        'and deprecated background color swapped',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Hue rotated 60 degrees or key hue, Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.panorama_wide_angle_select_rounded,
    shade: 10,
    isFlutterScheme: false,
  ),

  /// A Material-3 tonal palette tones extraction, but with no hue rotation
  /// from primary if no ARGB key color is provided for tertiary palette.
  ///
  /// This setup will if only one seed color is used, produce a slightly more
  /// chromatic color set than [FlexTones.material].
  ///
  /// Since it does not rotate hue from primary to get hue for tertiary,
  /// it will create a color scheme using tonal palettes that are all based on
  /// the same hue, but with different chroma. In simple terms, all colors are
  /// shades of the provided key color to seed the tonal palettes. With this
  /// setup we can get a nice one color tone based theme.
  oneHue(
    variantName: 'One hue',
    description: 'With only a primary seed the theme has only one hue',
    configDetails: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma set to 26\n'
        'Tertiary - Chroma set to 36, no Hue rotation\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.looks_one_rounded,
    shade: 7,
    isFlutterScheme: false,
  ),

  /// A tonal palette setup that results in a high contrast colorful
  /// candy pop like theme.
  ///
  /// It has white surface and background (tone 100) in light mode and
  /// low chroma on neutrals (2 and 4). Dark mode uses dark
  /// surface and background tone 6.
  candyPop(
    variantName: 'Candy pop',
    description: 'High contrast candy like colors. '
        'Neutrals have low chroma',
    configDetails: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 44\n'
        'Tertiary - Hue rotated 60 degrees or key hue, '
        'Chroma from key color, but min 50\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 2\n'
        'Neutral variant - Chroma set to 4\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.join_left_outlined,
    shade: 9,
    isFlutterScheme: false,
  ),

  /// A tonal palette setup that result in a color scheme that follows chroma
  /// of each used seed color. Useful for manual control of pop or low
  /// chromacity.
  ///
  /// Uses low surface tint and neutrals with medium chroma.
  /// Theme with background and surface tone 98, in light mode and very low
  /// chroma in neutrals light mode (2 and 4) and moderate in dark mode
  /// (3 and 6). Dark mode uses dark surface and background tone 6.
  chroma(
    variantName: 'Chroma',
    description: 'Colors follow chroma of each seed color. Useful '
        'for manual control of chromacity. Neutrals have low chroma',
    configDetails: 'Primary - Chroma from key color, min 0\n'
        'Secondary - Chroma from key color, min 0\n'
        'Tertiary - Hue rotated 60 degrees or key hue, '
        'Chroma from key color, min 0\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 2 (L), 3 (D)\n'
        'Neutral variant - Chroma set to 4 (L), 6 (D)\n'
        'Variant style: Flex Seed Scheme (FSS)',
    icon: Icons.lens_outlined,
    shade: 3,
    isFlutterScheme: false,
  );

  /// The constructor for the [FlexSchemeVariant] enum.
  const FlexSchemeVariant({
    required this.variantName,
    required this.description,
    required this.configDetails,
    required this.icon,
    required this.shade,
    required this.isFlutterScheme,
  });

  /// Then name and label of the used Scheme variant.
  final String variantName;

  /// A short description of the used Scheme variant.
  final String description;

  /// A more detailed description of the used Scheme variant, including how it
  /// is defined.
  final String configDetails;

  /// The icon used to represent the Scheme variant.
  final IconData icon;

  /// A shade value used to adjust the color of the icon.
  final int shade;

  /// If true, this is a Flutter defined scheme, if false it is a custom scheme.
  ///
  /// This used to separate the two types of color schemes, those produced
  /// via identical configuration to Flutter defined schemes, and those that
  /// are custom and made by FlexColorScheme using a FlexTones configuration,
  /// that offers capability to use multiple seed colors and more flexible
  /// color scheme generation.
  final bool isFlutterScheme;

  /// Returns a [FlexTones] instance based on the [FlexSchemeVariant] and
  /// [Brightness] provided.
  FlexTones tones(Brightness brightness) {
    switch (this) {
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
        return FlexTones.material(brightness);
      case FlexSchemeVariant.material3Legacy:
        return FlexTones.material3Legacy(brightness);
      case FlexSchemeVariant.soft:
        return FlexTones.soft(brightness);
      case FlexSchemeVariant.vivid:
        return FlexTones.vivid(brightness);
      case FlexSchemeVariant.vividSurfaces:
        return FlexTones.vividSurfaces(brightness);
      case FlexSchemeVariant.highContrast:
        return FlexTones.highContrast(brightness);
      case FlexSchemeVariant.ultraContrast:
        return FlexTones.ultraContrast(brightness);
      case FlexSchemeVariant.jolly:
        return FlexTones.jolly(brightness);
      case FlexSchemeVariant.vividBackground:
        return FlexTones.vividBackground(brightness);
      case FlexSchemeVariant.oneHue:
        return FlexTones.oneHue(brightness);
      case FlexSchemeVariant.candyPop:
        return FlexTones.candyPop(brightness);
      case FlexSchemeVariant.chroma:
        return FlexTones.chroma(brightness);
    }
  }
}
