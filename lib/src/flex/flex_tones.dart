import 'package:flutter/foundation.dart';

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
/// * [FlexTones.material], default and same as Flutter SDK M3 setup.
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
/// in a few select cases. Avoid going any further than that with any default
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
    required this.secondaryTone,
    required this.onSecondaryTone,
    required this.secondaryContainerTone,
    required this.onSecondaryContainerTone,
    required this.tertiaryTone,
    required this.onTertiaryTone,
    required this.tertiaryContainerTone,
    required this.onTertiaryContainerTone,
    required this.errorTone,
    required this.onErrorTone,
    required this.errorContainerTone,
    required this.onErrorContainerTone,
    required this.backgroundTone,
    required this.onBackgroundTone,
    required this.surfaceTone,
    required this.onSurfaceTone,
    required this.surfaceVariantTone,
    required this.onSurfaceVariantTone,
    required this.outlineTone,
    required this.outlineVariantTone,
    required this.shadowTone,
    required this.scrimTone,
    required this.inverseSurfaceTone,
    required this.onInverseSurfaceTone,
    required this.inversePrimaryTone,
    required this.surfaceTintTone,
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
  });

  /// Create an M3 standard light tonal palette tones extraction setup.
  ///
  /// This setup is almost identical to the default that you get if only
  /// one seed color is used, as you get with Flutter when it uses
  /// [Scheme.light] and [ColorPalette.of]. The difference is
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
  const FlexTones.light({
    this.primaryTone = 40,
    this.onPrimaryTone = 100,
    this.primaryContainerTone = 90,
    this.onPrimaryContainerTone = 10,
    this.secondaryTone = 40,
    this.onSecondaryTone = 100,
    this.secondaryContainerTone = 90,
    this.onSecondaryContainerTone = 10,
    this.tertiaryTone = 40,
    this.onTertiaryTone = 100,
    this.tertiaryContainerTone = 90,
    this.onTertiaryContainerTone = 10,
    this.errorTone = 40,
    this.onErrorTone = 100,
    this.errorContainerTone = 90,
    this.onErrorContainerTone = 10,
    this.backgroundTone = 99,
    this.onBackgroundTone = 10,
    this.surfaceTone = 99,
    this.onSurfaceTone = 10,
    this.surfaceVariantTone = 90,
    this.onSurfaceVariantTone = 30,
    this.outlineTone = 50,
    this.outlineVariantTone = 80,
    this.shadowTone = 0,
    this.scrimTone = 0,
    this.inverseSurfaceTone = 20,
    this.onInverseSurfaceTone = 95,
    this.inversePrimaryTone = 80,
    this.surfaceTintTone = 40,
    this.primaryChroma,
    this.primaryMinChroma,
    this.secondaryChroma,
    this.secondaryMinChroma,
    this.tertiaryChroma,
    this.tertiaryMinChroma,
    this.tertiaryHueRotation,
    this.errorChroma,
    this.errorMinChroma,
    this.neutralChroma = 4,
    this.neutralMinChroma,
    this.neutralVariantChroma = 8,
    this.neutralVariantMinChroma,
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
  const FlexTones.dark({
    this.primaryTone = 80,
    this.onPrimaryTone = 20,
    this.primaryContainerTone = 30,
    this.onPrimaryContainerTone = 90,
    this.secondaryTone = 80,
    this.onSecondaryTone = 20,
    this.secondaryContainerTone = 30,
    this.onSecondaryContainerTone = 90,
    this.tertiaryTone = 80,
    this.onTertiaryTone = 20,
    this.tertiaryContainerTone = 30,
    this.onTertiaryContainerTone = 90,
    this.errorTone = 80,
    this.onErrorTone = 20,
    this.errorContainerTone = 30,
    this.onErrorContainerTone = 80,
    this.backgroundTone = 10,
    this.onBackgroundTone = 90,
    this.surfaceTone = 10,
    this.onSurfaceTone = 90,
    this.surfaceVariantTone = 30,
    this.onSurfaceVariantTone = 80,
    this.outlineTone = 60,
    this.outlineVariantTone = 30,
    this.shadowTone = 0,
    this.scrimTone = 0,
    this.inverseSurfaceTone = 90,
    this.onInverseSurfaceTone = 20,
    this.inversePrimaryTone = 40,
    this.surfaceTintTone = 80,
    this.primaryChroma,
    this.primaryMinChroma,
    this.secondaryChroma,
    this.secondaryMinChroma,
    this.tertiaryChroma,
    this.tertiaryMinChroma,
    this.tertiaryHueRotation,
    this.errorChroma,
    this.errorMinChroma,
    this.neutralChroma = 4,
    this.neutralMinChroma,
    this.neutralVariantChroma = 8,
    this.neutralVariantMinChroma,
  });

  /// Create a M3 standard tonal palette tones extraction and CAM16
  /// chroma setup.
  ///
  /// This setup will if only one seed color is used, produce the same result
  /// with [FlexColorPalette] as [Scheme.light] or [Scheme.dark] depending on
  /// used [brightness], does when Flutter SDK uses [ColorPalette.of].
  factory FlexTones.material(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              secondaryChroma: 16,
              tertiaryChroma: 24,
            )
          : const FlexTones.dark(
              secondaryChroma: 16,
              tertiaryChroma: 24,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with softer colors than Material 3 defaults.
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
              backgroundTone: 5,
              //
              primaryMinChroma: 50,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
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
  factory FlexTones.vividSurfaces(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              onPrimaryTone: 98,
              onSecondaryTone: 98,
              onTertiaryTone: 98,
              onErrorTone: 98,
              surfaceTone: 95,
              onSurfaceVariantTone: 20,
              inverseSurfaceTone: 30,
              backgroundTone: 98,
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
              surfaceTone: 20,
              onSurfaceVariantTone: 95,
              inverseSurfaceTone: 95,
              //
              primaryMinChroma: 50,
              neutralChroma: 5,
              neutralVariantChroma: 10,
            );

  /// Creates a tonal palette extraction setup that results in M3 like
  /// ColorsSchemes with chroma like [FlexTones.vividSurfaces], but
  /// tone mapping surface and background are swapped.
  factory FlexTones.vividBackground(Brightness brightness) =>
      brightness == Brightness.light
          ? const FlexTones.light(
              primaryTone: 30,
              onPrimaryTone: 98,
              onSecondaryTone: 98,
              onTertiaryTone: 98,
              onErrorTone: 98,
              surfaceTone: 98,
              onSurfaceVariantTone: 20,
              inverseSurfaceTone: 30,
              backgroundTone: 95,
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
              backgroundTone: 20,
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
              primaryContainerTone: 95,
              secondaryContainerTone: 95,
              tertiaryContainerTone: 95,
              errorContainerTone: 95,
              surfaceTintTone: 30,
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
              tertiaryTone: 30,
              onBackgroundTone: 0,
              onSurfaceTone: 0,
              primaryContainerTone: 95,
              secondaryContainerTone: 95,
              tertiaryContainerTone: 95,
              errorContainerTone: 95,
              onPrimaryContainerTone: 5,
              onSecondaryContainerTone: 5,
              onTertiaryContainerTone: 5,
              onErrorContainerTone: 5,
              surfaceVariantTone: 95,
              onSurfaceVariantTone: 10,
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
              secondaryTone: 95,
              tertiaryTone: 95,
              onPrimaryTone: 5,
              onSecondaryTone: 5,
              onTertiaryTone: 5,
              onErrorTone: 5,
              onPrimaryContainerTone: 98,
              onSecondaryContainerTone: 98,
              onTertiaryContainerTone: 98,
              onErrorContainerTone: 98,
              //
              surfaceTone: 5,
              backgroundTone: 5,
              onBackgroundTone: 99,
              onSurfaceTone: 99,
              surfaceVariantTone: 20,
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
              secondaryTone: 50,
              onPrimaryTone: 99,
              onSecondaryTone: 99,
              onTertiaryTone: 99,
              onErrorTone: 99,
              secondaryContainerTone: 95,
              surfaceTintTone: 30,
              //
              tertiaryChroma: 40,
              primaryMinChroma: 55,
              secondaryMinChroma: 40,
              neutralChroma: 6,
              neutralVariantChroma: 10,
            )
          : const FlexTones.dark(
              secondaryTone: 90,
              secondaryContainerTone: 20,
              onPrimaryTone: 10,
              onSecondaryTone: 10,
              onTertiaryTone: 10,
              onErrorTone: 10,
              //
              tertiaryChroma: 40,
              primaryMinChroma: 55,
              secondaryMinChroma: 40,
              neutralChroma: 6,
              neutralVariantChroma: 10,
            );

  /// Create a M3 tonal palette tones extraction, but with no hue rotation
  /// from primary if no ARGB key color is provided for tertiary palette.
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

  /// Returns a new [FlexTones] instance where on colors tones for all main on
  /// color tones, are set to be either pure white 100 or black 0, depending
  /// what is appropriate contrast for its color pair.
  ///
  /// This will make the seeded on colors for [onPrimary], [onPrimaryContainer],
  /// [onSecondary], [onSecondaryContainer], [onTertiary],
  /// [onTertiaryContainer], [onError] and [onErrorContainer] pure black or
  /// white, depending on need contrast, instead of tinted black and white.
  ///
  /// This is a modifier, using copyWith, that can be used to change any
  /// existing or pre-made [FlexTones] config to not have any color tint in
  /// their seeded main **on** colors.
  ///
  /// The [useBW] flag is true by default, making the function effective.
  /// If set to false, the function is a no op and just returns the [FlexTones]
  /// object unmodified. This is typically used to control applying the tint
  /// removal via a controller.
  FlexTones onMainsUseBW([bool useBW = true]) {
    // ignore: avoid_returning_this
    if (!useBW) return this;
    return copyWith(
      onPrimaryTone: primaryTone <= 60 ? 100 : 0,
      onPrimaryContainerTone: primaryContainerTone <= 60 ? 100 : 0,
      onSecondaryTone: secondaryTone <= 60 ? 100 : 0,
      onSecondaryContainerTone: secondaryContainerTone <= 60 ? 100 : 0,
      onTertiaryTone: tertiaryTone <= 60 ? 100 : 0,
      onTertiaryContainerTone: tertiaryContainerTone <= 60 ? 100 : 0,
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
  /// object unmodified. This is typically used to control applying the tint
  /// removal via a controller.
  FlexTones onSurfacesUseBW([bool useBW = true]) {
    // ignore: avoid_returning_this
    if (!useBW) return this;
    return copyWith(
      onBackgroundTone: backgroundTone <= 60 ? 100 : 0,
      onSurfaceTone: surfaceTone <= 60 ? 100 : 0,
      onSurfaceVariantTone: surfaceVariantTone <= 60 ? 100 : 0,
      onInverseSurfaceTone: inverseSurfaceTone <= 60 ? 100 : 0,
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

  /// Tone used for [ColorScheme.error] from error [FlexTonalPalette].
  final int errorTone;

  /// Tone used for [ColorScheme.onError] from error [FlexTonalPalette].
  final int onErrorTone;

  /// Tone used for [ColorScheme.errorContainer] from error [FlexTonalPalette].
  final int errorContainerTone;

  /// Tone used for [ColorScheme.onErrorContainer] from error
  /// [FlexTonalPalette].
  final int onErrorContainerTone;

  /// Tone used for [ColorScheme.background] from neutral [FlexTonalPalette].
  final int backgroundTone;

  /// Tone used for [ColorScheme.onBackground] from neutral [FlexTonalPalette].
  final int onBackgroundTone;

  /// Tone used for [ColorScheme.surface] from neutral [FlexTonalPalette].
  final int surfaceTone;

  /// Tone used for [ColorScheme.onSurface] from neutral [FlexTonalPalette].
  final int onSurfaceTone;

  /// Tone used for [ColorScheme.surfaceVariant] from neutralVariant
  /// [FlexTonalPalette].
  final int surfaceVariantTone;

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

  /// Copy the object with one or more provided properties changed.
  FlexTones copyWith({
    int? primaryTone,
    int? onPrimaryTone,
    int? primaryContainerTone,
    int? onPrimaryContainerTone,
    int? secondaryTone,
    int? onSecondaryTone,
    int? secondaryContainerTone,
    int? onSecondaryContainerTone,
    int? tertiaryTone,
    int? onTertiaryTone,
    int? tertiaryContainerTone,
    int? onTertiaryContainerTone,
    int? errorTone,
    int? onErrorTone,
    int? errorContainerTone,
    int? onErrorContainerTone,
    int? backgroundTone,
    int? onBackgroundTone,
    int? surfaceTone,
    int? onSurfaceTone,
    int? surfaceVariantTone,
    int? onSurfaceVariantTone,
    int? outlineTone,
    int? outlineVariantTone,
    int? shadowTone,
    int? scrimTone,
    int? inverseSurfaceTone,
    int? onInverseSurfaceTone,
    int? inversePrimaryTone,
    int? surfaceTintTone,
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
  }) {
    return FlexTones(
      primaryTone: primaryTone ?? this.primaryTone,
      onPrimaryTone: onPrimaryTone ?? this.onPrimaryTone,
      primaryContainerTone: primaryContainerTone ?? this.primaryContainerTone,
      onPrimaryContainerTone:
          onPrimaryContainerTone ?? this.onPrimaryContainerTone,
      secondaryTone: secondaryTone ?? this.secondaryTone,
      onSecondaryTone: onSecondaryTone ?? this.onSecondaryTone,
      secondaryContainerTone:
          secondaryContainerTone ?? this.secondaryContainerTone,
      onSecondaryContainerTone:
          onSecondaryContainerTone ?? this.onSecondaryContainerTone,
      tertiaryTone: tertiaryTone ?? this.tertiaryTone,
      onTertiaryTone: onTertiaryTone ?? this.onTertiaryTone,
      tertiaryContainerTone:
          tertiaryContainerTone ?? this.tertiaryContainerTone,
      onTertiaryContainerTone:
          onTertiaryContainerTone ?? this.onTertiaryContainerTone,
      errorTone: errorTone ?? this.errorTone,
      onErrorTone: onErrorTone ?? this.onErrorTone,
      errorContainerTone: errorContainerTone ?? this.errorContainerTone,
      onErrorContainerTone: onErrorContainerTone ?? this.onErrorContainerTone,
      backgroundTone: backgroundTone ?? this.backgroundTone,
      onBackgroundTone: onBackgroundTone ?? this.onBackgroundTone,
      surfaceTone: surfaceTone ?? this.surfaceTone,
      onSurfaceTone: onSurfaceTone ?? this.onSurfaceTone,
      surfaceVariantTone: surfaceVariantTone ?? this.surfaceVariantTone,
      onSurfaceVariantTone: onSurfaceVariantTone ?? this.onSurfaceVariantTone,
      outlineTone: outlineTone ?? this.outlineTone,
      outlineVariantTone: outlineVariantTone ?? this.outlineVariantTone,
      shadowTone: shadowTone ?? this.shadowTone,
      scrimTone: scrimTone ?? this.scrimTone,
      inverseSurfaceTone: inverseSurfaceTone ?? this.inverseSurfaceTone,
      onInverseSurfaceTone: onInverseSurfaceTone ?? this.onInverseSurfaceTone,
      inversePrimaryTone: inversePrimaryTone ?? this.inversePrimaryTone,
      surfaceTintTone: surfaceTintTone ?? this.surfaceTintTone,
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
        other.secondaryTone == secondaryTone &&
        other.onSecondaryTone == onSecondaryTone &&
        other.secondaryContainerTone == secondaryContainerTone &&
        other.onSecondaryContainerTone == onSecondaryContainerTone &&
        other.tertiaryTone == tertiaryTone &&
        other.onTertiaryTone == onTertiaryTone &&
        other.tertiaryContainerTone == tertiaryContainerTone &&
        other.onTertiaryContainerTone == onTertiaryContainerTone &&
        other.errorTone == errorTone &&
        other.onErrorTone == onErrorTone &&
        other.errorContainerTone == errorContainerTone &&
        other.onErrorContainerTone == onErrorContainerTone &&
        other.backgroundTone == backgroundTone &&
        other.onBackgroundTone == onBackgroundTone &&
        other.surfaceTone == surfaceTone &&
        other.onSurfaceTone == onSurfaceTone &&
        other.surfaceVariantTone == surfaceVariantTone &&
        other.onSurfaceVariantTone == onSurfaceVariantTone &&
        other.outlineTone == outlineTone &&
        other.outlineVariantTone == outlineVariantTone &&
        other.shadowTone == shadowTone &&
        other.scrimTone == scrimTone &&
        other.inverseSurfaceTone == inverseSurfaceTone &&
        other.onInverseSurfaceTone == onInverseSurfaceTone &&
        other.inversePrimaryTone == inversePrimaryTone &&
        other.surfaceTintTone == surfaceTintTone &&
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
        other.neutralVariantMinChroma == neutralVariantMinChroma;
  }

  /// Override for hashcode, dart.ui Jenkins based.
  @override
  int get hashCode => Object.hashAll(<Object?>[
        primaryTone,
        onPrimaryTone,
        primaryContainerTone,
        onPrimaryContainerTone,
        secondaryTone,
        onSecondaryTone,
        secondaryContainerTone,
        onSecondaryContainerTone,
        tertiaryTone,
        onTertiaryTone,
        tertiaryContainerTone,
        onTertiaryContainerTone,
        errorTone,
        onErrorTone,
        errorContainerTone,
        onErrorContainerTone,
        backgroundTone,
        onBackgroundTone,
        surfaceTone,
        onSurfaceTone,
        surfaceVariantTone,
        onSurfaceVariantTone,
        outlineTone,
        outlineVariantTone,
        shadowTone,
        scrimTone,
        inverseSurfaceTone,
        onInverseSurfaceTone,
        inversePrimaryTone,
        surfaceTintTone,
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
    properties.add(DiagnosticsProperty<int>('secondaryTone', secondaryTone));
    properties
        .add(DiagnosticsProperty<int>('onSecondaryTone', onSecondaryTone));
    properties.add(DiagnosticsProperty<int>(
        'secondaryContainerTone', secondaryContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'onSecondaryContainerTone', onSecondaryContainerTone));
    properties.add(DiagnosticsProperty<int>('tertiaryTone', tertiaryTone));
    properties.add(DiagnosticsProperty<int>('onTertiaryTone', onTertiaryTone));
    properties.add(DiagnosticsProperty<int>(
        'tertiaryContainerTone', tertiaryContainerTone));
    properties.add(DiagnosticsProperty<int>(
        'onTertiaryContainerTone', onTertiaryContainerTone));
    properties.add(DiagnosticsProperty<int>('errorTone', errorTone));
    properties.add(
        DiagnosticsProperty<int>('errorContainerTone', errorContainerTone));
    properties.add(
        DiagnosticsProperty<int>('onErrorContainerTone', onErrorContainerTone));
    properties.add(DiagnosticsProperty<int>('backgroundTone', backgroundTone));
    properties
        .add(DiagnosticsProperty<int>('onBackgroundTone', onBackgroundTone));
    properties.add(DiagnosticsProperty<int>('surfaceTone', surfaceTone));
    properties.add(DiagnosticsProperty<int>('onSurfaceTone', onSurfaceTone));
    properties.add(
        DiagnosticsProperty<int>('surfaceVariantTone', surfaceVariantTone));
    properties.add(
        DiagnosticsProperty<int>('onSurfaceVariantTone', onSurfaceVariantTone));
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
  }
}
