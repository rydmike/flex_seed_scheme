import 'dart:math' as math;

import 'package:meta/meta.dart' show immutable;

import '../mcu/material_color_utilities.dart';
import 'flex_tonal_palette.dart';

// ignore_for_file: comment_references

// Background: Why make custom versions of CorePalette and TonalPalette?
// (Mostly written down so author will remember it later)
//
// The FlexCorePalette and FlexTonalPalette are used to create custom
// versions of material_color_utilities CorePalette and TonalPalette classes.
//
// FlexCorePalette has an additional [fromSeeds] factory that is a bit more
// efficient than a version that would extend from CorePalette is, via reduced
// interface overhead. It also adds tones 5 and 98.
//
// The conversion of TonalPalettes to a list of ints, and having super
// create the CorePalette from this list, has a bit unneeded extra overhead.
// It is a bit more efficient to make and use an own implementation
// of this simple mid-layer that has the needed constructors fromSeed directly.
// Perhaps it does not matter, in that case extending the parent [CorePalette]
// to make FlexCorePalette is an option, I have one stashed away, but its
// constructor interface felt a bit like using FFI.
//
// The [CorePalette] in Material Color Utilities is a convenience wrapper for
// the needed [TonalPalette]s, that is used by an additional upper layer
// called [Scheme] that [ColorScheme.fromSeed] uses to create
// a [ColorScheme] from a seed color. To make a ColorScheme "fromSeeds"
// version, we need to make a slightly modified version of [Scheme]
// too. The usage of [CorePalette.of] is hard coded into it, so we
// cannot plug-in our version of FlexCorePalette in it anyway.
//
// Considering we need a custom version [Scheme] and [TonalPalette] it seemed
// we might as well make modified re-implementation version of [CorePalette] as
// well instead of extending from [CorePalette] and name it [FlexCorePalette].
//
// Downside, it does not share parent with [CorePalette], like an earlier
// implementation did when this class was a part of FlexColorScheme package,
// but this is not really needed, it is just color utility class.
//
// Regarding the custom version of TonalPalette, named FlexTonalPalette, there
// was just no convenient way to add the desired tones 5 and 98 to it without
// making our own version of it. Future version of [TonalPalette] in package
// material_color_utilities may add tone 98, as it briefly existed in M3 Web
// tool, but not in M3 guide, so who knows, but last I checked tone 98 was gone
// in the web tool. We liked tone 98 for more light tone options.
// Likewise tone 5, for more fidelity in the dark tones. So here we offer them
// as well.

