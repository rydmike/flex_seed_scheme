import 'package:flutter/foundation.dart';

import '../../flex_seed_scheme.dart';

// ignore_for_file: comment_references

/// Configuration data class that defines which tone to use from each
/// [FlexTonalPalette] when assigning used color to each [ColorScheme] color.
///
/// It is also possible to define how Cam16 chroma is used and limited when
/// generating the tonal palette.
///
/// To use optional [FlexTones] to change tone mappings and default chroma
/// usage and limits with [SeedColorScheme.fromSeeds], you can pass in one of
/// the predefined configs below, to its [tones] property:
///
/// * [FlexTones.material], default and same as Flutter SDK M3 setup used in
///   Flutter 3.22 and later.
/// * [FlexTones.material3Legacy], the same as Flutter SDK M3 setup used in
///   Flutter 3.19 and earlier.
/// * [FlexTones.soft], softer and earthier tones than M3 [FlexTones.material].
/// * [FlexTones.vivid], more vivid colors, uses chroma from all key colors.
/// * [FlexTones.vividSurfaces], like [vivid], but with more colors in surfaces.
/// * [FlexTones.vividBackground], like [vividSurfaces], but with tone mapping
///   for [Colorscheme.surface] and [Colorscheme.background] colors swapped.
/// * [FlexTones.highContrast], can be used for more color accessible themes.
/// * [FlexTones.ultraContrast], for a very high contrast theme that is still
///   in Material 3 color system style.
/// * [FlexTones.jolly], for a more "jolly" and colorful theme.
/// * [FlexTones.oneHue], to create one hue schemes from a primary seed color.
///   When only a primary seed color is used the tertiary color is not rotated
///   60 degrees as with the all the other tone mapping to create the tertiary
///   hue when a key for it is not provided, the primary hue is used. We can
///   thus create a color scheme that uses only one hue.
/// * [FlexTones.candyPop] for a high contrast, candy popping theme. It has
///   tone 100, which is white surface and background in light mode and very
///   dark tone 6, dark mode.
/// * [FlexTones.chroma] for a theme where the chroma in each seed color is used
///   as is with any min limitation. Chroma in passed in color can even be zero,
///   producing a greyscale tonal palette as the palette. It has
///   tone 100, which is white surface and background in light mode and very
///   dark tone 6, dark mode.
///
/// * In version 2.0.0 and later all built-in [FlexTones] use the [paletteType]
///   extended via [FlexPaletteType.extended], for additional tone fidelity.
///   This is needed for compatibility with Flutter 3.22 and its revised
///   [ColorScheme].
///
/// You can also easily create custom configurations by using the
/// [FlexTones.light] and [FlexTones.dark] factories that have defaults that
/// match the Material 3 design setup tone mapping wise, but don't lock
/// chroma by default for primary, secondary and tertiary key colors. Modify
/// the properties you want to change. The above pre-made constructors are
/// examples of doing this.
///
/// When [FlexTonalPalette]s are generated from key color(s) and used to define
/// a [ColorScheme], it is recommended to use the same key colors and
/// [FlexTones] setup for both the light and dark theme. By doing so the
/// same [FlexTonalPalette] is used to assign suitable tones from identical
/// [FlexTonalPalette], but using different tones for light and dark
/// [Brightness].
///
/// The [FlexTones.light] and [FlexTones.dark] constructors match the
/// definition used by Material Design 3 based seed generated tones, for
/// the tone mapping, however chroma is by default unbound. Use
/// [FlexTones.material], for an exact match.
///
/// In Flutter SDK this tone mapping and chroma setup is done with hard coded
/// values in [ColorScheme.fromSeed] and libraries it uses. This class offers
/// configuration of those tone mapping parameters. Depending on which color
/// in the [ColorScheme] it concerns, mapping can typically be changed one step
/// in either direction for a slightly different result. In some cases two
/// tone steps can also be used. Three steps is rarely a good idea, but doable
/// in a few select cases. Avoid going much further than that with any default
/// tone mapping adjustments.
@immutable
class FlexTones with Diagnosticable {
  /// Default constructor requiring almost all properties.
  ///
  /// Prefer using [FlexTones.light] or [FlexTones.dark].
  const FlexTones({
    required this.primaryTone,
    required this.onPrimaryTone,
    required this.primaryContainerTone,
    required this.onPrimaryContainerTone,
    required this.primaryFixedTone,
    required this.primaryFixedDimTone,
    required this.onPrimaryFixedTone,
    required this.onPrimaryFixedVariantTone,
    //
    required this.secondaryTone,
    required this.onSecondaryTone,
    required this.secondaryContainerTone,
    required this.onSecondaryContainerTone,
    required this.secondaryFixedTone,
    required this.secondaryFixedDimTone,
    required this.onSecondaryFixedTone,
    required this.onSecondaryFixedVariantTone,
    //
    required this.tertiaryTone,
    required this.onTertiaryTone,
    required this.tertiaryContainerTone,
    required this.onTertiaryContainerTone,
    required this.tertiaryFixedTone,
    required this.tertiaryFixedDimTone,
    required this.onTertiaryFixedTone,
    required this.onTertiaryFixedVariantTone,
    //
    required this.errorTone,
    required this.onErrorTone,
    required this.errorContainerTone,
    required this.onErrorContainerTone,
    //
    required this.surfaceTone,
    required this.surfaceDimTone,
    required this.surfaceBrightTone,
    required this.surfaceContainerLowestTone,
    required this.surfaceContainerLowTone,
    required this.surfaceContainerTone,
    required this.surfaceContainerHighTone,
    required this.surfaceContainerHighestTone,
    required this.onSurfaceTone,
    required this.onSurfaceVariantTone,
    //
    required this.outlineTone,
    required this.outlineVariantTone,
    required this.shadowTone,
    required this.scrimTone,
    required this.inverseSurfaceTone,
    required this.onInverseSurfaceTone,
    required this.inversePrimaryTone,
    required this.surfaceTintTone,
    // Deprecated color tones
    @Deprecated('Use surfaceTone instead.') this.backgroundTone,
    @Deprecated('Use onSurfaceTone instead.') this.onBackgroundTone,
    @Deprecated('Use surfaceContainerHighestTone instead.')
    this.surfaceVariantTone,
    //
    this.primaryChroma,
    this.primaryMinChroma,
    this.secondaryChroma,
    this.secondaryMinChroma,
    this.tertiaryChroma,
    this.tertiaryMinChroma,
    this.tertiaryHueRotation,
    this.errorChroma,
    this.errorMinChroma,
    this.neutralChroma,
    this.neutralMinChroma,
    this.neutralVariantChroma,
    this.neutralVariantMinChroma,
    this.paletteType = FlexPaletteType.extended,
    this.useCam16 = true,
  });

  /// Create an M3 light theme mode tonal palette tones extraction setup.
  ///
  /// This setup is almost identical to the default that you get if only
  /// one seed color is used, as you get with Flutter when it uses
  /// [Scheme.light] and [ColorPalette.of]. The difference is
  /// that it does not lock the chroma values for primary, secondary and
  /// tertiary to a specific chroma value, but uses actual chroma of specified
  /// key color, as long as it is over the minimum value.
  /// The minimum values match the Material-3 defaults.
  ///
  /// To get the an exact matching setup as used by Material-3
  /// [ColorScheme.fromSeed] use the [FlexTones.material] factory as the
  /// [FlexTones] configuration.
  ///
  /// The default chroma limits for neutral and neutral variant key colors are
  /// set to 6 and 8 as in Material-3 design. You can create a
  /// [FlexTones.light] where you set [neutralChroma] and [neutralVariantChroma]
  /// to use the effective chroma values in their seed key values as the actual
  /// chroma value for the neutral and neutral tonal palette generation.
  /// This is usually not a good idea, as the seeds value then have to be
  /// pre-tuned to have suitable chroma for neutral surfaces with hint of the
  /// intended low colorfulness. If using key colors to seed generated neutral
  /// colors with other than primary base, it is recommended to set the chroma
  /// values for neutrals to fixed values to get good predictable surface
  /// colors. Limits from 2 to 12 are recommended, with the higher range more
  /// suitable for the neutral variant.
  ///
  /// After FSS version 3.1.0 any mappings for background, onBackground and
  /// surfaceVariant are ignored. The colors are deprecated in Flutter 3.22
  /// and no longer colors that should be used.
  const FlexTones.light({
    this.primaryTone = 40,
    this.onPrimaryTone = 100,
    this.primaryContainerTone = 90,
    this.onPrimaryContainerTone = 10,
    this.primaryFixedTone = 90,
    this.primaryFixedDimTone = 80,
    this.onPrimaryFixedTone = 10,
    this.onPrimaryFixedVariantTone = 30,

    //
    this.secondaryTone = 40,
    this.onSecondaryTone = 100,
    this.secondaryContainerTone = 90,
    this.onSecondaryContainerTone = 10,
    this.secondaryFixedTone = 90,
    this.secondaryFixedDimTone = 80,
    this.onSecondaryFixedTone = 10,
    this.onSecondaryFixedVariantTone = 30,
    //
    this.tertiaryTone = 40,
    this.onTertiaryTone = 100,
    this.tertiaryContainerTone = 90,
    this.onTertiaryContainerTone = 10,
    this.tertiaryFixedTone = 90,
    this.tertiaryFixedDimTone = 80,
    this.onTertiaryFixedTone = 10,
    this.onTertiaryFixedVariantTone = 30,
    //
    this.errorTone = 40,
    this.onErrorTone = 100,
    this.errorContainerTone = 90,
    this.onErrorContainerTone = 10,
    //
    this.surfaceTone = 98,
    this.surfaceDimTone = 87,
    this.surfaceBrightTone = 98,
    this.surfaceContainerLowestTone = 100,
    this.surfaceContainerLowTone = 96,
    this.surfaceContainerTone = 94,
    this.surfaceContainerHighTone = 92,
    this.surfaceContainerHighestTone = 90,
    this.onSurfaceTone = 10,
    this.onSurfaceVariantTone = 30,
    //
    this.inverseSurfaceTone = 20,
    this.onInverseSurfaceTone = 95,
    this.inversePrimaryTone = 80,
    this.surfaceTintTone = 40,
    //
    this.outlineTone = 50,
    this.outlineVariantTone = 80,
    this.shadowTone = 0,
    this.scrimTone = 0,
    // Deprecated tones
    @Deprecated('Use surfaceTone instead.') this.backgroundTone,
    @Deprecated('Use onSurfaceTone instead.') this.onBackgroundTone,
    @Deprecated('Use surfaceContainerHighestTone instead.')
    this.surfaceVariantTone,
    //
    this.primaryChroma,
    this.primaryMinChroma,
    this.secondaryChroma,
    this.secondaryMinChroma,
    this.tertiaryChroma,
    this.tertiaryMinChroma,
    this.tertiaryHueRotation,
    this.errorChroma,
    this.errorMinChroma,
    this.neutralChroma = 6,
    this.neutralMinChroma,
    this.neutralVariantChroma = 8,
    this.neutralVariantMinChroma,
    this.paletteType = FlexPaletteType.extended,
    this.useCam16 = true,
  });

