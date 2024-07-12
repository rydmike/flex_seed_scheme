// ignore_for_file: comment_references

/// A more flexible version of Flutter's ColorScheme.fromSeed, use multiple
/// seed colors, custom chroma and tone mapping.
library;

/// Core palettes used to make a ColorScheme.
///
/// An intermediate concept between the key colors for a UI theme, and a full
/// ColorScheme. Totally 5 tonal palettes are generated, plus a fixed error
/// palette.
///
/// The core produced tonal palettes are [primary], [secondary], [tertiary],
/// [neutral], [neutralVariant] and [error].
export 'src/flex/flex_core_palette.dart';

/// Enum used to select which scheme variant algorithm to use when creating
/// a color scheme.
export 'src/flex/flex_scheme_variant.dart';

/// Extension on `ColorScheme` to give us `SeedColorScheme.fromSeeds`.
export 'src/flex/flex_seed_scheme.dart' show SeedColorScheme;

/// A palette with predefined tones using same Hue and Chroma.
///
/// The Material Color Utilities default Tonal Palette includes 13 tones,
/// FlexSeedScheme's FlexTonalPalette provides 15 when using
/// [FlexPaletteType.common].
/// The additional two tones are 5 and 98. Tone 98 provides optional tonal
/// fidelity in the light and white end of the palette, and tone 5 a more dark
/// tone in the black end of the palette.
///
/// The [FlexPaletteType.common] tones are
/// 0,5,10,20,30,40,50,60,70,80,90,95,98,99,100.
///
/// To get even more tones you can use [FlexPaletteType.extended] which provides
/// 25 tones, the additional tones are 2,4,6,12,17,22,24,87,92,94,96,97 for a
/// total of 27 tones, which are
/// 0,2,4,5,6,10,12,17,20,22,24,30,40,50,60,70,80,87,90,92,94,95,96,97,98,99,100
///
/// The new tones are also used by the new [ColorScheme] in updated Material-3
/// design system that landed in Flutter 3.22.0.
export 'src/flex/flex_tonal_palette.dart';

/// Defines which tone to use from each tonal palette, when assigning
/// used color to each color scheme color.
///
/// Also enables defining how Cam16 chroma is used and limited when
/// generating the tonal palettes.
export 'src/flex/flex_tones.dart';

/// From internal version of Material Color Utilities (MCU) export and show:
///
/// * Blend
/// * Cam16
/// * CorePalette
/// * DynamicScheme
/// * Hct
/// * TonalPalette
/// * ViewingConditions
///
/// More APIs from MCU can be exported if needed, let us know if needed.
/// The ones exported here are the ones used by FlexSeedScheme, its example
/// FlexColorPicker and FlexColorScheme and its example, like the example 5
/// the Themes Playground.
export 'src/mcu/material_color_utilities.dart'
    show
        Blend,
        Cam16,
        CorePalette,
        DynamicScheme,
        Hct,
        TonalPalette,
        ViewingConditions;