/// An intermediate concept between the key color for a UI theme, and a full
/// color scheme. Five tonal palettes are generated, plus a default
/// error palette if not provided.
///
/// This is a modification of package:material_color_utilities [CorePalette],
/// to make it possible to create Material-3 seeded ColorScheme using tonal
/// palettes created from 3 different ARGB seed colors, where 2 are optional.
/// As an addition to using only one as provided via material_color_utilities
/// version [CorePalette.of] and here also via [FlexCorePalette.of].
///
/// This implementation also has an unnamed constructor for the five main final
/// [FlexTonalPalette] properties. Exposes the original version's private
/// constructor [FlexCorePalette.fromHueChroma], that is used by
/// [FlexCorePalette.of].
///
/// It adds a [FlexCorePalette.fromSeeds] constructor
/// to enable creating the [FlexTonalPalette]s for primary, secondary and
/// tertiary color groups using optional ARGB seed colors, for secondary and
/// tertiary [FlexTonalPalette]s, instead of tying them down to same ARGB
/// seed color used for the primary color group.
///
/// The core produced tonal palettes are [primary], [secondary], [tertiary],
/// [neutral], [neutralVariant] and [error].
@immutable
class FlexCorePalette {
  /// Creates a [FlexCorePalette] by providing [FlexTonalPalette]s for each
  /// tonal color palette in the Material 3 core palettes.
  ///
  /// Providing the [error] tonal palette is optional, if not given it defaults
  /// to the Material 3 color system default FlexTonalPalette.of(25, 84).
  ///
  /// If you construct [FlexCorePalette] with this default constructor, you
  /// must use the same [paletteType] of [FlexPaletteType] in all passed in
  /// [FlexTonalPalette]s. They default to [FlexPaletteType.common], but if you
  /// use [FlexPaletteType.extended] you must also provide the [error] tonal
  /// palette and set its [paletteType] to [FlexPaletteType.extended] as well.
  /// The input for the default M3 error color palette using the extended tones
  /// would be `FlexTonalPalette.of(25, 84, FlexPaletteType.extended)`.
  ///
  /// Prefer using [FlexCorePalette.of], [FlexCorePalette.fromHueChroma] or
  /// [FlexCorePalette.fromSeeds] to make a [FlexCorePalette].
  const FlexCorePalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.neutral,
    required this.neutralVariant,
    FlexTonalPalette? error,
  }) : _error = error;

  /// The number of generated tonal palettes.
  static const int size = 6;

  /// TonalPalette for primary colors.
  final FlexTonalPalette primary;

  /// TonalPalette for secondary colors.
  final FlexTonalPalette secondary;

  /// TonalPalette for tertiary colors.
  final FlexTonalPalette tertiary;

  /// TonalPalette for neutral colors. Typically hues of primary.
  final FlexTonalPalette neutral;

  /// TonalPalette for neutralVariant colors. Typically hues of primary.
  final FlexTonalPalette neutralVariant;

  /// Internal final error palette property that defaults via init list to
  /// provided error parameter.
  final FlexTonalPalette? _error;

  /// TonalPalette error colors getter, returns given final _error parameter,
  /// but if null falls to M3 default value FlexTonalPalette.of(25, 84).
  ///
  /// The error color hue is 25 and chroma 84 and FlexPaletteType.common.
  ///
  /// If you construct [FlexCorePalette] with this default constructor, you
  /// must use the same [paletteType] of [FlexPaletteType] in all passed in
  /// [FlexTonalPalette]s. They default to [FlexPaletteType.common], but if you
  /// use [FlexPaletteType.extended] you must also provide the [error] tonal
  /// palette and set its [paletteType] to [FlexPaletteType.extended] as well.
  /// You would typically give it the value:
  /// [FlexTonalPalette.of(25, 84, FlexPaletteType.extended)] for M3 default
  /// error colors but with more tones available.
  FlexTonalPalette get error =>
      _error ?? FlexTonalPalette.of(25, 84, FlexPaletteType.common);

  /// Create a [FlexCorePalette] from a given int ARGB color value.
  static FlexCorePalette of(
    int argb, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    final Cam16 cam = Cam16.fromInt(argb);
    return FlexCorePalette.fromHueChroma(cam.hue, cam.chroma, paletteType);
  }

  /// Create a standard Material 3 core tonal palette from Hue and Chroma.
  FlexCorePalette.fromHueChroma(
    double hue,
    double chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : primary = FlexTonalPalette.of(hue, math.max(48, chroma), paletteType),
        secondary = FlexTonalPalette.of(hue, 16, paletteType),
        tertiary = FlexTonalPalette.of(hue + 60, 24, paletteType),
        neutral = FlexTonalPalette.of(hue, 4, paletteType),
        neutralVariant = FlexTonalPalette.of(hue, 8, paletteType),
        _error = FlexTonalPalette.of(25, 84, paletteType);

  /// Create a [FlexCorePalette] from one to three seed colors.
  ///
  /// If only [primary] ARGB is provided, it is the same as using the
  /// [FlexCorePalette.of] static that returns an instance of
  /// [FlexCorePalette] created from a single ARGB seed color.
  ///
  /// When using optional [secondary] and [tertiary] int ARGB seed values,
  /// the tonal palette generation will use hue and chroma from the provided
  /// color values for creation of respective tonal palettes.
  ///
  /// The specified fixed chroma value, or minimum allowed chroma value, will
  /// if specified be used, but combined with the hue in provided [secondary]
  /// and [tertiary] key colors. If no min chroma or fixed chroma value is
  /// given, the chroma value in the provided seed/key color is used.
  ///
  /// To create a [FlexCorePalette.fromSeeds] that equals Material Color
  /// Utilities package [CorePalette.of] palette results, when it comes to same
  /// color tone values. Only specify the [primary] ARGB seed color and
  /// set [secondaryChroma] and [tertiaryChroma] to same fixed values that
  /// the Material 3 default color system has hard coded, 16 and 24.
  ///
  /// Example:
  /// ```dart
  /// final FlexCorePalette fCorePal = FlexCorePalette.fromSeeds(
  ///   primary: const Color(0xFF6750A4).value,
  ///   secondaryChroma: 16,
  ///   tertiaryChroma: 24,
  /// );
  //  final CorePalette corePal = CorePalette.of(const Color(0xFF6750A4).value);
  /// ```
  ///
  /// Using above `corePal` and `fCorePal` same tones in corresponding palettes
  /// will be equal.
  ///
  /// ```dart
  /// var same = fCorePal.primary.get(10) == corePal.primary.get(10); // true
  /// ```
  ///
  /// Tones 5 and 98 available in [FlexCorePalette] are not available in
  /// [CorePalette]. They are an addition in the modified implementation of
  /// [FlexTonalPalette] compared to [TonalPalette].
  factory FlexCorePalette.fromSeeds({
    /// Integer ARGB value of seed color used for primary tonal palette.
    /// calculation.
    ///
    /// By default a minimum of Cam16 chroma 48 is used to ensure a bright
    /// palette. If chroma of the provided color is higher than 48, it is
    /// used.
    ///
    /// A fixed chroma value can also be specified via [primaryChroma], if it
    /// is, then the given chroma value is used. Alternatively a
    /// [primaryMinChroma] can, be specified, then chroma in [primary] is used
    /// when it is higher than [primaryMinChroma]. If both [primaryChroma] and
    /// [primaryMinChroma] are specified, the higher value is used for chroma.
    required int primary,

    /// Integer ARGB value of seed color used for secondary tonal palette
    /// calculation.
    ///
    /// If not provided, the palette is based on [primary] with Cam16 chroma
    /// fixed at 16.
    ///
    /// A fixed chroma value can also be specified via [secondaryChroma], if it
    /// is, then the given chroma value is used. Alternatively a
    /// [secondaryMinChroma] can, be specified, then chroma in [secondary] is
    /// used when it is higher than [secondaryMinChroma]. If both
    /// [secondaryChroma] and [secondaryMinChroma] are specified, the higher
    /// value is used for chroma.
    int? secondary,

    /// Integer ARGB value of seed color used for tertiary tonal palette
    /// calculation.
    ///
    /// Cam16 chroma is capped at 48 if provided. If not provided, the palette
    /// is based on [primary] with Cam16 hue + 60 degrees (default value for
    /// [tertiaryHueRotation]) and chroma at 24.
    ///
    /// A fixed chroma value can also be specified via [tertiaryChroma], if it
    /// is, then the given chroma value is used. Alternatively a
    /// [tertiaryMinChroma] can, be specified, then chroma in [tertiary] is
    /// used when it is higher than [tertiaryMinChroma]. If both
    /// [tertiaryChroma] and [tertiaryMinChroma] are specified, the higher
    /// value is used for chroma.
    int? tertiary,

    /// Integer ARGB value of seed color used for error tonal palette.
    ///
    /// If not provided, the palette will be based on Material 3 default
    /// `FlexTonalPalette.of(25, 84)`. The error color hue is 25 and chroma 84.
    /// Typically you should stick to this, but if your theme uses a primary
    /// red color that clashes badly with the default M3 error color, you can
    /// specify a new error seed color here with a different hue and also
    /// chroma limit or fixed one.
    ///
    /// A fixed chroma value can also be specified via [errorChroma], if it
    /// is, then the given chroma value is used. Alternatively a
    /// [errorMinChroma] can, be specified, then chroma in [error] is
    /// used when it is higher than [errorMinChroma]. If both
    /// [errorChroma] and [errorMinChroma] are specified, the higher
    /// value is used for chroma.
    int? error,

    /// Integer ARGB value of seed color used for neutral tonal palette
    /// calculation.
    ///
    /// If not provided, the palette is based on [primary] with Cam16 chroma
    /// fixed at 16.
    ///
    /// A fixed chroma value can also be specified via [neutralChroma], if it
    /// is, then the given chroma value is used. Alternatively a
    /// [neutralMinChroma] can, be specified, then chroma in [neutral] is
    /// used when it is higher than [neutralMinChroma]. If both
    /// [neutralChroma] and [neutralMinChroma] are specified, the higher
    /// value is used for chroma.
    int? neutral,

    /// Integer ARGB value of seed color used for neutralVariant tonal palette
    /// calculation.
    ///
    /// If not provided, the palette is based on [primary] with Cam16 chroma
    /// fixed at 16.
    ///
    /// A fixed chroma value can also be specified via [neutralVariantChroma],
    /// if it is, then the given chroma value is used. Alternatively a
    /// [neutralVariantMinChroma] can, be specified, then chroma in
    /// [neutralVariant] is used when it is higher than
    /// [neutralVariantMinChroma]. If both [neutralVariantChroma] and
    /// [neutralVariantMinChroma] are specified, the higher value is used
    /// for chroma.
    int? neutralVariant,

    /// Cam16 chroma value to use for primary colors tonal palette generation.
    ///
    /// If null, the chroma value from the used [primary] seed key color is
    /// used, if it is larger than [primaryMinChroma].
    ///
    /// Flutter SDK [ColorScheme.fromSeed] uses chroma from seed, with
    /// [primaryMinChroma] set to 48, so the chroma from the key color is used
    /// when above 48, but never lower than 48. This keeps primary color in
    /// resulting tonal palette reasonably vivid and usable regardless of
    /// used seed color.
    ///
    /// To use chroma value from [primary] seed color, keep [primaryChroma] null
    /// and [primaryMinChroma] at desired threshold for target min colorfulness.
    final double? primaryChroma,

    /// The minimum used chroma value for primary palette.
    ///
    /// If chroma in provided [primary] key color is below this value, or if a
    /// fixed [primaryChroma] is provided that is lower than [primaryMinChroma]
    /// then the [primaryMinChroma] value is used.
    ///
    /// If not defined, defaults to 48.
    ///
    /// Flutter SDK uses 48 via a hard coded value and design.
    final double? primaryMinChroma,

    /// Cam16 chroma value to use for secondary colors tonal palette
    /// generation.
    ///
    /// If null, the chroma value from the used [secondary] seed key color is
    /// used, if it is larger than [secondaryMinChroma].
    ///
    /// Flutter SDK [ColorScheme.fromSeed] uses [secondaryChroma] hard coded
    /// and locked to 16.
    ///
    /// Defaults to null, set it to 16 for Material 3 standard result.
    ///
    /// The Flutter's and M3 default value produces quite soft, muted and earthy
    /// tones as secondary tonal palette at its mid-point tones of the palette.
    /// This is a design choice, but you can modify it here.
    ///
    /// To use chroma value from [secondary] seed color, keep [secondaryChroma]
    /// null and [secondaryMinChroma] at desired threshold for target min
    /// colorfulness.
    final double? secondaryChroma,

    /// The minimum used chroma value for secondary palette.
    ///
    /// If chroma in provided [secondary] key color is below this value, or if a
    /// fixed [secondaryChroma] is provided that is lower than
    /// [secondaryMinChroma] then the [secondaryMinChroma] value is used.
    ///
    /// If not defined, defaults to 0.
    ///
    /// Flutter SDK only uses [secondaryChroma] hard coded to 16, and has no
    /// concept of minimum level for secondary tonal palettes as its chroma
    /// value is always locked to 16.
    final double? secondaryMinChroma,

    /// Cam16 chroma value to use for tertiary colors tonal palette generation.
    ///
    /// If null, the chroma value from the used [tertiary] seed key color is
    /// used, if it is larger than [tertiaryMinChroma].
    ///
    /// Flutter SDK [ColorScheme.fromSeed] uses [tertiaryChroma] hard coded
    /// and locked to 24.
    ///
    /// Defaults to null, set it to 24 for Material 3 standard result.
    ///
    /// The default produces soft and pastel tones as tertiary tonal palette
    /// at the mid-point tones of the palette, they are bit less muted than
    /// the default secondary tonal palette.
    ///
    /// To use chroma value from [tertiary] seed color, keep [tertiaryChroma]
    /// null and [tertiaryMinChroma] at desired threshold for target min
    /// colorfulness.
    final double? tertiaryChroma,

    /// The minimum used chroma value for tertiary palette.
    ///
    /// If chroma in provided [tertiary] key color is below this value, or if a
    /// fixed [tertiaryChroma] is provided that is lower than
    /// [tertiaryMinChroma] then the [tertiaryMinChroma] value is used.
    ///
    /// If not defined, defaults to 0.
    ///
    /// Flutter SDK only uses [tertiaryChroma] hard coded to 24, and has no
    /// concept of minimum level for tertiary tonal palettes, as its value is
    /// always locked to 24.
    final double? tertiaryMinChroma,

    /// The number of degrees to rotate the hue in [primary] key color to get
    /// the used Hue for the tertiary color.
    ///
    /// This is only used when [tertiary] ARGB key color is null and we have
    /// not specified an own key color for [tertiary] with its onw hue.
    ///
    /// If you set this value to 0, or very close to it, you can make seed
    /// generated color schemes where all color are "like" the primary color
    /// but with subtle tone and shade variations.
    ///
    /// If not defined, default 60.
    final double? tertiaryHueRotation,

    /// Cam16 chroma value to use for neutral colors tonal palette generation.
    ///
    /// Uses chroma from the [neutral] key color, but you can vary the
    /// amount of chroma from neutral key color that is used to generate
    /// the tonal palette
    ///
    /// Flutter SDK [ColorScheme.fromSeed] uses [neutralChroma] hard coded to 4.
    ///
    /// If not defined, defaults to 4.
    ///
    /// To force the chroma in [neutral] key color to be used, set this to null
    /// and keep [neutralMinChroma] at 0. Typically you want to use very low
    /// chroma on the neutral colors. If you set this to null, the provided
    /// ARGB value in [neutral] should have a very low chroma value itself.
    final double? neutralChroma = 4,

    /// The minimum used chroma value for neutral palette.
    ///
    /// If chroma in provided [neutral] key color is below this value, or if a
    /// fixed [neutralChroma] is provided that is lower than
    /// [neutralMinChroma] then the [neutralMinChroma] value is used.
    ///
    /// If not defined, defaults to 0.
    ///
    /// Flutter SDK only uses [neutralChroma] hard coded to 4, and has no
    /// concept of minimum level for neutral tonal palettes as its chroma
    /// value is always locked to 16.
    final double? neutralMinChroma,

    /// Cam16 chroma value to use for neutralVariant colors
    /// tonal palette generation.
    ///
    /// Uses chroma from the [neutralVariant] key color, but you can vary
    /// the amount of chroma from neutral variant key color that is used to
    /// generate the tonal palette
    ///
    /// Flutter SDK [ColorScheme.fromSeed] uses [neutralVariantChroma] hard
    /// coded to 8.
    ///
    /// Defaults to 8.
    ///
    /// To force the chroma in [neutralVariant] key color to be used, set this
    /// to null and keep [neutralVariantMinChroma] at 0. Typically you want to
    /// use very low chroma on the neutral colors. If you set this to null, the
    /// provided ARGB value in [neutralVariant] should have a very low chroma
    /// value itself.
    final double? neutralVariantChroma = 8,

    /// The minimum used chroma value for neutral variant palette.
    ///
    /// If chroma in provided [neutralVariant] key color is below this value,
    /// or if a fixed [neutralVariantChroma] is provided that is lower than
    /// [neutralVariantMinChroma] then the [neutralVariantMinChroma] value
    /// is used.
    ///
    /// If not defined, defaults to 0.
    ///
    /// Flutter SDK only uses [neutralVariantMinChroma] hard coded to 4, and
    /// has no concept of minimum level for neutral variant tonal palettes as
    /// its chroma value is always locked to 8.
    final double? neutralVariantMinChroma,

    /// Cam16 chroma value to use for error colors tonal palette generation.
    ///
    /// If null, the chroma value from the used [error] seed key color is
    /// used, if it is larger than [errorMinChroma].
    ///
    /// Defaults to null. Set it to 84 for M3 default also on custom hues.
    ///
    /// To use chroma value from [error] seed color, keep [errorChroma]
    /// null and [errorMinChroma] at desired threshold for target min
    /// colorfulness.
    final double? errorChroma,

    /// The minimum used chroma value for error palette.
    ///
    /// If chroma in provided [error] key color is below this value, or if a
    /// fixed [errorChroma] is provided that is lower than
    /// [errorMinChroma] then the [errorMinChroma] value is used.
    ///
    /// If not defined, defaults to 0.
    ///
    /// Flutter SDK only uses [errorChroma] hard coded to 84, and has no
    /// concept of minimum level for error tonal palettes, as its value is
    /// always locked to 84.
    final double? errorMinChroma,

    /// Defines what [FlexPaletteType] this [FlexCorePalette] uses.
    ///
    /// The default [FlexPaletteType.common] with 15 tones or the extended
    /// [FlexPaletteType.extended] with 24 tones.
    final FlexPaletteType paletteType = FlexPaletteType.common,

    /// If true, the CAM16 color space is used to define the HCT color, if
    /// false simpler and faster HCT from int is used.
    ///
    /// Prior to version 2.0.0 of this package, the CAM16 color space was always
    /// used. However, in Flutter 3.22 the HCT vanilla HCT.fromInt is used
    /// for its seeded scheme colors.It is used here by the Material3
    /// style seeded color schemes as well, while the FSS ones continues to use
    /// Cam16.
    final bool useCam16 = true,
  }) {
    // Primary TonalPalette calculation.
    late final double primaryComputedChroma;
    late final double primaryComputedHue;
    if (useCam16) {
      final Cam16 camPrimary = Cam16.fromInt(primary);
      primaryComputedHue = camPrimary.hue;
      primaryComputedChroma = camPrimary.chroma;
    } else {
      final Hct hctPrimary = Hct.fromInt(primary);
      primaryComputedHue = hctPrimary.hue;
      primaryComputedChroma = hctPrimary.chroma;
    }
    // final Cam16 camPrimary = Cam16.fromInt(primary);

    // If a fixed chroma was given we use it instead of chroma in primary.
    final double effectivePrimaryChroma =
        primaryChroma ?? primaryComputedChroma;
    // We use the effectiveChroma, but only if it is over the min level.
    final FlexTonalPalette tonalPrimary = FlexTonalPalette.of(
        primaryComputedHue,
        math.max(primaryMinChroma ?? 48, effectivePrimaryChroma),
        paletteType);

    // Secondary TonalPalette calculation.
    //
    // Provided key color may be null, then we use primary as key color.
    late final double secondaryComputedChroma;
    late final double secondaryComputedHue;
    if (secondary == null) {
      secondaryComputedHue = primaryComputedHue;
      secondaryComputedChroma = primaryComputedChroma;
    } else {
      if (useCam16) {
        final Cam16 camSecondary = Cam16.fromInt(secondary);
        secondaryComputedHue = camSecondary.hue;
        secondaryComputedChroma = camSecondary.chroma;
      } else {
        final Hct hctSecondary = Hct.fromInt(secondary);
        secondaryComputedHue = hctSecondary.hue;
        secondaryComputedChroma = hctSecondary.chroma;
      }
    }
    // If a fixed chroma value was given we use it instead.
    final double effectiveSecondaryChroma =
        secondaryChroma ?? secondaryComputedChroma;
    // We use the effectiveChroma, but only if it is over the min level.
    final FlexTonalPalette tonalSecondary = FlexTonalPalette.of(
        secondaryComputedHue,
        math.max(secondaryMinChroma ?? 0, effectiveSecondaryChroma),
        paletteType);

    // Tertiary TonalPalette calculation.
    //
    // Provided key color may be null, then we use primary as key color.
    late final double tertiaryComputedChroma;
    late final double tertiaryComputedHue;
    if (tertiary == null) {
      // If we had no tertiary keyColor, we won't use primary key's hue
      // directly, we add 60 degrees to it, this is the M3 way to shift hue
      // from a single key.
      tertiaryComputedHue = MathUtils.sanitizeDegreesDouble(
          primaryComputedHue + (tertiaryHueRotation ?? 60));
      tertiaryComputedChroma = primaryComputedChroma;
    } else {
      if (useCam16) {
        final Cam16 camTertiary = Cam16.fromInt(tertiary);
        tertiaryComputedHue = camTertiary.hue;
        tertiaryComputedChroma = camTertiary.chroma;
      } else {
        final Hct hctTertiary = Hct.fromInt(tertiary);
        tertiaryComputedHue = hctTertiary.hue;
        tertiaryComputedChroma = hctTertiary.chroma;
      }
    }
    // If a fixed chroma value was given we use it instead.
    final double effectiveTertiaryChroma =
        tertiaryChroma ?? tertiaryComputedChroma;
    // We use the effective hue and the effectiveChroma, but chroma
    // only if it is over the min level.
    final FlexTonalPalette tonalTertiary = FlexTonalPalette.of(
        tertiaryComputedHue,
        math.max(tertiaryMinChroma ?? 0, effectiveTertiaryChroma),
        paletteType);

    // Neutral TonalPalette calculation.
    //
    // Provided key color may be null, then we use primary as key color.
    late final double neutralComputedChroma;
    late final double neutralComputedHue;
    if (neutral == null) {
      neutralComputedHue = primaryComputedHue;
      neutralComputedChroma = primaryComputedChroma;
    } else {
      if (useCam16) {
        final Cam16 camNeutral = Cam16.fromInt(neutral);
        neutralComputedHue = camNeutral.hue;
        neutralComputedChroma = camNeutral.chroma;
      } else {
        final Hct hctNeutral = Hct.fromInt(neutral);
        neutralComputedHue = hctNeutral.hue;
        neutralComputedChroma = hctNeutral.chroma;
      }
    }
    // If a fixed chroma value was given we use it instead.
    final double effectiveNeutralChroma =
        neutralChroma ?? neutralComputedChroma;
    // We use the effectiveChroma, but only if it is over the min level.
    final FlexTonalPalette tonalNeutral = FlexTonalPalette.of(
        neutralComputedHue,
        math.max(neutralMinChroma ?? 0, effectiveNeutralChroma),
        paletteType);

    // NeutralVariant TonalPalette calculation.
    //
    // Provided key color may be null, then we use primary as key color.
    late final double neutralVariantComputedChroma;
    late final double neutralVariantComputedHue;
    if (neutralVariant == null) {
      neutralVariantComputedHue = primaryComputedHue;
      neutralVariantComputedChroma = primaryComputedChroma;
    } else {
      if (useCam16) {
        final Cam16 camNeutralVariant = Cam16.fromInt(neutralVariant);
        neutralVariantComputedHue = camNeutralVariant.hue;
        neutralVariantComputedChroma = camNeutralVariant.chroma;
      } else {
        final Hct hctNeutralVariant = Hct.fromInt(neutralVariant);
        neutralVariantComputedHue = hctNeutralVariant.hue;
        neutralVariantComputedChroma = hctNeutralVariant.chroma;
      }
    }
    // If a fixed chroma value was given we use it instead.
    final double effectiveNeutralVariantChroma =
        neutralVariantChroma ?? neutralVariantComputedChroma;
    // We use the effectiveChroma, but only if it is over the min level.
    final FlexTonalPalette tonalNeutralVariant = FlexTonalPalette.of(
        neutralVariantComputedHue,
        math.max(neutralVariantMinChroma ?? 0, effectiveNeutralVariantChroma),
        paletteType);

    // Error TonalPalette calculation.
    //
    // Input error color maybe null, but if it is not we make a Cam16 from it.
    late final double errorComputedChroma;
    late final double errorComputedHue;
    // If no error color was given, we use M3 default error color, hue 25 and
    // chroma 84.
    if (error == null) {
      errorComputedHue = 25;
      errorComputedChroma = 84;
    } else {
      // If an error color was given, we use its hue and chroma from Cam or Hct.
      if (useCam16) {
        final Cam16 camError = Cam16.fromInt(error);
        errorComputedHue = camError.hue;
        errorComputedChroma = camError.chroma;
      } else {
        final Hct hctError = Hct.fromInt(error);
        errorComputedHue = hctError.hue;
        errorComputedChroma = hctError.chroma;
      }
    }
    // If a fixed error chroma value was given we will use it instead as
    // effective chroma value, if not and if input error color was given, we use
    // its chroma, if one was not given we fall back to M3 default chroma 84.
    final double effectiveErrorChroma = errorChroma ?? errorComputedChroma;
    // We use the effectiveChroma, but only if it is over the min level.
    final FlexTonalPalette tonalError = FlexTonalPalette.of(errorComputedHue,
        math.max(errorMinChroma ?? 0, effectiveErrorChroma), paletteType);

    return FlexCorePalette(
      primary: tonalPrimary,
      secondary: tonalSecondary,
      tertiary: tonalTertiary,
      neutral: tonalNeutral,
      neutralVariant: tonalNeutralVariant,
      error: tonalError,
    );
  }

  /// Create a [FlexCorePalette] from a fixed-size list of ARGB color ints
  /// representing concatenated tonal palettes.
  ///
  /// Inverse of [asList].
  ///
  /// This fromList differs from MaterialColorUtilities version in CorePalette
  /// by including the error tonal colors last in the list.
  FlexCorePalette.fromList(
    List<int> colors, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ])  : assert(
            (colors.length == size * FlexTonalPalette.commonSize &&
                    paletteType == FlexPaletteType.common) ||
                (colors.length == size * FlexTonalPalette.extendedSize &&
                    paletteType == FlexPaletteType.extended),
            'Incorrect size.'),
        primary = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                0,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType),
        secondary = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                1,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType),
        tertiary = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                2,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType),
        neutral = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                3,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType),
        neutralVariant = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                4,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType),
        _error = FlexTonalPalette.fromList(
            _getPartition(
                colors,
                5,
                paletteType == FlexPaletteType.common
                    ? FlexTonalPalette.commonSize
                    : FlexTonalPalette.extendedSize),
            paletteType);

  /// Returns a list of ARGB color [int]s from concatenated tonal palettes.
  ///
  /// Inverse of [FlexCorePalette.fromList].
  ///
  /// This fromList differs from MaterialColorUtilities version in CorePalette
  /// by including the error tonal colors last in the list.
  List<int> asList() => <int>[
        ...primary.asList,
        ...secondary.asList,
        ...tertiary.asList,
        ...neutral.asList,
        ...neutralVariant.asList,
        ...error.asList,
      ];

  /// Override the equality operator.
  @override
  bool operator ==(Object other) =>
      other is FlexCorePalette &&
      primary == other.primary &&
      secondary == other.secondary &&
      tertiary == other.tertiary &&
      neutral == other.neutral &&
      neutralVariant == other.neutralVariant &&
      error == other.error;

  /// Override hashcode.
  @override
  int get hashCode => Object.hashAll(<Object?>[
        primary,
        secondary,
        tertiary,
        neutral,
        neutralVariant,
        error,
      ]);

  /// Override toString.
  @override
  String toString() {
    return 'primary: $primary\n'
        'secondary: $secondary\n'
        'tertiary: $tertiary\n'
        'neutral: $neutral\n'
        'neutralVariant: $neutralVariant\n'
        'error: $error\n';
  }

  /// Returns a partition from a list.
  ///
  /// For example, given a list with 2 partitions of size 3.
  /// range = [1, 2, 3, 4, 5, 6];
  ///
  /// range.getPartition(0, 3) // [1, 2, 3]
  /// range.getPartition(1, 3) // [4, 5, 6]
  static List<int> _getPartition(
      List<int> list, int partitionNumber, int partitionSize) {
    return list.sublist(
      partitionNumber * partitionSize,
      (partitionNumber + 1) * partitionSize,
    );
  }
}