  /// Create a M3 standard dark tonal palette tones extraction setup.
  ///
  /// This setup is almost identical to the default that you get if only
  /// one seed color is used, as you get with Flutter when it uses
  /// [Scheme.dark] and [ColorPalette.of]. The difference is
  /// that it does not lock the chroma values for primary, secondary and
  /// tertiary to a specific chroma value, but uses actual chroma of specified
  /// key color, as long as it is over the minimum value.
  /// The minimum values match the Material 3 defaults.
  ///
  /// To get the an exact matching setup as used by Material 3
  /// [ColorScheme.fromSeed] use the [FlexTones.material] factory as the
  /// [FlexTones] configuration.
  ///
  /// The default chroma limits for neutral and neutral variant key colors are
  /// set to 4 and 8 as in Material 3 design. You can create a
  /// [FlexTones.dark] where you set [neutralChroma] and [neutralVariantChroma]
  /// to use the effective chroma values in their seed key values as the actual
  /// chroma value for the neutral and neutral tonal palette generation.
  /// This is usually not a good idea, as the seeds value then have to be
  /// pre-tuned to have suitable chroma for neutral surfaces with hint of the
  /// intended low colorfulness. If using key colors to seed generated neutral
  /// colors with other than primary base, it is recommended to set the chroma
  /// values for neutrals to fixed values to get good predictable surface
  /// colors. Limits from 2 to 12 are recommended, with the higher range more
  /// suitable for the neutral variant.
  ///
  /// After FSS version 3.1.0 any mappings for background, onBackground and
  /// surfaceVariant are ignored. The colors are deprecated in Flutter 3.22
  /// and no longer colors that should be used.
  const FlexTones.dark({
    this.primaryTone = 80,
    this.onPrimaryTone = 20,
    this.primaryContainerTone = 30,
    this.onPrimaryContainerTone = 90,
    this.primaryFixedTone = 90,
    this.primaryFixedDimTone = 80,
    this.onPrimaryFixedTone = 10,
    this.onPrimaryFixedVariantTone = 30,
    //
    this.secondaryTone = 80,
    this.onSecondaryTone = 20,
    this.secondaryContainerTone = 30,
    this.onSecondaryContainerTone = 90,
    this.secondaryFixedTone = 90,
    this.secondaryFixedDimTone = 80,
    this.onSecondaryFixedTone = 10,
    this.onSecondaryFixedVariantTone = 30,
    //
    this.tertiaryTone = 80,
    this.onTertiaryTone = 20,
    this.tertiaryContainerTone = 30,
    this.onTertiaryContainerTone = 90,
    this.tertiaryFixedTone = 90,
    this.tertiaryFixedDimTone = 80,
    this.onTertiaryFixedTone = 10,
    this.onTertiaryFixedVariantTone = 30,
    //
    this.errorTone = 80,
    this.onErrorTone = 20,
    this.errorContainerTone = 30,
    this.onErrorContainerTone = 90,
    //
    this.surfaceTone = 6,
    this.surfaceDimTone = 6,
    this.surfaceBrightTone = 24,
    this.surfaceContainerLowestTone = 4,
    this.surfaceContainerLowTone = 10,
    this.surfaceContainerTone = 12,
    this.surfaceContainerHighTone = 17,
    this.surfaceContainerHighestTone = 22,
    this.onSurfaceTone = 90,
    this.onSurfaceVariantTone = 80,
    //
    this.inverseSurfaceTone = 90,
    this.onInverseSurfaceTone = 20,
    this.inversePrimaryTone = 40,
    this.surfaceTintTone = 80,
    //
    this.outlineTone = 60,
    this.outlineVariantTone = 30,
    this.shadowTone = 0,
    this.scrimTone = 0,
    // Deprecated tones
    @Deprecated('Use surfaceTone instead.') this.backgroundTone,
    @Deprecated('Use onSurfaceTone instead.') this.onBackgroundTone,
    @Deprecated('Use surfaceContainerHighestTone instead.')
    this.surfaceVariantTone,
    //
    this.primaryChroma,
    this.primaryMinChroma,
    this.secondaryChroma,
    this.secondaryMinChroma,
    this.tertiaryChroma,
    this.tertiaryMinChroma,
    this.tertiaryHueRotation,
    this.errorChroma,
    this.errorMinChroma,
    this.neutralChroma = 6,
    this.neutralMinChroma,
    this.neutralVariantChroma = 8,
    this.neutralVariantMinChroma,
    this.paletteType = FlexPaletteType.extended,
    this.useCam16 = true,
  });

  /// Create a Material-3 standard tonal palette tones extraction using HCT
  /// based chroma.
  ///
  /// This setup will if only one seed color is used, produce the same result
  /// as Flutter SDK does when using [ColorScheme.fromSeed] in
  /// Flutter version 3.22 and later.
  ///
  /// Prior to Flutter 3.22 the [paletteType] was [FlexPaletteType.common]
  /// and the [useCam16] was true, primaryChroma was 48 (now 36) and neutral
  /// chroma 8 (now 6). These changed value match the new Material-3 defaults
  /// in Flutter 3.22 and later.
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
  factory FlexTones.material(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryChroma: 36,
              primaryMinChroma: 36,
              secondaryChroma: 16,
              tertiaryChroma: 24,
              useCam16: false,
            )
          : const FlexTones.dark(
              primaryChroma: 36,
              primaryMinChroma: 36,
              secondaryChroma: 16,
              tertiaryChroma: 24,
              useCam16: false,
            );

