import 'package:flex_seed_scheme/flex_seed_scheme.dart';

// TODO(rydmike): Not used in the current example app, may add it back later.

// Example definition of light custom tones config.
const FlexTones myLightTones = FlexTones.light(
  primaryTone: 30, // Default is 40.
  onPrimaryTone: 96, // Default is 100
  onSecondaryTone: 96, // Default is 100
  onTertiaryTone: 96, // Default is 100
  onErrorTone: 96, // Default is 100
  primaryMinChroma: 55, // Default is 48
  secondaryChroma: 25, // Default is 16
  tertiaryChroma: 40, // Default is 24
  neutralChroma: 5, // Default is 4, avoid very high values in light mode.
  neutralVariantChroma: 10, // Default is 8
  paletteType: FlexPaletteType.extended, // Use extended palette type
);

// Example definition of dark custom tones config.
const FlexTones myDarkTones = FlexTones.dark(
  primaryTone: 70, // Default is 80.
  onPrimaryTone: 6, // Default is 20
  onSecondaryTone: 6, // Default is 20
  onTertiaryTone: 6, // Default is 20
  onErrorTone: 6, // Default is 20
  primaryMinChroma: 55, // Default is 48
  secondaryChroma: 25, // Default is 16
  tertiaryChroma: 40, // Default is 24
  neutralChroma: 7, // Default is 4, you can go higher in dark mode than light.
  neutralVariantChroma: 14, // Default is 8
  paletteType: FlexPaletteType.extended, // Use extended palette type
);
