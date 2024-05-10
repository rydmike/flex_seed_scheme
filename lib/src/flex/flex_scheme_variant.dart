import 'package:flutter/material.dart';

import 'flex_seed_scheme.dart';
import 'flex_tones.dart';

/// Enum used to return and describes properties of the [FlexSchemeVariant]
/// variants to invoke different color scheme generation algorithms
/// in [SeedColorScheme.fromSeeds], when passed to its [FlexSchemeVariant]
/// property variant.
///
/// [FlexSchemeVariant] values that use [isFlutterScheme] set to true, use the
/// Flutter SDK algorithm to construct a [ColorScheme] identical to
/// [ColorScheme.fromSeed], or more exactly will do in next stable after
/// Flutter 3.22.x
///
/// The [tonalSpot] is the only variant available in Flutter 3.22 and it builds
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
/// the Flutter SDK's [ColorScheme.fromSeed]. A key feature is that all tonal
/// palettes can use their own seed color.
///
/// By using [tones] function and a given [Brightness], it will returns the
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
/// adjust used color value on the icon. These properties can optionally be
/// used whn building UIs that present the different scheme variants. They
/// serve no other purpose. THey can also be ignored and you can optionally
/// just use the enum values as input and use them to build your own UI
/// for selecting and describing a scheme variant.
enum FlexSchemeVariant {
  /// Default for Material theme colors. Builds pastel palettes with a low
  /// chroma.
  ///
  /// This is the default seed generation used by Flutter SDK starting from
  /// Flutter 3.22. The styles used before
  tonalSpot(
    variantName: 'Tonal spot',
    description: 'Default for Material theme colors. Builds pastel palettes '
        'with a low chroma.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// The resulting color palettes match seed color, even if the seed color
  /// is very bright (high chroma).
  fidelity(
    variantName: 'Fidelity',
    description: 'The resulting color palettes match seed color, also when '
        'the seed color is very bright, using high chroma.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// All colors are grayscale, no chroma.
  monochrome(
    variantName: 'Monochrome',
    description: 'All colors are grayscale, with no chroma.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// Close to grayscale, a hint of chroma.
  neutral(
    variantName: 'Neutral',
    description: 'Close to grayscale, but with a hint of chroma.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// Pastel colors, high chroma palettes. The primary palette's chroma is at
  /// maximum. Use `fidelity` instead if tokens should alter their tone to match
  /// the palette vibrancy.
  vibrant(
    variantName: 'Vibrant',
    description: 'Pastel colors, high chroma palettes. '
        'The primary palette chroma is at maximum.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// Pastel colors, medium chroma palettes. The primary palette's hue is
  /// different from the seed color, for variety.
  expressive(
    variantName: 'Expressive',
    description: 'Pastel colors, medium chroma palettes. The primary palette '
        'hue is different from the seed color, for variety.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// Almost identical to `fidelity`. Tokens and palettes match the seed color.
  /// [ColorScheme.primaryContainer] is the seed color, adjusted to ensure
  /// contrast with surfaces. The tertiary palette is analogue of the seed color.
  content(
    variantName: '',
    description: '',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A playful theme - the seed color's hue does not appear in the theme.
  rainbow(
    variantName: 'Rainbow',
    description: "A playful theme. The seed color's hue does not appear in "
        'the theme.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A playful theme - the seed color's hue does not appear in the theme.
  fruitSalad(
    variantName: 'Fruit salad',
    description: "A playful theme. The seed color's hue does not appear in "
        'the theme.',
    configDetails: '',
    icon: Icons.blur_circular,
    shade: 0,
    isFlutterScheme: true,
  ),

  /// A scheme variant that can be used to indicate and describe that a seed
  /// generated ColorScheme is not used in user interfaces.
  ///
  /// If actually selected and used to generate a ColorScheme, it will result
  /// in same result as [tonalSpot].
  disabled(
    variantName: 'None',
    description: 'Tonal palettes are not in use',
    configDetails: 'Key color based tonal palettes are not used.\n'
        'Enable at least one key color to seed the palettes.\n'
        'Primary color must always be included as a key color.',
    icon: Icons.texture_outlined,
    shade: -5,
    isFlutterScheme: true,
  ),

  /// A Material-3 standard tonal palette tones extraction using HCT
  /// based chroma.
  ///
  /// This setup will if only one seed color is used, produce the same result
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
    description: 'Default Material 3 design tone map and chroma setup',
    configDetails: 'Primary - Chroma from key color, but min 36\n'
        'Secondary - Chroma set to 16\n'
        'Tertiary - Chroma set to 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 6\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
    icon: Icons.blur_circular,
    shade: -5,
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
    variantName: 'Material-3 Legacy',
    description: 'Legacy Material 3 design tone map and chroma setup, used '
        'before Flutter 3.22',
    configDetails: 'Primary - Chroma from key color, but min 48\n'
        'Secondary - Chroma set to 16\n'
        'Tertiary - Chroma set to 24\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
    icon: Icons.blur_circular,
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
    description: 'Softer and more earth like tones than Material 3 defaults',
    configDetails: 'Primary - Chroma set to 30\n'
        'Secondary - Chroma set to 14\n'
        'Tertiary - Chroma set to 20\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
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
    description: 'More Vivid colors than Material 3 defaults',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
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
    description: 'Like Vivid, but with more colorful containers, onColors and '
        'surface tones. Creates alpha blend like effect without '
        'any blend level',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10\n'
        'Tonal palette - Common',
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
    description: 'High contrast version, may be useful for accessibility',
    configDetails: 'Primary - Chroma from key color, but min 65\n'
        'Secondary - Chroma from key color, but min 55\n'
        'Tertiary - Chroma from key color, but min 55\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
    icon: Icons.contrast,
    shade: 14,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in a very high
  /// contrast version of selected ColorsSchemes.
  ultraContrast(
    variantName: 'Ultra contrast',
    description: 'Ultra high contrast version, useful for accessibility, '
        'less colorful than high contrast, especially dark mode',
    configDetails: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 70\n'
        'Tertiary - Chroma from key color, but min 65\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 3\n'
        'Neutral variant - Chroma set to 6\n'
        'Tonal palette - Common',
    icon: Icons.lens,
    shade: 20,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in a more jolly
  /// colorful ColorsSchemes.
  jolly(
    variantName: 'Jolly',
    description: 'Jolly color tones with more chroma and pop in them',
    configDetails: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma from key color, but min 40\n'
        'Tertiary - Chroma set to 40\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 6\n'
        'Neutral variant - Chroma set to 10\n'
        'Tonal palette - Common',
    icon: Icons.sunny,
    shade: 8,
    isFlutterScheme: false,
  ),

  /// A tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vividSurfaces], but
  /// tone mapping surface and background are swapped.
  vividBackground(
    variantName: 'Vivid background',
    description: 'Like Vivid surfaces, but with tone mapping for surface '
        'and background swapped',
    configDetails: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 5\n'
        'Neutral variant - Chroma set to 10\n'
        'Tonal palette - Common',
    icon: Icons.panorama_wide_angle_select_rounded,
    shade: 10,
    isFlutterScheme: false,
  ),

  /// A Material-3 tonal palette tones extraction, but with no hue rotation
  /// from primary if no ARGB key color is provided for tertiary palette.
  ///
  /// This setup will if only one seed color is used, produce a slightly more
  /// chromatic color set than [FlexTones.material], since it does not rotate
  /// hue from primary to get hue for tertiary, it will create a color
  /// scheme using tonal palettes that are based on the same hue, but with
  /// different chroma. In simple terms, all colors are shades of the provided
  /// key color to seed the tonal palettes. We can get a nice one hue
  /// toned theme with this configuration.
  oneHue(
    variantName: 'One hue',
    description: 'If only primary key color given, scheme uses only one hue',
    configDetails: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma set to 26\n'
        'Tertiary - Chroma set to 36, no Hue rotation\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n'
        'Tonal palette - Common',
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
    description: 'A high contrast color scheme, useful for accessible themes, '
        'with colors that pop like candy. Keeps the background and surface '
        'white in light mode, and only a slight tint in dark mode. Neutrals '
        'have very low chroma',
    configDetails: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 44\n'
        'Tertiary - Chroma from key color, but min 50\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 2\n'
        'Neutral variant - Chroma set to 4\n'
        'Tonal palette - Extended',
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
    description:
        'A color scheme that follows chroma of each used seed color. Useful '
        'for manual control of pop or low chromacity. It uses low '
        'surface tint and neutrals with medium chroma',
    configDetails: 'Primary - Chroma from key color, min 0\n'
        'Secondary - Chroma from key color, min 0\n'
        'Tertiary - Chroma from key color, min 0\n'
        'Error - Chroma from key, unbound. Default Hue 25, Chroma 84\n'
        'Neutral - Chroma set to 2 (L), 3 (D)\n'
        'Neutral variant - Chroma set to 4 (L), 6 (D)\n'
        'Tonal palette - Extended',
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
  /// are custom and made by FlexColorScheme with a different configuration,
  /// that offers capability to use multiple seed colors.
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
      case FlexSchemeVariant.disabled:
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