  /// Create a Material-3 standard tonal palette tones extraction using Cam16
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
  factory FlexTones.material3Legacy(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              surfaceTone: 99,
              primaryChroma: 48,
              primaryMinChroma: 48,
              secondaryChroma: 16,
              tertiaryChroma: 24,
              neutralChroma: 4,
            )
          : const FlexTones.dark(
              surfaceTone: 10,
              primaryChroma: 48,
              primaryMinChroma: 48,
              secondaryChroma: 16,
              tertiaryChroma: 24,
              neutralChroma: 4,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with softer colors than Material-3 defaults.
  ///
  /// Primary chroma is 30, secondary 14 and tertiary 20. Tones are same as
  /// in Material 3 default setup.
  factory FlexTones.soft(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryChroma: 30,
              primaryMinChroma: 0,
              secondaryChroma: 14,
              tertiaryChroma: 20,
            )
          : const FlexTones.dark(
              primaryChroma: 30,
              primaryMinChroma: 0,
              secondaryChroma: 14,
              tertiaryChroma: 20,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with more vivid colors.
  ///
  /// Primary tone is one tone darker than in Material 3 standard setup in light
  /// mode. As in M3 default, primary uses its own chroma, but with a minimum
  /// value of 50. Secondary and tertiary key colors use their own chroma
  /// with no min limits, making the secondary and tertiary mid tones closer
  /// to their used key colors.
  factory FlexTones.vivid(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              surfaceTintTone: 30,
              surfaceTone: 98,
              //
              primaryMinChroma: 50,
            )
          : const FlexTones.dark(
              onPrimaryTone: 10,
              primaryContainerTone: 20,
              //
              primaryMinChroma: 50,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vivid] on main colors, but
  /// increased chroma on neutrals and more color tinted surfaces and onColors.
  ///
  /// Primary tone is one tone darker than in Material 3 standard setup in light
  /// mode. As in M3 default, primary uses its own chroma, but with a minimum
  /// value of 50.  Secondary and tertiary key colors use their own chroma
  /// with no min limits, making the secondary and tertiary mid tones closer
  /// to their used key colors.
  ///
  /// Chroma for neutral is 5 and neutralVariant 10, increased from M3 defaults
  /// 6 and 8.
  ///
  /// The tones are modified for more colorful container, onColors color tones
  /// and for using higher tones on surfaces and backgrounds. This creates
  /// an alpha blend like of effect of primary on surfaces, without using any
  /// blend level in FlexColorScheme. You can apply alpha blends to this tones
  /// setup too, but it is easy to overdo it with these surfaces and
  /// backgrounds as starting points.
  factory FlexTones.vividSurfaces(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              onPrimaryTone: 98,
              onSecondaryTone: 98,
              onTertiaryTone: 98,
              onErrorTone: 98,
              onSurfaceVariantTone: 20,
              inverseSurfaceTone: 30,
              surfaceTintTone: 30,
              //
              primaryMinChroma: 50,
              neutralChroma: 5,
              neutralVariantChroma: 10,
            )
          : const FlexTones.dark(
              onPrimaryTone: 10,
              onSecondaryTone: 10,
              onTertiaryTone: 10,
              primaryContainerTone: 20,
              onSurfaceVariantTone: 95,
              inverseSurfaceTone: 95,
              //
              primaryMinChroma: 50,
              neutralChroma: 5,
              neutralVariantChroma: 10,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vividSurfaces], but with a few
  /// minor adjustments for increased contrast in dark mode and no tinted
  /// surface color in light mode.
  ///
  /// Surface color uses tone 100 (white) instead of standard 98 in light mode
  /// and 5 instead of 6 in dark mode, for a bit darker dark mode.
  ///
  /// Chroma for neutral is 5 and neutralVariant 10, increased from M3 defaults
  /// 6 and 8.
  ///
  /// **NOTE:**
  ///
  /// Before version 3.10 the tone mappings of surface and background were just
  /// swapped, but since background color is gone in Flutter 3.22 and later, we
  /// needed to make a new setup that makes this tones setup be a bit different
  /// from the [FlexTones.vividSurfaces] setup.
  factory FlexTones.vividBackground(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              onPrimaryTone: 98,
              onSecondaryTone: 98,
              onTertiaryTone: 98,
              onErrorTone: 98,
              surfaceTone: 100,
              onSurfaceVariantTone: 20,
              inverseSurfaceTone: 30,
              surfaceTintTone: 30,
              //
              primaryMinChroma: 50,
              neutralChroma: 5,
              neutralVariantChroma: 10,
            )
          : const FlexTones.dark(
              onPrimaryTone: 10,
              onSecondaryTone: 10,
              onTertiaryTone: 10,
              primaryContainerTone: 20,
              surfaceTone: 5,
              onSurfaceVariantTone: 95,
              inverseSurfaceTone: 95,
              //
              primaryMinChroma: 50,
              neutralChroma: 5,
              neutralVariantChroma: 10,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
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
  factory FlexTones.highContrast(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              tertiaryTone: 30,
              tertiaryContainerTone: 95,
              errorContainerTone: 95,
              surfaceTintTone: 30,
              surfaceTone: 99,
              //
              primaryMinChroma: 65,
              secondaryMinChroma: 55,
              tertiaryMinChroma: 55,
            )
          : const FlexTones.dark(
              onPrimaryTone: 10,
              onSecondaryTone: 10,
              onTertiaryTone: 10,
              onErrorTone: 10,
              primaryContainerTone: 20,
              secondaryContainerTone: 20,
              tertiaryContainerTone: 20,
              errorContainerTone: 20,
              onErrorContainerTone: 90,
              surfaceTone: 4,
              onSurfaceTone: 96,
              surfaceContainerLowestTone: 0,
              surfaceContainerLowTone: 6,
              //
              primaryMinChroma: 65,
              secondaryMinChroma: 55,
              tertiaryMinChroma: 55,
            );

  /// Creates a tonal palette extraction setup that results in a very high
  /// contrast version of selected ColorsSchemes.
  factory FlexTones.ultraContrast(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 20,
              onPrimaryContainerTone: 5,
              onSecondaryContainerTone: 5,
              tertiaryTone: 30,
              tertiaryContainerTone: 95,
              onTertiaryContainerTone: 5,
              errorContainerTone: 95,
              onErrorContainerTone: 5,
              //
              surfaceTone: 100,
              surfaceContainerLowTone: 98,
              surfaceContainerTone: 96,
              onSurfaceTone: 0,
              onSurfaceVariantTone: 6,
              onInverseSurfaceTone: 99,
              inversePrimaryTone: 90,
              outlineTone: 40,
              outlineVariantTone: 70,
              surfaceTintTone: 30,
              //
              primaryMinChroma: 60,
              secondaryMinChroma: 70,
              tertiaryMinChroma: 65,
              neutralChroma: 3,
              neutralVariantChroma: 6,
            )
          : const FlexTones.dark(
              primaryTone: 90,
              onPrimaryTone: 2,
              onPrimaryContainerTone: 98,
              secondaryTone: 95,
              onSecondaryTone: 2,
              onSecondaryContainerTone: 98,
              tertiaryTone: 95,
              onTertiaryTone: 2,
              onTertiaryContainerTone: 98,
              onErrorTone: 2,
              onErrorContainerTone: 98,
              //
              surfaceTone: 2,
              surfaceContainerLowestTone: 0,
              surfaceContainerLowTone: 6,
              onSurfaceTone: 99,
              onSurfaceVariantTone: 95,
              onInverseSurfaceTone: 10,
              outlineTone: 80,
              outlineVariantTone: 50,
              surfaceTintTone: 95,
              //
              primaryMinChroma: 60,
              secondaryMinChroma: 70,
              tertiaryMinChroma: 65,
              neutralChroma: 3,
              neutralVariantChroma: 6,
            );

  /// Creates a tonal palette extraction setup that results in a more jolly
  /// colorful ColorsSchemes.
  factory FlexTones.jolly(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              onPrimaryTone: 99,
              secondaryTone: 50,
              onSecondaryTone: 99,
              secondaryContainerTone: 95,
              onTertiaryTone: 99,
              onErrorTone: 99,
              surfaceTintTone: 30,
              //
              tertiaryChroma: 40,
              primaryMinChroma: 55,
              secondaryMinChroma: 40,
              neutralChroma: 6,
              neutralVariantChroma: 10,
            )
          : const FlexTones.dark(
              onPrimaryTone: 10,
              secondaryTone: 90,
              onSecondaryTone: 10,
              secondaryContainerTone: 20,
              onTertiaryTone: 10,
              onErrorTone: 10,
              //
              tertiaryChroma: 40,
              primaryMinChroma: 55,
              secondaryMinChroma: 40,
              neutralChroma: 6,
              neutralVariantChroma: 10,
            );

  /// Create a Material-3 tonal palette tones extraction, but with no hue
  /// rotation from primary if no ARGB key color is provided for tertiary
  /// palette.
  ///
  /// This setup will if only one seed color is used, produce a slightly more
  /// chromatic color set than [FlexTones.material], since it does not rotate
  /// hue from primary to get hue for tertiary, it will create a color
  /// scheme using tonal palettes that are based on the same hue, but with
  /// different chroma. In simple terms, all colors are shades of the provided
  /// key color to seed the tonal palettes. We can get a nice one hue
  /// toned theme with this configuration.
  factory FlexTones.oneHue(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              secondaryContainerTone: 95,
              tertiaryTone: 30,
              tertiaryContainerTone: 80,
              //
              primaryMinChroma: 55,
              secondaryChroma: 26,
              tertiaryChroma: 36,
              tertiaryHueRotation: 0,
            )
          : const FlexTones.dark(
              tertiaryTone: 90,
              tertiaryContainerTone: 40,
              onTertiaryContainerTone: 95,
              //
              primaryMinChroma: 55,
              secondaryChroma: 26,
              tertiaryChroma: 36,
              tertiaryHueRotation: 0,
            );

  /// Creates a tonal palette setup that results in a high contrast colorful
  /// candy pop like theme.
  ///
  /// It has white surface (tone 100) in light mode and low chroma on neutrals
  /// (2 and 4). Dark mode uses surface tone 5.
  factory FlexTones.candyPop(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 40,
              primaryContainerTone: 80,
              onPrimaryContainerTone: 4,
              secondaryTone: 60,
              secondaryContainerTone: 92,
              onSecondaryContainerTone: 10,
              tertiaryTone: 50,
              tertiaryContainerTone: 95,
              onTertiaryContainerTone: 6,
              //
              surfaceTone: 100,
              onSurfaceTone: 6,
              onSurfaceVariantTone: 10,
              onInverseSurfaceTone: 98,
              inversePrimaryTone: 90,
              outlineTone: 30,
              outlineVariantTone: 70,
              surfaceTintTone: 30,
              //
              primaryMinChroma: 60,
              secondaryMinChroma: 44,
              tertiaryMinChroma: 50,
              neutralChroma: 2,
              neutralVariantChroma: 4,
            )
          : const FlexTones.dark(
              primaryTone: 80,
              onPrimaryTone: 12,
              primaryContainerTone: 40,
              onPrimaryContainerTone: 97,
              secondaryTone: 70,
              onSecondaryTone: 4,
              secondaryContainerTone: 50,
              onSecondaryContainerTone: 96,
              tertiaryTone: 87,
              onTertiaryTone: 5,
              onTertiaryContainerTone: 92,
              onErrorTone: 6,
              onErrorContainerTone: 95,
              //
              surfaceTone: 6,
              onSurfaceTone: 95,
              onSurfaceVariantTone: 90,
              onInverseSurfaceTone: 10,
              outlineTone: 60,
              outlineVariantTone: 40,
              surfaceTintTone: 95,
              //
              primaryMinChroma: 60,
              secondaryMinChroma: 44,
              tertiaryMinChroma: 50,
              neutralChroma: 2,
              neutralVariantChroma: 4,
            );

  /// Creates a tonal palette setup that result in a color scheme that follows
  /// chroma of each used seed color. Useful for manual control of pop or low
  /// chromacity.
  ///
  /// Uses low surface tint and neutrals with medium chroma.
  /// Theme with surface tone 98, in light mode and very low
  /// chroma in neutrals light mode (2 and 4) and moderate in dark mode
  /// (3 and 6). Dark mode uses dark surface tone 6.
  factory FlexTones.chroma(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 40,
              primaryContainerTone: 80,
              onPrimaryContainerTone: 4,
              secondaryTone: 50,
              secondaryContainerTone: 92,
              onSecondaryContainerTone: 10,
              tertiaryTone: 50,
              tertiaryContainerTone: 95,
              onTertiaryContainerTone: 6,
              //
              surfaceTone: 99,
              onSurfaceTone: 4,
              onSurfaceVariantTone: 10,
              onInverseSurfaceTone: 98,
              inversePrimaryTone: 90,
              outlineTone: 30,
              outlineVariantTone: 70,
              surfaceTintTone: 30,
              //
              primaryMinChroma: 0,
              secondaryMinChroma: 0,
              tertiaryMinChroma: 0,
              neutralChroma: 2,
              neutralVariantChroma: 4,
            )
          : const FlexTones.dark(
              primaryTone: 80,
              onPrimaryTone: 12,
              primaryContainerTone: 40,
              onPrimaryContainerTone: 97,
              secondaryTone: 70,
              onSecondaryTone: 4,
              secondaryContainerTone: 50,
              onSecondaryContainerTone: 96,
              tertiaryTone: 87,
              onTertiaryTone: 5,
              onTertiaryContainerTone: 92,
              onErrorTone: 6,
              onErrorContainerTone: 95,
              //
              surfaceTone: 4,
              surfaceContainerLowestTone: 2,
              surfaceContainerLowTone: 6,
              onSurfaceTone: 95,
              onSurfaceVariantTone: 90,
              onInverseSurfaceTone: 10,
              outlineTone: 60,
              outlineVariantTone: 40,
              surfaceTintTone: 95,
              //
              primaryMinChroma: 0,
              secondaryMinChroma: 0,
              tertiaryMinChroma: 0,
              neutralChroma: 3,
              neutralVariantChroma: 6,
            );

  /// Returns a new [FlexTones] instance where on colors tones for all main on
  /// color tones, are set to be either pure white 100 or black 0, depending
  /// what is appropriate contrast for its color pair.
  ///
  /// This will make the seeded on colors for [onPrimary], [onPrimaryContainer],
  /// [onPrimaryFixed], [onPrimaryFixedVariant], [onSecondary],
  /// [onSecondaryContainer], [onSecondaryFixed], [onSecondaryFixedVariant],
  /// [onTertiary], [onTertiaryContainer], [onTertiaryFixed],
  /// [onTertiaryFixedVariant] as well as [onError] and [onErrorContainer] pure
  /// black or white, depending on need contrast, instead of the its chroma
  /// tinted black and white versions.
  ///
  /// This is a modifier, using copyWith, that can be used to change any
  /// existing or pre-made [FlexTones] config to not have any color tint in
  /// their seeded main **on** colors.
  ///
  /// The [useBW] flag is true by default, making the function effective.
  /// If set to false, the function is a no op and just returns the [FlexTones]
  /// object unmodified. This is typically used to control applying
  /// modifier via a controller.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones onMainsUseBW([bool useBW = true]) {
    // ignore: avoid_returning_this
    if (!useBW) return this;
    return copyWith(
      onPrimaryTone: primaryTone <= 60 ? 100 : 0,
      onPrimaryContainerTone: primaryContainerTone <= 60 ? 100 : 0,
      onPrimaryFixedTone: primaryFixedTone <= 60 ? 100 : 0,
      onPrimaryFixedVariantTone: primaryFixedDimTone <= 60 ? 100 : 0,
      onSecondaryTone: secondaryTone <= 60 ? 100 : 0,
      onSecondaryContainerTone: secondaryContainerTone <= 60 ? 100 : 0,
      onSecondaryFixedTone: secondaryFixedTone <= 60 ? 100 : 0,
      onSecondaryFixedVariantTone: secondaryFixedDimTone <= 60 ? 100 : 0,
      onTertiaryTone: tertiaryTone <= 60 ? 100 : 0,
      onTertiaryContainerTone: tertiaryContainerTone <= 60 ? 100 : 0,
      onTertiaryFixedTone: tertiaryFixedTone <= 60 ? 100 : 0,
      onTertiaryFixedVariantTone: tertiaryFixedDimTone <= 60 ? 100 : 0,
      onErrorTone: errorTone <= 60 ? 100 : 0,
      onErrorContainerTone: errorContainerTone <= 60 ? 100 : 0,
    );
  }

  /// Returns a new [FlexTones] instance where on colors tones for all main on
  /// color tones, are set to be either pure white 100 or black 0, depending
  /// what is appropriate contrast for its color pair.
  ///
  /// This will make the seeded on colors for [onBackground], [onSurface],
  /// [onSurfaceVariant], and [onInverseSurface] pure black or
  /// white, depending on need contrast, instead of tinted black and white.
  ///
  /// This is a modifier, using copyWith, that can be used to change any
  /// existing or pre-made [FlexTones] config to not have any color tint in
  /// their seeded main **on** colors.
  ///
  /// The [useBW] flag is true by default, making the function effective.
  /// If set to false, the function is a no op and just returns the [FlexTones]
  /// object unmodified. This is typically used to control applying
  /// modifier via a controller.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones onSurfacesUseBW([bool useBW = true]) {
    // ignore: avoid_returning_this
    if (!useBW) return this;
    return copyWith(
      onSurfaceTone: surfaceTone <= 60 ? 100 : 0,
      onSurfaceVariantTone: surfaceTone <= 60 ? 100 : 0,
      onInverseSurfaceTone: inverseSurfaceTone <= 60 ? 100 : 0,
    );
  }

  /// Returns a new [FlexTones] instance where the tones for surface are
  /// set 0 (black) if it was <= 60 and to 100 (white) if > 60.
  ///
  /// This will make the seeded color for [surface] pure
  /// black or white, depending on if it is dark or light theme.
  ///
  /// This is a modifier, using copyWith, that can be used to change any
  /// existing or pre-made [FlexTones] config to not have any color tint in
  /// their seeded [surface] color.
  ///
  /// The [useBW] flag is true by default, making the function effective.
  /// If set to false, the function is a no op and just returns the [FlexTones]
  /// object unmodified. This is typically used to control applying
  /// modifier via a controller.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones surfacesUseBW([bool useBW = true]) {
    // ignore: avoid_returning_this
    if (!useBW) return this;
    return copyWith(
      surfaceTone: surfaceTone <= 60 ? 0 : 100,
    );
  }

