import 'dart:math' as math;
import 'dart:ui';

import 'package:flex_seed_scheme/src/flex/flex_color_seed_color_extensions.dart';
import 'package:flex_seed_scheme/src/flex/flex_tonal_palette.dart';
import 'package:flex_seed_scheme/src/mcu/material_color_utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ColorScheme;

/// An intermediate concept between the key color for a UI theme, and a full
/// color scheme. Five tonal palettes are generated, plus a default
/// error palette if not provided.
///
/// This is a modification of package:material_color_utilities [CorePalette],
/// to make it possible to create Material-3 seeded ColorScheme using tonal
/// palettes created from 6 different ARGB seed colors, where 5 are optional.
/// As an addition to using only one as provided via material_color_utilities
/// version [CorePalette.of] and here also via [FlexCorePalette.of].
///
/// This implementation also has an unnamed constructor for the six main final
/// [FlexTonalPalette] properties. It also exposes the original version's
/// private constructor [FlexCorePalette.fromHueChroma], that is used by
/// [FlexCorePalette.of].
///
/// It adds a [FlexCorePalette.fromSeeds] constructor
/// to enable creating the [FlexTonalPalette]s for primary, secondary and
/// tertiary, error, neutral and neutralVariant color groups, called palettes
/// using optional ARGB seed colors, for secondary, tertiary, error, neutral and
/// neutralVariant [FlexTonalPalette]s, instead of tying them down to same ARGB
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
  /// to the Material-3 color system default FlexTonalPalette.of(25, 84).
  ///
  /// If you construct [FlexCorePalette] with this default constructor, you
  /// must use the same `paletteType` of [FlexPaletteType] in all passed in
  /// [FlexTonalPalette]s. They default to [FlexPaletteType.common], but if you
  /// use [FlexPaletteType.extended] you must also provide the [error] tonal
  /// palette and set its `paletteType`
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
  /// must use the same `paletteType` of [FlexPaletteType] in all passed in
  /// [FlexTonalPalette]s. They default to [FlexPaletteType.common], but if you
  /// use [FlexPaletteType.extended] you must also provide the [error] tonal
  /// palette and set its `paletteType` to [FlexPaletteType.extended] as well.
  /// You would typically give it the value:
  /// [FlexTonalPalette.of(25, 84, FlexPaletteType.extended)] for M3 default
  /// error colors but with more tones available.
  FlexTonalPalette get error => _error ?? FlexTonalPalette.of(25, 84, FlexPaletteType.common);

  /// Create a [FlexCorePalette] from a given int ARGB color value.
  static FlexCorePalette of(
    int argb, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) {
    final Cam16 cam = Cam16.fromInt(argb);
    return FlexCorePalette.fromHueChroma(cam.hue, cam.chroma, paletteType);
  }

  /// Create a standard Material 3 core tonal palette from Hue and Chroma.
  // ignore: sort_constructors_first
  FlexCorePalette.fromHueChroma(
    double hue,
    double chroma, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) : primary = FlexTonalPalette.of(hue, math.max(48, chroma), paletteType),
       secondary = FlexTonalPalette.of(hue, 16, paletteType),
       tertiary = FlexTonalPalette.of(hue + 60, 24, paletteType),
       neutral = FlexTonalPalette.of(hue, 4, paletteType),
       neutralVariant = FlexTonalPalette.of(hue, 8, paletteType),
       _error = FlexTonalPalette.of(25, 84, paletteType);

  /// Create a [FlexCorePalette] from one to six ARGB seed colors.
  ///
  /// If only [primary] is provided, this is the same as [FlexCorePalette.of]:
  /// a [FlexCorePalette] created from a single seed color. Optional [secondary],
  /// [tertiary], [error], [neutral] and [neutralVariant] seeds supply hue and
  /// chroma for those palettes instead of deriving them from [primary].
  ///
  /// For each palette, used chroma is the maximum of that palette's min chroma
  /// and its fixed chroma, or the seed chroma if the fixed chroma is null. If
  /// [respectMonochromeSeed] is true and a seed has equal RGB channels, chroma
  /// is forced to 0 and the min is ignored for that seed.
  ///
  /// To match Material Color Utilities [CorePalette.of] tone values, pass only
  /// [primary] and set [secondaryChroma] to 16 and [tertiaryChroma] to 24:
  ///
  /// ```dart
  /// final FlexCorePalette fCorePal = FlexCorePalette.fromSeeds(
  ///   primary: const Color(0xFF6750A4).value,
  ///   secondaryChroma: 16,
  ///   tertiaryChroma: 24,
  /// );
  /// final CorePalette corePal = CorePalette.of(const Color(0xFF6750A4).value);
  /// // fCorePal.primary.get(10) == corePal.primary.get(10); // true
  /// ```
  ///
  /// Tones 5 and 98 in [FlexCorePalette] are not in [CorePalette]. They come
  /// from [FlexTonalPalette] compared to [TonalPalette].
  ///
  /// ## [primary]
  ///
  /// Required integer ARGB seed for the primary tonal palette.
  ///
  /// By default a minimum Cam16 chroma of 48 is used so the palette stays
  /// reasonably vivid. If chroma of the provided color is higher than 48, that
  /// chroma is used. A fixed chroma can be set with [primaryChroma], or a
  /// floor with [primaryMinChroma]. If both are set, the higher value is used.
  ///
  /// ## [secondary]
  ///
  /// Optional integer ARGB seed for the secondary tonal palette.
  ///
  /// If omitted, hue and chroma come from [primary]. Flutter's
  /// [ColorScheme.fromSeed] does not use a secondary seed; it locks secondary
  /// chroma to 16, which yields soft, muted, earthy mid-tones. Set
  /// [secondaryChroma] to 16 for that Material 3 result. A floor can be set
  /// with [secondaryMinChroma]; if both chroma and min are set, the higher
  /// value is used.
  ///
  /// ## [tertiary]
  ///
  /// Optional integer ARGB seed for the tertiary tonal palette.
  ///
  /// If omitted, hue is [primary] hue plus [tertiaryHueRotation] (default 60)
  /// and chroma comes from [primary]. Flutter's [ColorScheme.fromSeed] locks
  /// tertiary chroma to 24, which is softer than primary and a bit less muted
  /// than secondary. Set [tertiaryChroma] to 24 for that Material 3 result. A
  /// floor can be set with [tertiaryMinChroma]; if both are set, the higher
  /// value is used.
  ///
  /// ## [error]
  ///
  /// Optional integer ARGB seed for the error tonal palette.
  ///
  /// If omitted, the palette is Material 3 default hue 25 and chroma 84
  /// (`FlexTonalPalette.of(25, 84)`). Stick to that unless a red primary
  /// clashes with the default error color; then pass a different hue here and
  /// optionally [errorChroma] / [errorMinChroma]. If both chroma and min are
  /// set, the higher value is used.
  ///
  /// ## [neutral]
  ///
  /// Optional integer ARGB seed for the neutral tonal palette.
  ///
  /// If omitted, hue comes from [primary]. Chroma defaults to 4 via
  /// [neutralChroma], matching [ColorScheme.fromSeed]. Keep chroma low on
  /// neutrals. To use chroma from this seed instead, set [neutralChroma] to
  /// null and [neutralMinChroma] to 0; the seed itself should then have very
  /// low chroma.
  ///
  /// ## [neutralVariant]
  ///
  /// Optional integer ARGB seed for the neutral variant tonal palette.
  ///
  /// If omitted, hue comes from [primary]. Chroma defaults to 8 via
  /// [neutralVariantChroma], matching [ColorScheme.fromSeed]. Same guidance as
  /// [neutral]: keep chroma low, or set [neutralVariantChroma] to null and
  /// [neutralVariantMinChroma] to 0 to use the seed's own chroma.
  ///
  /// ## [primaryChroma]
  ///
  /// Cam16 chroma for the primary palette, or null to use chroma from
  /// [primary] when it is at least [primaryMinChroma].
  ///
  /// Flutter SDK [ColorScheme.fromSeed] uses chroma from the seed with
  /// [primaryMinChroma] 48, so seed chroma is used when above 48 and never
  /// lower. That keeps primary tones usable regardless of how muted the seed
  /// is. Keep this null and adjust [primaryMinChroma] to control the floor
  /// while still using the seed's chroma when it is colorful enough.
  ///
  /// ## [primaryMinChroma]
  ///
  /// Minimum Cam16 chroma for the primary palette.
  ///
  /// If chroma in [primary], or a fixed [primaryChroma], is below this value,
  /// this minimum is used. Defaults to 48, matching the Flutter SDK hard-coded
  /// design.
  ///
  /// ## [secondaryChroma]
  ///
  /// Cam16 chroma for the secondary palette, or null to use chroma from
  /// [secondary] (or from [primary] if [secondary] is omitted) when it is at
  /// least [secondaryMinChroma].
  ///
  /// Defaults to null. Flutter's [ColorScheme.fromSeed] locks this to 16,
  /// which produces quite soft, muted, earthy mid-tones. Set this to 16 for a
  /// Material 3 standard result, or keep it null to follow the seed. Keep this
  /// null and set [secondaryMinChroma] to use seed chroma with a floor.
  ///
  /// ## [secondaryMinChroma]
  ///
  /// Minimum Cam16 chroma for the secondary palette.
  ///
  /// If chroma in [secondary], or a fixed [secondaryChroma], is below this
  /// value, this minimum is used. Defaults to 0. Flutter has no secondary min;
  /// chroma is always locked to 16.
  ///
  /// ## [tertiaryChroma]
  ///
  /// Cam16 chroma for the tertiary palette, or null to use chroma from
  /// [tertiary] (or from [primary] if [tertiary] is omitted) when it is at
  /// least [tertiaryMinChroma].
  ///
  /// Defaults to null. Flutter's [ColorScheme.fromSeed] locks this to 24. That
  /// default is soft and pastel at mid-tones, a bit less muted than the
  /// default secondary palette. Set this to 24 for a Material 3 standard
  /// result. Keep this null and set [tertiaryMinChroma] to use seed chroma
  /// with a floor.
  ///
  /// ## [tertiaryMinChroma]
  ///
  /// Minimum Cam16 chroma for the tertiary palette.
  ///
  /// If chroma in [tertiary], or a fixed [tertiaryChroma], is below this
  /// value, this minimum is used. Defaults to 0. Flutter has no tertiary min;
  /// chroma is always locked to 24.
  ///
  /// ## [tertiaryHueRotation]
  ///
  /// Degrees to rotate the hue of [primary] to get tertiary hue, used only
  /// when [tertiary] is omitted.
  ///
  /// Defaults to 60, the Material 3 single-seed hue shift. Set this to 0, or
  /// close to it, to make every palette "like" the primary color with only
  /// subtle tone differences.
  ///
  /// ## [neutralChroma]
  ///
  /// Cam16 chroma for the neutral palette.
  ///
  /// Defaults to 4, matching [ColorScheme.fromSeed]. Typically keep this very
  /// low so surfaces stay near greyscale with only a hint of the seed hue. To
  /// force chroma from the [neutral] seed, set this to null and keep
  /// [neutralMinChroma] at 0; that seed should itself have very low chroma.
  ///
  /// ## [neutralMinChroma]
  ///
  /// Minimum Cam16 chroma for the neutral palette.
  ///
  /// If chroma in [neutral], or a fixed [neutralChroma], is below this value,
  /// this minimum is used. Defaults to 0. Flutter has no neutral min; chroma
  /// is always locked to 4.
  ///
  /// ## [neutralVariantChroma]
  ///
  /// Cam16 chroma for the neutral variant palette.
  ///
  /// Defaults to 8, matching [ColorScheme.fromSeed]. Same guidance as
  /// [neutralChroma]: keep it low. To force chroma from the [neutralVariant]
  /// seed, set this to null and keep [neutralVariantMinChroma] at 0.
  ///
  /// ## [neutralVariantMinChroma]
  ///
  /// Minimum Cam16 chroma for the neutral variant palette.
  ///
  /// If chroma in [neutralVariant], or a fixed [neutralVariantChroma], is
  /// below this value, this minimum is used. Defaults to 0. Flutter has no
  /// neutral-variant min; chroma is always locked to 8.
  ///
  /// ## [errorChroma]
  ///
  /// Cam16 chroma for the error palette, or null to use chroma from [error]
  /// when it is at least [errorMinChroma] (or 84 when [error] is omitted).
  ///
  /// Defaults to null. Set it to 84 to keep Material 3 error chroma on a
  /// custom error hue. Keep this null and set [errorMinChroma] to use seed
  /// chroma with a floor.
  ///
  /// ## [errorMinChroma]
  ///
  /// Minimum Cam16 chroma for the error palette.
  ///
  /// If chroma in [error], or a fixed [errorChroma], is below this value, this
  /// minimum is used. Defaults to 0. Flutter has no error min; chroma is
  /// always locked to 84.
  ///
  /// ## [paletteType]
  ///
  /// Which tones this [FlexCorePalette] includes.
  ///
  /// [FlexPaletteType.common] has the original 15 tones;
  /// [FlexPaletteType.extended] has 24 tones (Material 3 revision, extra
  /// surface fidelity).
  ///
  /// ## [useCam16]
  ///
  /// If true, CAM16 is used to get hue and chroma from each seed. If false,
  /// HCT `fromInt` is used (simpler and faster).
  ///
  /// Defaults to true. Before version 2.0.0 this package always used CAM16.
  /// Flutter 3.22+ [ColorScheme.fromSeed] uses HCT `fromInt`. Material 3
  /// seeded schemes in this package follow that; FSS seeded schemes continue
  /// to use Cam16.
  ///
  /// ## [respectMonochromeSeed]
  ///
  /// If true, a seed whose red, green and blue channels are equal is treated
  /// as chroma 0, so the palette is greyscale. Any configured minimum chroma
  /// is ignored for that seed.
  ///
  /// Defaults to false to match MCU and [ColorScheme.fromSeed], which map
  /// white/grey seeds to cyan-ish palettes and black to a red-ish palette.
  /// Prefer true if monochrome seeds should stay greyscale. Seeds that are
  /// not monochrome produce the same result either way.
  // ignore: sort_constructors_first
  factory FlexCorePalette.fromSeeds({
    /// Required ARGB seed for the primary tonal palette.
    ///
    /// Default min chroma is 48 so the palette stays reasonably vivid.
    /// Override with `primaryChroma` / `primaryMinChroma`; if both are set,
    /// the higher value is used.
    required int primary,

    /// Optional ARGB seed for the secondary tonal palette.
    ///
    /// If omitted, uses `primary` hue and chroma. Set `secondaryChroma` to 16
    /// for a Material 3 match.
    int? secondary,

    /// Optional ARGB seed for the tertiary tonal palette.
    ///
    /// If omitted, uses `primary` hue plus `tertiaryHueRotation` (default 60)
    /// and `primary` chroma. Set `tertiaryChroma` to 24 for a Material 3 match.
    int? tertiary,

    /// Optional ARGB seed for the error tonal palette.
    ///
    /// If omitted, uses Material 3 default hue 25 and chroma 84. Override with
    /// `errorChroma` / `errorMinChroma` when a red primary clashes with that
    /// default.
    int? error,

    /// Optional ARGB seed for the neutral tonal palette.
    ///
    /// If omitted, uses `primary` hue with chroma 4 (not 16). Override with
    /// `neutralChroma` / `neutralMinChroma`.
    int? neutral,

    /// Optional ARGB seed for the neutral variant tonal palette.
    ///
    /// If omitted, uses `primary` hue with chroma 8. Override with
    /// `neutralVariantChroma` / `neutralVariantMinChroma`.
    int? neutralVariant,

    /// Fixed Cam16 chroma for the primary palette, or null to use the seed.
    ///
    /// Used when it is at least `primaryMinChroma` (Flutter
    /// [ColorScheme.fromSeed] default min is 48).
    final double? primaryChroma,

    /// Minimum Cam16 chroma for the primary palette.
    ///
    /// Defaults to 48, matching Flutter SDK. Used when the seed or
    /// `primaryChroma` is lower.
    final double? primaryMinChroma,

    /// Fixed Cam16 chroma for the secondary palette, or null to use the seed.
    ///
    /// [ColorScheme.fromSeed] locks this to 16, which yields soft muted
    /// mid-tones. Defaults to null; set to 16 for a Material 3 match.
    final double? secondaryChroma,

    /// Minimum Cam16 chroma for the secondary palette.
    ///
    /// Defaults to 0. Flutter has no secondary min; it always uses chroma 16.
    final double? secondaryMinChroma,

    /// Fixed Cam16 chroma for the tertiary palette, or null to use the seed.
    ///
    /// [ColorScheme.fromSeed] locks this to 24 (softer than primary, a bit
    /// less muted than secondary). Defaults to null; set to 24 for a Material 3
    /// match.
    final double? tertiaryChroma,

    /// Minimum Cam16 chroma for the tertiary palette.
    ///
    /// Defaults to 0. Flutter has no tertiary min; it always uses chroma 24.
    final double? tertiaryMinChroma,

    /// Degrees to rotate `primary` hue when `tertiary` is omitted.
    ///
    /// Ignored if a `tertiary` seed is given. Use 0 to keep all palettes close
    /// to the primary hue. Defaults to 60.
    final double? tertiaryHueRotation,

    /// Fixed Cam16 chroma for the neutral palette.
    ///
    /// Defaults to 4, matching [ColorScheme.fromSeed]. Set to null and keep
    /// `neutralMinChroma` at 0 to use chroma from the `neutral` seed; that seed
    /// should then have very low chroma.
    final double? neutralChroma = 4,

    /// Minimum Cam16 chroma for the neutral palette.
    ///
    /// Defaults to 0. Flutter has no neutral min; it always uses chroma 4.
    final double? neutralMinChroma,

    /// Fixed Cam16 chroma for the neutral variant palette.
    ///
    /// Defaults to 8, matching [ColorScheme.fromSeed]. Set to null and keep
    /// `neutralVariantMinChroma` at 0 to use chroma from the `neutralVariant`
    /// seed; that seed should then have very low chroma.
    final double? neutralVariantChroma = 8,

    /// Minimum Cam16 chroma for the neutral variant palette.
    ///
    /// Defaults to 0. Flutter has no neutral-variant min; it always uses
    /// chroma 8.
    final double? neutralVariantMinChroma,

    /// Fixed Cam16 chroma for the error palette, or null to use the seed.
    ///
    /// Defaults to null. Set to 84 to keep the Material 3 error chroma on a
    /// custom error hue.
    final double? errorChroma,

    /// Minimum Cam16 chroma for the error palette.
    ///
    /// Defaults to 0. Flutter has no error min; it always uses chroma 84.
    final double? errorMinChroma,

    /// Tones included in the produced palettes.
    ///
    /// [FlexPaletteType.common] has 15 tones; [FlexPaletteType.extended] has 24.
    final FlexPaletteType paletteType = FlexPaletteType.common,

    /// If true, use CAM16 to get hue and chroma from seeds; if false, use HCT
    /// `fromInt` (faster, matching Flutter 3.22+ [ColorScheme.fromSeed]).
    ///
    /// Defaults to true. FSS seeded schemes keep Cam16; Material 3 seeded
    /// schemes in Flutter use HCT.
    final bool useCam16 = true,

    /// If true, equal RGB seeds are treated as chroma 0 so palettes stay
    /// greyscale, and min chroma is ignored for those seeds.
    ///
    /// Defaults to false to match MCU and [ColorScheme.fromSeed] (white/grey
    /// map to cyan-ish palettes, black to red-ish). Non-monochrome seeds are
    /// unchanged.
    final bool respectMonochromeSeed = false,
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

    // If a fixed chroma was given we use it instead of chroma in primary.
    final double effectivePrimaryChroma = primaryChroma ?? primaryComputedChroma;
    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedPrimaryChroma = respectMonochromeSeed && _isMonochrome(primary)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(primaryMinChroma ?? 48, effectivePrimaryChroma);
    // Compute the tonal palette for primary colors, using the computed hue
    // and the used chroma value.
    final FlexTonalPalette tonalPrimary = FlexTonalPalette.of(primaryComputedHue, usedPrimaryChroma, paletteType);

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
    final double effectiveSecondaryChroma = secondaryChroma ?? secondaryComputedChroma;
    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedSecondaryChroma = respectMonochromeSeed && _isMonochrome(secondary ?? primary)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(secondaryMinChroma ?? 0, effectiveSecondaryChroma);
    // Compute the tonal palette for secondary colors, using the computed hue
    // and the used chroma value.
    final FlexTonalPalette tonalSecondary = FlexTonalPalette.of(secondaryComputedHue, usedSecondaryChroma, paletteType);

    // Tertiary TonalPalette calculation.
    //
    // Provided key color may be null, then we use primary as key color.
    late final double tertiaryComputedChroma;
    late final double tertiaryComputedHue;
    if (tertiary == null) {
      // If we had no tertiary keyColor, we won't use primary key's hue
      // directly, we add 60 degrees to it, this is the M3 way to shift hue
      // from a single key.
      tertiaryComputedHue = MathUtils.sanitizeDegreesDouble(primaryComputedHue + (tertiaryHueRotation ?? 60));
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
    final double effectiveTertiaryChroma = tertiaryChroma ?? tertiaryComputedChroma;
    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedTertiaryChroma = respectMonochromeSeed && _isMonochrome(tertiary ?? primary)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(tertiaryMinChroma ?? 0, effectiveTertiaryChroma);
    // Compute the tonal palette for tertiary colors, using the computed hue
    // and the used chroma value.
    final FlexTonalPalette tonalTertiary = FlexTonalPalette.of(tertiaryComputedHue, usedTertiaryChroma, paletteType);

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
    final double effectiveNeutralChroma = neutralChroma ?? neutralComputedChroma;
    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedNeutralChroma = respectMonochromeSeed && _isMonochrome(neutral ?? primary)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(neutralMinChroma ?? 0, effectiveNeutralChroma);
    // Compute the tonal palette for neutral colors, using the computed hue
    // and the used chroma value.
    final FlexTonalPalette tonalNeutral = FlexTonalPalette.of(neutralComputedHue, usedNeutralChroma, paletteType);

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
    final double effectiveNeutralVariantChroma = neutralVariantChroma ?? neutralVariantComputedChroma;
    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedNeutralVariantChroma = respectMonochromeSeed && _isMonochrome(neutralVariant ?? primary)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(neutralVariantMinChroma ?? 0, effectiveNeutralVariantChroma);
    // Compute the tonal palette for neutral variant colors, using the computed
    // hue and the used chroma value.
    final FlexTonalPalette tonalNeutralVariant = FlexTonalPalette.of(
      neutralVariantComputedHue,
      usedNeutralVariantChroma,
      paletteType,
    );

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

    // If we recognize monochrome input, we set chroma to 0 for monochrome.
    final double usedErrorChroma = respectMonochromeSeed && error != null && _isMonochrome(error)
        ? 0
        // We use the effectiveChroma, but only if it is over the min level.
        : math.max(errorMinChroma ?? 0, effectiveErrorChroma);
    // Compute the tonal palette for neutral colors, using the computed hue
    // and the used chroma value.
    final FlexTonalPalette tonalError = FlexTonalPalette.of(errorComputedHue, usedErrorChroma, paletteType);

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
  // ignore: sort_constructors_first
  FlexCorePalette.fromList(
    List<int> colors, [
    FlexPaletteType paletteType = FlexPaletteType.common,
  ]) : assert(
         (colors.length == size * FlexTonalPalette.commonSize && paletteType == FlexPaletteType.common) ||
             (colors.length == size * FlexTonalPalette.extendedSize && paletteType == FlexPaletteType.extended),
         'Incorrect size.',
       ),
       primary = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           0,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       ),
       secondary = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           1,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       ),
       tertiary = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           2,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       ),
       neutral = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           3,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       ),
       neutralVariant = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           4,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       ),
       _error = FlexTonalPalette.fromList(
         _getPartition(
           colors,
           5,
           paletteType == FlexPaletteType.common ? FlexTonalPalette.commonSize : FlexTonalPalette.extendedSize,
         ),
         paletteType,
       );

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

  /// Returns true if the RGB of [intColor] is monochrome.
  ///
  /// To be monochrome, the red, green, and blue values must be equal.
  static bool _isMonochrome(int intColor) {
    final Color color = Color(intColor);
    return color.red8bit == color.green8bit && color.green8bit == color.blue8bit;
  }

  /// Returns a partition from a list.
  ///
  /// For example, given a list with 2 partitions of size 3.
  /// range = [1, 2, 3, 4, 5, 6];
  ///
  /// range.getPartition(0, 3) // [1, 2, 3]
  /// range.getPartition(1, 3) // [4, 5, 6]
  static List<int> _getPartition(List<int> list, int partitionNumber, int partitionSize) {
    return list.sublist(
      partitionNumber * partitionSize,
      (partitionNumber + 1) * partitionSize,
    );
  }
}
