import 'package:flex_seed_scheme/flex_seed_scheme.dart';

// TODO(rydmike): Not used in the current example app, may add it back later.

// Example definition of light custom tones config.
const FlexTones myLightTones = FlexTones.light(
  primaryTone: 30, // Default is 40.
  onPrimaryTone: 96, // Default is 100
  onSecondaryTone: 96, // Default is 100
  onTertiaryTone: 96, // Default is 100
  onErrorTone: 96, // Default is 100
  primaryMinChroma: 55, // Default is null, min 48 is then used.
  secondaryChroma: 25, // Default is null, chroma from seed is then used.
  tertiaryChroma: 40, // Default is null, chroma from seed is then used.
  neutralChroma: 5, // Default is 6, avoid very high values in light mode.
  neutralVariantChroma: 10, // Default is 8
  paletteType: FlexPaletteType.extended, // Extended is also the default.
);

// Example definition of dark custom tones config.
const FlexTones myDarkTones = FlexTones.dark(
  primaryTone: 70, // Default is 80.
  onPrimaryTone: 6, // Default is 20
  onSecondaryTone: 6, // Default is 20
  onTertiaryTone: 6, // Default is 20
  onErrorTone: 6, // Default is 20
  primaryMinChroma: 55, // Default is null, min 48 is then used.
  secondaryChroma: 25, // Default is null, chroma from seed is then used.
  tertiaryChroma: 40, // Default is null, chroma from seed is then used.
  neutralChroma: 7, // Default is 6, you can go higher in dark mode than light.
  neutralVariantChroma: 14, // Default is 8
  paletteType: FlexPaletteType.extended, // Extended is also the default.
);