  /// Returns a new [FlexTones] instance where the neutral and neutral variant
  /// chrome is set to 0. This will result in that regardless of the seed color
  /// the neutral and neutral variant tonal colors will be a pure grey scale
  /// without any chromacity in them. Resulting in surface colors with no color
  /// tint in them.
  ///
  /// The [useMonochrome] flag is true by default, making the function
  /// effective. If set to false, the function is a no op and just returns the
  /// [FlexTones] object unmodified. This is typically used to control applying
  /// modifier via a controller.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones monochromeSurfaces([bool useMonochrome = true]) {
    // ignore: avoid_returning_this
    if (!useMonochrome) return this;
    return copyWith(
      neutralChroma: 0,
      neutralMinChroma: 0,
      neutralVariantChroma: 0,
      neutralVariantMinChroma: 0,
    );
  }

  /// Returns a new [FlexTones] instance where the tones for light mode on
  /// container tones are set to 30 if they are 10. This gives us more
  /// color expressive container text and icons on none surface containers.
  ///
  /// This [FlexTones] modifier only impacts none surface on-container tones
  /// that are dark and thus only has any impact on the light theme mode
  /// on-container colors.
  ///
  /// The impacted on container colors are [onPrimaryContainerTone],
  /// [onSecondaryContainerTone], [onTertiaryContainerTone] and
  /// [onErrorContainerTone].
  ///
  /// This feature brings optional light mode expressive on container colors to
  /// any predefined or custom [FlexTones] configuration.
  ///
  /// These expressive on color in light mode containers are a change
  /// to the Material Design 3 ColorScheme. It was introduced in Material Color
  /// Utilities (MCU) package v0.12.0.
  ///
  /// This modifier is equivalent to setting the
  /// [SeedColorScheme.fromSeeds] and its [useExpressiveOnContainerColors] to
  /// true when using MCU dynamic scheme variant based seeded color schemes.
  ///
  /// The [useExpressive] flag is true by default, making the function
  /// effective. If set to false, the function is a no op and just returns the
  /// [FlexTones] object unmodified. This is typically used to control applying
  /// the modifier via a controller. There is also an early no op exit
  /// if the onPrimaryContainerTone is > 60, indicating that this is a dark
  /// theme and the modifier should not have any effect.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones expressiveOnContainer([bool useExpressive = true]) {
    if ((!useExpressive) || (onPrimaryContainerTone > 60)) return this;
    return copyWith(
      onPrimaryContainerTone:
          onPrimaryContainerTone == 10 ? 30 : onPrimaryContainerTone,
      onSecondaryContainerTone:
          onSecondaryContainerTone == 10 ? 30 : onSecondaryContainerTone,
      onTertiaryContainerTone:
          onTertiaryContainerTone == 10 ? 30 : onTertiaryContainerTone,
      onErrorContainerTone:
          onErrorContainerTone == 10 ? 30 : onErrorContainerTone,
    );
  }

  /// Returns a new [FlexTones] instance where the tones for all fixed colors
  /// are modified.
  ///
  /// This modifier can be applied to any predefined or custom
  /// [FlexTones] to make a returned instance where the tones for
  /// the fixed colors `fixed`, `onFixed`, `fixedDim`, `onFixedVariant` are
  /// set to 92, 6, 84, 12 instead Material-3 designs specified 90, 10, 80, 30.
  ///
  /// This gives us an alternative set of fixed colors with more contrast.
  ///
  /// **NOTE**: If some [FlexTones] modifiers change same properties, the used
  /// order in which they are applied matters. The last one applied will be
  /// the one that is used.
  FlexTones higherContrastFixed([bool useHigherContrast = true]) {
    // ignore: avoid_returning_this
    if (!useHigherContrast) return this;
    return copyWith(
      primaryFixedTone: 92,
      primaryFixedDimTone: 84,
      onPrimaryFixedTone: 6,
      onPrimaryFixedVariantTone: 12,
      //
      secondaryFixedTone: 92,
      secondaryFixedDimTone: 84,
      onSecondaryFixedTone: 6,
      onSecondaryFixedVariantTone: 12,
      //
      tertiaryFixedTone: 92,
      tertiaryFixedDimTone: 84,
      onTertiaryFixedTone: 6,
      onTertiaryFixedVariantTone: 12,
    );
  }

  /// Tone used for [ColorScheme.primary] from primary [FlexTonalPalette].
  final int primaryTone;

  /// Tone used for [ColorScheme.onPrimary] from primary [FlexTonalPalette].
  final int onPrimaryTone;

  /// Tone used for [ColorScheme.primaryContainer] from primary
  /// [FlexTonalPalette].
  final int primaryContainerTone;

  /// Tone used for [ColorScheme.onPrimaryContainer] from primary
  /// [FlexTonalPalette].
  final int onPrimaryContainerTone;

  /// Tone used for [ColorScheme.primaryFixed] from primary [FlexTonalPalette].
  final int primaryFixedTone;

  /// Tone used for [ColorScheme.primaryFixedDim] from primary
  /// [FlexTonalPalette].
  final int primaryFixedDimTone;

  /// Tone used for [ColorScheme.onPrimaryFixed] from primary
  /// [FlexTonalPalette].
  final int onPrimaryFixedTone;

  /// Tone used for [ColorScheme.onPrimaryFixedVariant] from primary
  /// [FlexTonalPalette].
  final int onPrimaryFixedVariantTone;

  /// Tone used for [ColorScheme.secondary] from secondary [FlexTonalPalette].
  final int secondaryTone;

  /// Tone used for [ColorScheme.onSecondary] from secondary [FlexTonalPalette].
  final int onSecondaryTone;

  /// Tone used for [ColorScheme.secondaryContainer] from secondary
  /// [FlexTonalPalette].
  final int secondaryContainerTone;

  /// Tone used for [ColorScheme.onSecondaryContainer] from secondary
  /// [FlexTonalPalette].
  final int onSecondaryContainerTone;

  /// Tone used for [ColorScheme.secondaryFixed] from secondary
  /// [FlexTonalPalette].
  final int secondaryFixedTone;

  /// Tone used for [ColorScheme.secondaryFixedDim] from secondary
  /// [FlexTonalPalette].
  final int secondaryFixedDimTone;

  /// Tone used for [ColorScheme.secondaryFixed] from secondary
  /// [FlexTonalPalette].
  final int onSecondaryFixedTone;

  /// Tone used for [ColorScheme.onSecondaryFixedVariant] from secondary
  /// [FlexTonalPalette].
  final int onSecondaryFixedVariantTone;

  /// Tone used for [ColorScheme.tertiary] from tertiary [FlexTonalPalette].
  final int tertiaryTone;

  /// Tone used for [ColorScheme.onTertiary] from tertiary [FlexTonalPalette].
  final int onTertiaryTone;

  /// Tone used for [ColorScheme.tertiaryContainer] from tertiary
  /// [FlexTonalPalette].
  final int tertiaryContainerTone;

  /// Tone used for [ColorScheme.onTertiaryContainer] from tertiary
  /// [FlexTonalPalette].
  final int onTertiaryContainerTone;

  /// Tone used for [ColorScheme.tertiaryFixed] from tertiary
  /// [FlexTonalPalette].
  final int tertiaryFixedTone;

  /// Tone used for [ColorScheme.tertiaryFixedDim] from tertiary
  /// [FlexTonalPalette].
  final int tertiaryFixedDimTone;

  /// Tone used for [ColorScheme.onTertiaryFixed] from tertiary
  /// [FlexTonalPalette].
  final int onTertiaryFixedTone;

  /// Tone used for [ColorScheme.onTertiaryFixedVariant] from tertiary
  /// [FlexTonalPalette].
  final int onTertiaryFixedVariantTone;

  /// Tone used for [ColorScheme.error] from error [FlexTonalPalette].
  final int errorTone;

  /// Tone used for [ColorScheme.onError] from error [FlexTonalPalette].
  final int onErrorTone;

  /// Tone used for [ColorScheme.errorContainer] from error [FlexTonalPalette].
  final int errorContainerTone;

  /// Tone used for [ColorScheme.onErrorContainer] from error
  /// [FlexTonalPalette].
  final int onErrorContainerTone;

  /// Tone used for [ColorScheme.surface] from neutral [FlexTonalPalette].
  final int surfaceTone;

  /// Tone used for [ColorScheme.surfaceDim] from neutral [FlexTonalPalette].
  final int surfaceDimTone;

  /// Tone used for [ColorScheme.surfaceBright] from neutral [FlexTonalPalette].
  final int surfaceBrightTone;

  /// Tone used for [ColorScheme.surfaceContainerLowest] from neutral
  /// [FlexTonalPalette].
  final int surfaceContainerLowestTone;

  /// Tone used for [ColorScheme.surfaceContainerLow] from neutral
  /// [FlexTonalPalette].
  final int surfaceContainerLowTone;

  /// Tone used for [ColorScheme.surfaceContainer] from neutral
  /// [FlexTonalPalette].
  final int surfaceContainerTone;

  /// Tone used for [ColorScheme.surfaceContainerHigh] from neutral
  /// [FlexTonalPalette].
  final int surfaceContainerHighTone;

  /// Tone used for [ColorScheme.surfaceContainerHighest] from neutral
  /// [FlexTonalPalette].
  final int surfaceContainerHighestTone;

  /// Tone used for [ColorScheme.onSurface] from neutral [FlexTonalPalette].
  final int onSurfaceTone;

  /// Tone used for [ColorScheme.onSurfaceVariant] from neutralVariant
  /// [FlexTonalPalette].
  final int onSurfaceVariantTone;

  /// Tone used for [ColorScheme.outline] from neutralVariant
  /// [FlexTonalPalette].
  final int outlineTone;

  /// Tone used for [ColorScheme.outlineVariant] from neutralVariant
  /// [FlexTonalPalette].
  final int outlineVariantTone;

  /// Tone used for [ColorScheme.shadow] from neutral [FlexTonalPalette].
  final int shadowTone;

  /// Tone used for [ColorScheme.scrim] from neutral [FlexTonalPalette].
  final int scrimTone;

  /// Tone used for [ColorScheme.inverseSurface] from neutral
  /// [FlexTonalPalette].
  final int inverseSurfaceTone;

  /// Tone used for [ColorScheme.onInverseSurface] from neutral
  /// [FlexTonalPalette].
  final int onInverseSurfaceTone;

  /// Tone used for [ColorScheme.inversePrimary] from primary
  /// [FlexTonalPalette].
  final int inversePrimaryTone;

  /// Tone used for [ColorScheme.surfaceTint] from primary [FlexTonalPalette].
  final int surfaceTintTone;

  // Deprecated colors.

  /// Tone used for ColorScheme background from neutral [FlexTonalPalette].
  @Deprecated('Use surfaceTone instead.')
  final int? backgroundTone;

  /// Tone used for ColorScheme onBackground from neutral [FlexTonalPalette].
  @Deprecated('Use onSurfaceTone instead.')
  final int? onBackgroundTone;

  /// Tone used for ColorScheme surfaceVariant from neutralVariant
  /// [FlexTonalPalette].
  @Deprecated('Use surfaceContainerHighestTone instead.')
  final int? surfaceVariantTone;

  /// Cam16 chroma value to use for primary colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used primary seed key color is used,
  /// if it is larger than [primaryMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses "null", with a [primaryMinChroma]
  /// set to 48, so the chroma from the key color is used when above 48, but
  /// never lower than 48. This keeps primary color at the used tonal values
  /// reasonably vivid and usable regardless of uses primary key color.
  ///
  /// Defaults to null, and chroma from primary seed key is used for chroma,
  /// if it is over [primaryMinChroma].
  final double? primaryChroma;

  /// The minimum used chroma value.
  ///
  /// If chroma in provided primary key color is below this value, or if a
  /// fixed [primaryChroma] is provided that is lower than [primaryMinChroma]
  /// then the [primaryMinChroma] value is used.
  ///
  /// Flutter SDK uses 48 via a hard coded value and design.
  ///
  /// If not defined, defaults to 48.
  final double? primaryMinChroma;

  /// Cam16 chroma value to use for secondary colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used secondary seed key color is used,
  /// if it is larger than [secondaryMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses [secondaryChroma] hard coded
  /// and locked to 16.
  ///
  /// The Material 3 default produces quite soft and muted tones as secondary
  /// tonal palette at the mid-point tones of the palette.
  ///
  /// By adjusting [secondaryChroma] and/or [secondaryMinChroma] you can change
  /// this. The color system usage of the secondary colors in Material 3 is
  /// pretty strict from a design point of view. For default widget coloring
  /// to work and look as intended it is recommended to keep secondary color
  /// close in hue, or same as primary, with a lower chroma value
  /// (less colorful). You can certainly vary the hue a bit and make it a bit
  /// more colorful then Material 3 design defaults.
  final double? secondaryChroma;

  /// The minimum used chroma value.
  ///
  /// If chroma in provided secondary key color is below this value, or if a
  /// fixed [secondaryChroma] is provided that is lower than
  /// [secondaryMinChroma] then the [secondaryMinChroma] value is used.
  ///
  /// Flutter SDK only uses [secondaryChroma] hard coded to 16, and has no
  /// concept of minimum level for secondary tonal palettes as its value is
  /// always locked to 16.
  ///
  /// If not defined, defaults to 16.
  final double? secondaryMinChroma;

  /// Cam16 chroma value to use for tertiary colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used tertiary seed key color is used,
  /// if it is larger than [tertiaryMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses [tertiaryChroma] hard coded
  /// and locked to 24. This produces slightly less colorful colors than primary
  /// tones for tertiary tonal palette at the mid-point tones of the palette.
  /// They are a lot less muted than the default secondary tonal palette, but
  /// not as bright as primary.
  ///
  /// By adjusting [tertiaryChroma] and/or [tertiaryMinChroma] you can change
  /// this. The color system usage of the tertiary colors in Material 3 is
  /// pretty lenient and work well with brighter colors too on tertiary.
  final double? tertiaryChroma;

  /// The minimum used chroma value.
  ///
  /// If chroma in provided tertiary key color is below this value, or if a
  /// fixed [tertiaryChroma] is provided that is lower than
  /// [tertiaryMinChroma] then the [tertiaryMinChroma] value is used.
  ///
  /// Flutter SDK only uses [tertiaryChroma] hard coded to 24, and has no
  /// concept of minimum level for tertiary tonal palettes as its value is
  /// always locked to 24.
  ///
  /// If not defined, defaults to 24.
  final double? tertiaryMinChroma;

  /// The number of degrees to rotate Hue to use to get hue from primary
  /// color's Hue, used as base with rotated amount of degrees provided.
  ///
  /// This is only used when [tertiary] ARGB key color is null and we have
  /// no specified Hue input for tertiary key color.
  ///
  /// When used and if not defined, defaults to 60 degrees.
  final double? tertiaryHueRotation;

  /// Cam16 chroma value to use for error colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used error seed key color is used,
  /// if it is larger than [errorMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses [errorChroma] from
  /// FlexTonalPalette.of(25, 84) as its define 84 value.
  ///
  /// If not defined and no error key color is defined, [errorChroma] defaults
  /// to 84, like in Material 3 defaults.
  final double? errorChroma;

  /// The minimum used error chroma value.
  ///
  /// If chroma in provided error key color is below this value, or if a
  /// fixed [errorChroma] is provided that is lower than
  /// [errorMinChroma] then the [errorMinChroma] value is used.
  ///
  /// Flutter SDK only uses [errorChroma] hard coded to 84, and has no
  /// concept of minimum level for error tonal palettes as its value is
  /// always locked to 84.
  ///
  /// If not defined defaults to 0, and chroma in [errorChroma] is used.
  final double? errorMinChroma;

  /// Cam16 chroma value to use for neutral colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used neutral seed key color is used,
  /// if it is larger than [neutralMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses [neutralChroma] hard coded
  /// and locked to 4.
  ///
  /// If not defined, defaults to 4.
  final double? neutralChroma;

  /// The minimum used neutral chroma value.
  ///
  /// If chroma in provided neutral key color is below this value, or if a
  /// fixed [neutralChroma] is provided that is lower than
  /// [neutralMinChroma], then the [neutralMinChroma] value is used.
  ///
  /// Flutter SDK only uses [neutralChroma] hard coded to 4, and has no
  /// concept of minimum level for neutral tonal palettes as its value is
  /// always locked to 4.
  ///
  /// If not defined defaults to 0, and chroma in [neutralChroma] is used.
  final double? neutralMinChroma;

  /// Cam16 chroma value to use for neutral colors [FlexTonalPalette]
  /// generation.
  ///
  /// If null, the chroma value from the used neutral variant seed key color is
  /// used, if it is larger than [neutralVariantMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses [neutralVariantChroma] hard
  /// coded and locked to 8.
  final double? neutralVariantChroma;

  /// The minimum used neutral variant chroma value.
  ///
  /// If chroma in provided neutral variant key color is below this value, or
  /// if a fixed [neutralVariantChroma] is provided that is lower than
  /// [neutralVariantMinChroma], then the [neutralVariantMinChroma] value is
  /// used.
  ///
  /// Flutter SDK only uses [neutralVariantChroma] hard coded to 8, and has no
  /// concept of minimum level for neutral variant tonal palettes as its value
  /// is always locked to 8.
  ///
  /// If not defined defaults to 0, chroma in [neutralVariantChroma] is used.
  final double? neutralVariantMinChroma;

  /// Defines what [FlexPaletteType] this [FlexTones] uses.
  ///
  /// The default is [FlexPaletteType.extended] with 26 tones or optionally use
  /// the legacy [FlexPaletteType.common] with 15 tones.
  ///
  /// To make color schemes with new Material3 mappings for light and dark
  /// surface colors, using the extended tone set is needed.
  ///
  /// In Flutter 3.19 and earlier the [ColorScheme] surface colors that
  /// need the new tones are not yet available. In Flutter 3.22 and later the
  /// new surface colors are available and the new tones are used. Due to this
  /// the [FlexPaletteType.extended] is now the new default. The
  /// [FlexPaletteType.common] may even be considered deprecated in the future,
  /// but is kept around for backwards code compatibility for a while.
  ///
  /// The added tones 4, 6, 12, 17, 22, 24 are for new dark mode surfaces in
  /// revised Material 3 dark surface colors. Likewise added tones
  /// 96, 94, 92, 87 are for light mode surfaces in the updated Material 3
  /// color system. For more information, see:
  /// https://m3.material.io/styles/color/the-color-system/color-roles
  /// The additional tones in the Material 3 specification appeared during later
  /// part of first half of 2023, and in Flutter 3.22.
  final FlexPaletteType paletteType;

  /// If true, the CAM16 color space is used to define the HCT color, if
  /// false simpler and faster HCT from int is used.
  ///
  /// Prior to version 2.0.0 of this package, the CAM16 color space was always
  /// used. However, in Flutter 3.22 the HCT vanilla HCT.fromInt is used
  /// for its seeded scheme colors.It is used here by the Material3
  /// style seeded color schemes as well, while the FSS ones continues to use
  /// Cam16.
  ///
  /// Defaults to true.
  final bool useCam16;

  /// Copy the object with one or more provided properties changed.
  FlexTones copyWith({
    int? primaryTone,
    int? onPrimaryTone,
    int? primaryContainerTone,
    int? onPrimaryContainerTone,
    int? primaryFixedTone,
    int? primaryFixedDimTone,
    int? onPrimaryFixedTone,
    int? onPrimaryFixedVariantTone,
    //
    int? secondaryTone,
    int? onSecondaryTone,
    int? secondaryContainerTone,
    int? onSecondaryContainerTone,
    int? secondaryFixedTone,
    int? secondaryFixedDimTone,
    int? onSecondaryFixedTone,
    int? onSecondaryFixedVariantTone,
    //
    int? tertiaryTone,
    int? onTertiaryTone,
    int? tertiaryContainerTone,
    int? onTertiaryContainerTone,
    int? tertiaryFixedTone,
    int? tertiaryFixedDimTone,
    int? onTertiaryFixedTone,
    int? onTertiaryFixedVariantTone,
    //
    int? errorTone,
    int? onErrorTone,
    int? errorContainerTone,
    int? onErrorContainerTone,
    //
    int? surfaceTone,
    int? surfaceDimTone,
    int? surfaceBrightTone,
    int? surfaceContainerLowestTone,
    int? surfaceContainerLowTone,
    int? surfaceContainerTone,
    int? surfaceContainerHighTone,
    int? surfaceContainerHighestTone,
    int? onSurfaceTone,
    int? onSurfaceVariantTone,
    //
    int? outlineTone,
    int? outlineVariantTone,
    int? shadowTone,
    int? scrimTone,
    int? inverseSurfaceTone,
    int? onInverseSurfaceTone,
    int? inversePrimaryTone,
    int? surfaceTintTone,
    @Deprecated('Use surfaceTone instead.') int? backgroundTone,
    @Deprecated('Use onSurfaceTone instead.') int? onBackgroundTone,
    @Deprecated('Use surfaceContainerHighestTone instead.')
    int? surfaceVariantTone,
    //
    double? primaryChroma,
    double? primaryMinChroma,
    double? secondaryChroma,
    double? secondaryMinChroma,
    double? tertiaryChroma,
    double? tertiaryMinChroma,
    double? tertiaryHueRotation,
    double? errorChroma,
    double? errorMinChroma,
    double? neutralChroma,
    double? neutralMinChroma,
    double? neutralVariantChroma,
    double? neutralVariantMinChroma,
    FlexPaletteType? paletteType,
  }) {
    return FlexTones(
      primaryTone: primaryTone ?? this.primaryTone,
      onPrimaryTone: onPrimaryTone ?? this.onPrimaryTone,
      primaryContainerTone: primaryContainerTone ?? this.primaryContainerTone,
      onPrimaryContainerTone:
          onPrimaryContainerTone ?? this.onPrimaryContainerTone,
      primaryFixedTone: primaryFixedTone ?? this.primaryFixedTone,
      primaryFixedDimTone: primaryFixedDimTone ?? this.primaryFixedDimTone,
      onPrimaryFixedTone: onPrimaryFixedTone ?? this.onPrimaryFixedTone,
      onPrimaryFixedVariantTone:
          onPrimaryFixedVariantTone ?? this.onPrimaryFixedVariantTone,
      //
      secondaryTone: secondaryTone ?? this.secondaryTone,
      onSecondaryTone: onSecondaryTone ?? this.onSecondaryTone,
      secondaryContainerTone:
          secondaryContainerTone ?? this.secondaryContainerTone,
      onSecondaryContainerTone:
          onSecondaryContainerTone ?? this.onSecondaryContainerTone,
      secondaryFixedTone: secondaryFixedTone ?? this.secondaryFixedTone,
      secondaryFixedDimTone:
          secondaryFixedDimTone ?? this.secondaryFixedDimTone,
      onSecondaryFixedTone: onSecondaryFixedTone ?? this.onSecondaryFixedTone,
      onSecondaryFixedVariantTone:
          onSecondaryFixedVariantTone ?? this.onSecondaryFixedVariantTone,
      //
      tertiaryTone: tertiaryTone ?? this.tertiaryTone,
      onTertiaryTone: onTertiaryTone ?? this.onTertiaryTone,
      tertiaryContainerTone:
          tertiaryContainerTone ?? this.tertiaryContainerTone,
      onTertiaryContainerTone:
          onTertiaryContainerTone ?? this.onTertiaryContainerTone,
      tertiaryFixedTone: tertiaryFixedTone ?? this.tertiaryFixedTone,
      tertiaryFixedDimTone: tertiaryFixedDimTone ?? this.tertiaryFixedDimTone,
      onTertiaryFixedTone: onTertiaryFixedTone ?? this.onTertiaryFixedTone,
      onTertiaryFixedVariantTone:
          onTertiaryFixedVariantTone ?? this.onTertiaryFixedVariantTone,
      //
      errorTone: errorTone ?? this.errorTone,
      onErrorTone: onErrorTone ?? this.onErrorTone,
      errorContainerTone: errorContainerTone ?? this.errorContainerTone,
      onErrorContainerTone: onErrorContainerTone ?? this.onErrorContainerTone,
      //
      surfaceTone: surfaceTone ?? this.surfaceTone,
      surfaceDimTone: surfaceDimTone ?? this.surfaceDimTone,
      surfaceBrightTone: surfaceBrightTone ?? this.surfaceBrightTone,
      surfaceContainerLowestTone:
          surfaceContainerLowestTone ?? this.surfaceContainerLowestTone,
      surfaceContainerLowTone:
          surfaceContainerLowTone ?? this.surfaceContainerLowTone,
      surfaceContainerTone: surfaceContainerTone ?? this.surfaceContainerTone,
      surfaceContainerHighTone:
          surfaceContainerHighTone ?? this.surfaceContainerHighTone,
      surfaceContainerHighestTone:
          surfaceContainerHighestTone ?? this.surfaceContainerHighestTone,
      onSurfaceTone: onSurfaceTone ?? this.onSurfaceTone,
      onSurfaceVariantTone: onSurfaceVariantTone ?? this.onSurfaceVariantTone,
      //
      outlineTone: outlineTone ?? this.outlineTone,
      outlineVariantTone: outlineVariantTone ?? this.outlineVariantTone,
      shadowTone: shadowTone ?? this.shadowTone,
      scrimTone: scrimTone ?? this.scrimTone,
      inverseSurfaceTone: inverseSurfaceTone ?? this.inverseSurfaceTone,
      onInverseSurfaceTone: onInverseSurfaceTone ?? this.onInverseSurfaceTone,
      inversePrimaryTone: inversePrimaryTone ?? this.inversePrimaryTone,
      surfaceTintTone: surfaceTintTone ?? this.surfaceTintTone,
      //
      primaryChroma: primaryChroma ?? this.primaryChroma,
      primaryMinChroma: primaryMinChroma ?? this.primaryMinChroma,
      secondaryChroma: secondaryChroma ?? this.secondaryChroma,
      secondaryMinChroma: secondaryMinChroma ?? this.secondaryMinChroma,
      tertiaryChroma: tertiaryChroma ?? this.tertiaryChroma,
      tertiaryMinChroma: tertiaryMinChroma ?? this.tertiaryMinChroma,
      tertiaryHueRotation: tertiaryHueRotation ?? this.tertiaryHueRotation,
      errorChroma: errorChroma ?? this.errorChroma,
      errorMinChroma: errorMinChroma ?? this.errorMinChroma,
      neutralChroma: neutralChroma ?? this.neutralChroma,
      neutralMinChroma: neutralMinChroma ?? this.neutralMinChroma,
      neutralVariantChroma: neutralVariantChroma ?? this.neutralVariantChroma,
      neutralVariantMinChroma:
          neutralVariantMinChroma ?? this.neutralVariantMinChroma,
      paletteType: paletteType ?? this.paletteType,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FlexTones &&
        other.primaryTone == primaryTone &&
        other.onPrimaryTone == onPrimaryTone &&
        other.primaryContainerTone == primaryContainerTone &&
        other.onPrimaryContainerTone == onPrimaryContainerTone &&
        other.primaryFixedTone == primaryFixedTone &&
        other.primaryFixedDimTone == primaryFixedDimTone &&
        other.onPrimaryFixedTone == onPrimaryFixedTone &&
        other.onPrimaryFixedVariantTone == onPrimaryFixedVariantTone &&
        //
        other.secondaryTone == secondaryTone &&
        other.onSecondaryTone == onSecondaryTone &&
        other.secondaryContainerTone == secondaryContainerTone &&
        other.onSecondaryContainerTone == onSecondaryContainerTone &&
        other.secondaryFixedTone == secondaryFixedTone &&
        other.secondaryFixedDimTone == secondaryFixedDimTone &&
        other.onSecondaryFixedTone == onSecondaryFixedTone &&
        other.onSecondaryFixedVariantTone == onSecondaryFixedVariantTone &&
        //
        other.tertiaryTone == tertiaryTone &&
        other.onTertiaryTone == onTertiaryTone &&
        other.tertiaryContainerTone == tertiaryContainerTone &&
        other.onTertiaryContainerTone == onTertiaryContainerTone &&
        other.tertiaryFixedTone == tertiaryFixedTone &&
        other.tertiaryFixedDimTone == tertiaryFixedDimTone &&
        other.onTertiaryFixedTone == onTertiaryFixedTone &&
        other.onTertiaryFixedVariantTone == onTertiaryFixedVariantTone &&
        //
        other.errorTone == errorTone &&
        other.onErrorTone == onErrorTone &&
        other.errorContainerTone == errorContainerTone &&
        other.onErrorContainerTone == onErrorContainerTone &&
        //
        other.surfaceTone == surfaceTone &&
        other.surfaceDimTone == surfaceDimTone &&
        other.surfaceBrightTone == surfaceBrightTone &&
        other.surfaceContainerLowestTone == surfaceContainerLowestTone &&
        other.surfaceContainerLowTone == surfaceContainerLowTone &&
        other.surfaceContainerTone == surfaceContainerTone &&
        other.surfaceContainerHighTone == surfaceContainerHighTone &&
        other.surfaceContainerHighestTone == surfaceContainerHighestTone &&
        other.onSurfaceTone == onSurfaceTone &&
        other.onSurfaceVariantTone == onSurfaceVariantTone &&
        //
        other.outlineTone == outlineTone &&
        other.outlineVariantTone == outlineVariantTone &&
        other.shadowTone == shadowTone &&
        other.scrimTone == scrimTone &&
        other.inverseSurfaceTone == inverseSurfaceTone &&
        other.onInverseSurfaceTone == onInverseSurfaceTone &&
        other.inversePrimaryTone == inversePrimaryTone &&
        other.surfaceTintTone == surfaceTintTone &&
        //
        other.primaryChroma == primaryChroma &&
        other.primaryMinChroma == primaryMinChroma &&
        other.secondaryChroma == secondaryChroma &&
        other.secondaryMinChroma == secondaryMinChroma &&
        other.tertiaryChroma == tertiaryChroma &&
        other.tertiaryMinChroma == tertiaryMinChroma &&
        other.tertiaryHueRotation == tertiaryHueRotation &&
        other.errorChroma == errorChroma &&
        other.errorMinChroma == errorMinChroma &&
        other.neutralChroma == neutralChroma &&
        other.neutralMinChroma == neutralMinChroma &&
        other.neutralVariantChroma == neutralVariantChroma &&
        other.neutralVariantMinChroma == neutralVariantMinChroma &&
        other.paletteType == paletteType;
  }

  /// Override for hashcode, dart.ui Jenkins based.
  @override
  int get hashCode => Object.hashAll(<Object?>[
        primaryTone,
        onPrimaryTone,
        primaryContainerTone,
        onPrimaryContainerTone,
        primaryFixedTone,
        primaryFixedDimTone,
        onPrimaryFixedTone,
        onPrimaryFixedVariantTone,
        //
        secondaryTone,
        onSecondaryTone,
        secondaryContainerTone,
        onSecondaryContainerTone,
        secondaryFixedTone,
        secondaryFixedDimTone,
        onSecondaryFixedTone,
        onSecondaryFixedVariantTone,
        //
        tertiaryTone,
        onTertiaryTone,
        tertiaryContainerTone,
        onTertiaryContainerTone,
        tertiaryFixedTone,
        tertiaryFixedDimTone,
        onTertiaryFixedTone,
        onTertiaryFixedVariantTone,
        //
        errorTone,
        onErrorTone,
        errorContainerTone,
        onErrorContainerTone,
        //
        surfaceTone,
        surfaceDimTone,
        surfaceBrightTone,
        surfaceContainerLowestTone,
        surfaceContainerLowTone,
        surfaceContainerTone,
        surfaceContainerHighTone,
        surfaceContainerHighestTone,
        onSurfaceTone,
        onSurfaceVariantTone,
        //
        outlineTone,
        outlineVariantTone,
        shadowTone,
        scrimTone,
        inverseSurfaceTone,
        onInverseSurfaceTone,
        inversePrimaryTone,
        surfaceTintTone,
        //
        primaryChroma,
        primaryMinChroma,
        secondaryChroma,
        secondaryMinChroma,
        tertiaryChroma,
        tertiaryMinChroma,
        tertiaryHueRotation,
        errorChroma,
        errorMinChroma,
        neutralChroma,
        neutralMinChroma,
        neutralVariantChroma,
        neutralVariantMinChroma,
        paletteType,
      ]);

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<int>('primaryTone', primaryTone));
    properties.add(DiagnosticsProperty<int>('onPrimaryTone', onPrimaryTone));
    properties.add(
        DiagnosticsProperty<int>('primaryContainerTone', primaryContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'onPrimaryContainerTone', onPrimaryContainerTone));
    properties
        .add(DiagnosticsProperty<int>('primaryFixedTone', primaryFixedTone));
    properties.add(
        DiagnosticsProperty<int>('primaryFixedDimTone', primaryFixedDimTone));
    properties.add(
        DiagnosticsProperty<int>('onPrimaryFixedTone', onPrimaryFixedTone));
    properties.add(DiagnosticsProperty<int>(
        'onPrimaryFixedVariantTone', onPrimaryFixedVariantTone));
    //
    properties.add(DiagnosticsProperty<int>('secondaryTone', secondaryTone));
    properties
        .add(DiagnosticsProperty<int>('onSecondaryTone', onSecondaryTone));
    properties.add(DiagnosticsProperty<int>(
        'secondaryContainerTone', secondaryContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'onSecondaryContainerTone', onSecondaryContainerTone));
    properties.add(
        DiagnosticsProperty<int>('secondaryFixedTone', secondaryFixedTone));
    properties.add(DiagnosticsProperty<int>(
        'secondaryFixedDimTone', secondaryFixedDimTone));
    properties.add(
        DiagnosticsProperty<int>('onSecondaryFixedTone', onSecondaryFixedTone));
    properties.add(DiagnosticsProperty<int>(
        'onSecondaryFixedVariantTone', onSecondaryFixedVariantTone));
    //
    properties.add(DiagnosticsProperty<int>('tertiaryTone', tertiaryTone));
    properties.add(DiagnosticsProperty<int>('onTertiaryTone', onTertiaryTone));
    properties.add(DiagnosticsProperty<int>(
        'tertiaryContainerTone', tertiaryContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'onTertiaryContainerTone', onTertiaryContainerTone));
    properties
        .add(DiagnosticsProperty<int>('tertiaryFixedTone', tertiaryFixedTone));
    properties.add(
        DiagnosticsProperty<int>('tertiaryFixedDimTone', tertiaryFixedDimTone));
    properties.add(
        DiagnosticsProperty<int>('onTertiaryFixedTone', onTertiaryFixedTone));
    properties.add(DiagnosticsProperty<int>(
        'onTertiaryFixedVariantTone', onTertiaryFixedVariantTone));
    //
    properties.add(DiagnosticsProperty<int>('errorTone', errorTone));
    properties.add(
        DiagnosticsProperty<int>('errorContainerTone', errorContainerTone));
    properties.add(
        DiagnosticsProperty<int>('onErrorContainerTone', onErrorContainerTone));
    //
    properties.add(DiagnosticsProperty<int>('surfaceTone', surfaceTone));
    properties.add(DiagnosticsProperty<int>('surfaceDimTone', surfaceDimTone));
    properties
        .add(DiagnosticsProperty<int>('surfaceBrightTone', surfaceBrightTone));
    properties.add(DiagnosticsProperty<int>(
        'surfaceContainerLowestTone', surfaceContainerLowestTone));
    properties.add(DiagnosticsProperty<int>(
        'surfaceContainerLowTone', surfaceContainerLowTone));
    properties.add(
        DiagnosticsProperty<int>('surfaceContainerTone', surfaceContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'surfaceContainerHighTone', surfaceContainerHighTone));
    properties.add(DiagnosticsProperty<int>(
        'surfaceContainerHighestTone', surfaceContainerHighestTone));

    properties.add(DiagnosticsProperty<int>('onSurfaceTone', onSurfaceTone));
    properties.add(
        DiagnosticsProperty<int>('onSurfaceVariantTone', onSurfaceVariantTone));
    //
    properties.add(DiagnosticsProperty<int>('outlineTone', outlineTone));
    properties.add(
        DiagnosticsProperty<int>('outlineVariantTone', outlineVariantTone));
    properties.add(DiagnosticsProperty<int>('shadowTone', shadowTone));
    properties.add(DiagnosticsProperty<int>('scrimTone', scrimTone));
    properties.add(
        DiagnosticsProperty<int>('inverseSurfaceTone', inverseSurfaceTone));
    properties.add(
        DiagnosticsProperty<int>('onInverseSurfaceTone', onInverseSurfaceTone));
    properties.add(
        DiagnosticsProperty<int>('inversePrimaryTone', inversePrimaryTone));
    properties
        .add(DiagnosticsProperty<int>('surfaceTintTone', surfaceTintTone));
    properties.add(DiagnosticsProperty<double>('primaryChroma', primaryChroma));
    properties
        .add(DiagnosticsProperty<double>('primaryMinChroma', primaryMinChroma));
    properties
        .add(DiagnosticsProperty<double>('secondaryChroma', secondaryChroma));
    properties.add(
        DiagnosticsProperty<double>('secondaryMinChroma', secondaryMinChroma));
    properties
        .add(DiagnosticsProperty<double>('tertiaryChroma', tertiaryChroma));
    properties.add(DiagnosticsProperty<double>(
        'tertiaryHueRotation', tertiaryHueRotation));
    properties.add(
        DiagnosticsProperty<double>('tertiaryMinChroma', tertiaryMinChroma));
    properties.add(DiagnosticsProperty<double>('errorChroma', errorChroma));
    properties
        .add(DiagnosticsProperty<double>('errorMinChroma', errorMinChroma));
    properties.add(DiagnosticsProperty<double>('neutralChroma', neutralChroma));
    properties
        .add(DiagnosticsProperty<double>('neutralMinChroma', neutralMinChroma));
    properties.add(DiagnosticsProperty<double>(
        'neutralVariantChroma', neutralVariantChroma));
    properties.add(DiagnosticsProperty<double>(
        'neutralVariantMinChroma', neutralVariantMinChroma));
    properties.add(EnumProperty<FlexPaletteType>('paletteType', paletteType));
  }
}
