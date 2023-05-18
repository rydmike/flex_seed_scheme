/// A more flexible version of Flutter's ColorScheme.fromSeed, use multiple
/// seed colors, custom chroma and tone mapping.
library flex_seed_scheme;

/// An intermediate concept between the key color for a UI theme, and a full
/// color scheme. Totally 5 tonal palettes are generated, plus a fixed error
/// palette.
export 'src/flex/flex_core_palette.dart';

/// Extension on `ColorScheme` to give us `SeedColorScheme.fromSeeds`.
export 'src/flex/flex_seed_scheme.dart' show SeedColorScheme;

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
