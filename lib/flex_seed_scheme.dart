// ignore_for_file: comment_references

/// A more flexible version of Flutter's ColorScheme.fromSeed, use multiple
/// seed colors, custom chroma and tone mapping.
library flex_seed_scheme;

/// Core palettes used to make a ColorScheme.
///
/// An intermediate concept between the key colors for a UI theme, and a full
/// ColorScheme. Totally 5 tonal palettes are generated, plus a fixed error
/// palette.
///
/// The core produced tonal palettes are [primary], [secondary], [tertiary],
/// [neutral], [neutralVariant] and [error].
export 'src/flex/flex_core_palette.dart';

/// Extension on `ColorScheme` to give us `SeedColorScheme.fromSeeds`.
export 'src/flex/flex_seed_scheme.dart' show SeedColorScheme;

/// A palette with 15 tones using same Hue and Chroma.
///
/// The Material default Tonal Palette includes 13 tones, FlexSeedScheme
/// FlexTonalPalette provides 15. The additional two tones are 5 and 98.
/// Tone 98 provides optional tonal fidelity in the light and white end of the
/// palette, and tone 5 a more dark tone in the black end of the palette.
///
/// Available tones are [0,5,10,20,30,40,50,60,70,80,90,95,98,99,100].
export 'src/flex/flex_tonal_palette.dart';

/// Defines which tone to use from each tonal palette, when assigning
/// used color to each color scheme color.
///
/// Also enables defining how Cam16 chroma is used and limited when
/// generating the tonal palettes.
export 'src/flex/flex_tones.dart';

/// From Material Color Utilities (MCU) export and show:
///
/// * Blend
/// * Cam16
/// * CorePalette
/// * TonalPalette
///
/// More API from MCU may be exported later.
export 'src/mcu/material_color_utilities.dart'
    show Blend, Cam16, CorePalette, TonalPalette;
