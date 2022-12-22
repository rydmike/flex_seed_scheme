[![Pub Version](https://img.shields.io/pub/v/flex_seed_scheme?label=flex_seed_scheme&labelColor=333940&logo=dart)](https://pub.dev/packages/flex_seed_scheme) [![codecov](https://codecov.io/gh/rydmike/flex_seed_scheme/branch/master/graph/badge.svg?token=YFNVrvWAXw)](https://codecov.io/gh/rydmike/flex_seed_scheme) [![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

# FlexSeedScheme

A more flexible version of Flutter's ColorScheme.fromSeed.

Use this package like `ColorScheme.fromSeed` with the following additional capabilities:

* Use separate key colors to generate seed based tonal palettes for primary and optionally 
  secondary, tertiary as well as error, neutral and neutral variant colors in `ColorScheme`.
* Change the chroma limits and values used in the Material 3 default strategy for tonal palette 
  generation in the new Google HCT (Hue-Chroma.Tone) color space.
* Change which tones in the generated core tonal palettes are used by which `ColorScheme` color.
  Changes are limited to the tones from correct core palette for each `ColorScheme` color, but
  any tone from it can be used. Going up or down one tone is often usable, in some cases even two.
* Use two additional tonal palettes tones, 5 and tone 98. They can be used to offer more
  fidelity at the dark and light end of the tonal palettes, and can be mapped to `ColorScheme` colors
  when using custom tone mapping. Tone 98 was previously also available in the web-based 
  [Material 3 Theme Builder](https://m3.material.io/theme-builder#/custom), but is no longer so, 
  and is also not included in the [Material 3 design guide](https://m3.material.io/styles/color/the-color-system/key-colors-tones). The guide explicitly mentions thirteen 
  tones and excludes tone 98. With **FlexSeedScheme** you can use fifteen tones, including 98 and 5.

## Background

This package was extracted from the customizable color scheme seeding engine in the
[**FlexColorScheme**](https://pub.dev/packages/flex_color_scheme) package to its own package.

This allows developers to use the same customizable `ColorScheme` seeding algorithms used by
**FlexColorScheme**, without using the FlexColorScheme package.
Starting with **FlexColorScheme** version 6 and later, it depends on this package instead.

If you use **FlexColorScheme** version 6 or later, you do not need to add **FlexSeedScheme** to
use its features, FlexColorScheme exports its API as well.
If you use FlexColorScheme you typically do not even need to use FlexSeedScheme directly,
its usage is baked in and used based on how you configure FlexColorScheme.

## Getting Started

Add the `flex_seed_scheme` package to `pubspec.yaml`:

`dart pub add flex_seed_scheme` or `flutter pub add flex_seed_scheme`

## Usage

Import the package to use it:

```dart
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
```

Define seed key colors that will be used to compute your seed generated `ColorScheme`.

```dart
// Define your seed colors.
const Color primarySeedColor = Color(0xFF6750A4);
const Color secondarySeedColor = Color(0xFF3871BB);
const Color tertiarySeedColor = Color(0xFF6CA450);
```

With **FlexSeedScheme** you make a seed generated `ColorScheme` using `SeedColorScheme.fromSeeds`.
It works like `ColorScheme.fromSeed`, but instead of only accepting a single seed color, it can use
six key colors as seed colors. One for each main color (primary, secondary and tertiary) group 
in `ColorScheme`. You can customize the `error` colors, typically there is no need to do so, but
if your primary color is of a red hue, that conflicts with the error colors, then adjusting the error
color is a possibility. You can also use custom key colors to seed generate the neutral and 
neutral variant palettes, that are used to define all the surface and background colors in
`ColorScheme`. We recommend sticking to the default that uses primary key color's hue with very low
chroma.

Chroma limits that differ from Material 3 defaults for tonal palette generation, can also be 
defined. Additionally, tone mapping, that defines which tone is used by what `ColorScheme` color, 
can be customized. Both are done via `FlexTones` passed in to `tones`.

Typically, you should use the same key colors and tones setup to produce the `ColorScheme` for 
light and dark theme mode. This guarantees that the light and dark theme use identical generated
tonal palettes, and only vary based on which tones are used for what color in light and dark mode.
This results in matching light and dark theme colors. This is just the norm though, feel free
to experiment.

```dart
    // Make a light ColorScheme from the seeds.
    final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      // Primary key color is required, like seed color ColorScheme.fromSeed.
      primaryKey: primarySeedColor,
      // You can add optional own seeds for secondary and tertiary key colors.
      secondaryKey: secondarySeedColor,
      tertiaryKey: tertiarySeedColor,
      // Tone chroma config and tone mapping is optional, if you do not add it
      // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
      tones: FlexTones.vivid(Brightness.light),
    );

    // Make a dark ColorScheme from the seeds.
    final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: primarySeedColor,
      secondaryKey: secondarySeedColor,
      tertiaryKey: tertiarySeedColor,
      tones: FlexTones.vivid(Brightness.dark),
    );
```
You can use separate key colors as seeds to generate the primary, secondary and tertiary tonal 
palettes. If no key color for `secondaryKey` and/or `tertiaryKey` are provided, they use
`primaryKey` color as their seed color value.

If you only specify `primaryKey` color as seed, and no custom `tones` configuration, identical 
`ColorScheme` result to `ColorScheme.fromSeed` is produced.

The default chroma limits in the HCT color space used for seed generated colors for secondary and
tertiary colors in `ColorScheme.fromSeed` have quite low chroma values. This makes the colors 
fairly muted or pastel like. This is especially the case with secondary colors. This is by design
in the standard Material 3 color palette. You can tune this behavior by passing in a custom
`FlexTones` configuration to `tones`. There are pre-made configurations you can use, above
`FlexTones.vivid` was used. It is also easy to make custom configurations. Look in `FlexTones`
and use the pre-made definitions as inspiration for your own configs.

Using the above configuration, the following core palettes are generated, in order from top to
bottom:

* Primary tonal palette
* Secondary tonal palette
* Tertiary tonal palette
* Error tonal palette
* Neutral tonal palette
* Neutral variant tonal palette

<img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/corepalettes.png?raw=true?" alt="palettes"/>

The above color tones in the above palettes are then mapped to `ColorScheme` colors. Mapping is
different for light and dark theme mode in order to create a color scheme with suitable contrast.
With the example `FlexTones.vivid` setup used in `tones`, the light `ColorScheme` is mapped as
shown below:

<img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/colorscheme.png?raw=true?" alt="colorscheme"/>

And the dark `ColorScheme` becomes:

<img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/colorscheme_dark.png?raw=true?" alt="colorscheme_dark"/>

We can, for example, see that in light mode, the primary tone 30, is assigned to `ColorScheme.primary`
color and tone 90 to `primaryContainer`. In dark mode they get tones 80 and 20. Similar assignments
are repeated for secondary, tertiary, error colors and all the surface and background colors.
It is this mapping that `FlexTones` gives you control over.

### Define ThemeData

In your `MaterialApp` you then define your light and dark mode themes using the seed 
generated `ColorScheme`s just as you would with any other `ColorScheme`. For example:

```dart
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeedColorScheme.fromSeeds Demo',
      themeMode: ThemeMode.system,  
      theme: ThemeData.from(
        colorScheme: schemeLight,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: schemeDark,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
```

### Override Color Values

All colors in the seed produced `ColorScheme` can be overridden by providing each `ColorScheme`
color property in `SeedColorScheme.fromSeeds` a given color value. This feature is equivalent to
`ColorScheme.fromSeed`.

This is typically used to assign a given color value to `primary` color, which is often used as app
brand color. When the brand color is used as `primaryKey` seed color, it typically does 
not end up as the `primary` color in the seed generated `ColorScheme`. Having a given brand color as
`primary` color is often desired. To get the seed color as your `primary` brand color, assign the
color used as `primaryKey` to `primary` color as well.

```dart
    // Make a light ColorScheme from the seeds.
    final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      // Use a "brand" seed color as primary color in the result.
      primary: primarySeedColor,
      primaryKey: primarySeedColor,
      //
      secondaryKey: secondarySeedColor,
      tertiaryKey: tertiarySeedColor,
      tones: FlexTones.vivid(Brightness.light),
    );
```

This strategy works well for the light mode `ColorScheme`, since the prominent brand color a company
has defined is typically intended to be printed on white paper. If you have secondary brand colors
that are to be used, using them as seeds for `secondaryKey` and `tertiaryKey` will work too.
How well they will fit and match the Material 3 color system, if assigned to 
`secondary` and `tertiary` directly as colors in `SeedColorScheme.fromSeeds`, will vary depending 
on what colors they are.

Companies rarely have brand colors suited for good contrast in dark theme mode. In that case 
prefer only using the same light mode brand colors as key colors to seed the dark mode 
`ColorScheme`. If they do have dark mode specifications, and the colors are of same hue as 
light mode, consider still using the light mode colors as the seed source, and only applying the 
appropriate dark mode colors to `primary`, `secondary` and `tertiary` as needed.

If there is a spec that calls for completely different main colors in dark mode, with different 
hues, then seeding from them and also setting `primary`, `secondary` and `tertiary` to these 
color values is appropriate.

### Customize Tones and Chroma

In the above example, we used a predefined tone mapping and chroma setup called `FlexTones.vivid`.
There are currently nine predefined configurations available:

* `FlexTones.material`, default and same as Flutter SDK M3 setup.
* `FlexTones.soft`, softer and earthier tones than M3 FlexTones.material.
* `FlexTones.vivid`, more vivid colors, uses chroma as defined by each given key color.
* `FlexTones.vividSurfaces`, like `vivid`, but with more color tint in surfaces and backgrounds.
* `FlexTones.highContrast`, can be used for more color-accessible themes.
* `FlexTones.ultraContrast`, for a very high-contrast theme version.
* `FlexTones.jolly`, for a more "jolly" and colorful theme.
* `FlexTones.vividBackground`, like `vividSurfaces`, but tone mapping for `surface` and `background` are swapped.
* `FlexTones.oneHue`, a balanced chromatic setup. It is called oneHue because When only primary color is used as seed, it does not rotate its hue value to make a computed hue for tertiary tonal palettes, but uses the same hue. This makes it possible to make seed-generated color schemes from a single color. In such themes, all colors are based on the same hue, but using different chroma and tones to create a one color hue based theme. 

You can define custom tones mapping and chroma limitation setups with `FlexTones`. Prefer using
the `FlexTones.light` and `FlexTones.dark` constructors as base for custom definitions. By using
them, you only need to override defaults that you want to change.

```dart
// Example definition of light custom tones config.
const FlexTones myLightTones = FlexTones.light(
  primaryTone: 30, // Default is 40.
  onPrimaryTone: 95, // Default is 100
  onSecondaryTone: 95, // Default is 100
  onTertiaryTone: 95, // Default is 100
  onErrorTone: 95, // Default is 100
  primaryMinChroma: 55, // Default is 48
  secondaryChroma: 25, // Default is 16
  tertiaryChroma: 40, // Default is 24
  neutralChroma: 7, // Default is 4,
  neutralVariantChroma: 14, // Default is 8
);

// Example definition of dark custom tones config.
const FlexTones myDarkTones = FlexTones.dark(
  primaryTone: 70, // Default is 80.
  onPrimaryTone: 10, // Default is 20
  onSecondaryTone: 10, // Default is 20
  onTertiaryTone: 10, // Default is 20
  onErrorTone: 10, // Default is 20
  primaryMinChroma: 55, // Default is 48
  secondaryChroma: 25, // Default is 16
  tertiaryChroma: 40, // Default is 24
  neutralChroma: 7, // Default is 4,
  neutralVariantChroma: 14, // Default is 8
);

```

### Accessibility

You can use `FlexTones` to create a seed generated `ColorScheme`, that is based on same colors
as your standard theme's light and dark scheme colors, but uses a chroma configuration and tone 
mapping setup that increases contrast further from standard light and dark theme setup.

There are two high contrast `FlexTones` configuration pre-made for this. They are called 
`FlexTones.highContrast`, a colorful high-contrast version, and `FlexTones.ultraContrast`, a less 
colorful version, a more dark on light in light theme mode, and light on dark in dark mode.

```dart
// Make a high contrast light ColorScheme from the seeds.
final ColorScheme schemeLightHc = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
tones: FlexTones.highContrast(Brightness.light),
);

// Make a ultra contrast dark ColorScheme from the seeds.
final ColorScheme schemeDarkHc = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.ultraContrast(Brightness.dark),
);
```

If you then define equivalent `ThemeData` based on those schemes as your standard `MaterialApp`,
`theme` and `darkTheme` definitions, but assign them to `highContrastTheme` and 
`highContrastDarkTheme`, you get more accessible themed colors that are based on same colors, 
but with higher contrast, that are activated when users select high-contrast theme in device
accessibility system settings. Changing to accessibility theme based on device system setting 
automatically, by using theme data defined on `MaterialApp` properties `highContrastTheme` and
`highContrastDarkTheme`, is only supported on **iOS** devices in the current version of Flutter SDK.

```dart
      // Define accessibility high contrast versions using same color base.
      //
      highContrastTheme: ThemeData.from(
        colorScheme: schemeLightHc,
        useMaterial3: true,
      ),
      highContrastDarkTheme: ThemeData.from(
        colorScheme: schemeDarkHc,
        useMaterial3: true,
      ),
```

Another way to modify `FlexTones` configurations for contrast and accessibility, is by forcing all 
main onColors and all surface onColors to only use black and white contrasting colors. If we
remove in the Material 3 guide used color system's colored contrasting colors, we can improve
color accessibility and contrast on any `FlexTones` configuration. We can do this with the
`FlexTones` modifying methods `onMainsUseBW()`, for main onColors and with `onSurfacesUseBW()`
for the surface onColors. The main colors are primary, secondary, tertiary, error and their
containers. The surface colors are background, surface, surfaceVariant and inverseSurface.

```dart
// Make a Material 3 seeded light ColorScheme, 
// but with always black and white contrasting onColors.
final ColorScheme schemeLightOnBW = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
tones: FlexTones.material(Brightness.light).onMainsUseBW().onSurfacesUseBW(),
);

// Make a Vivid dark ColorScheme, 
// but with always black and white contrasting onColors.
final ColorScheme schemeDarkOnBW = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.vivid(Brightness.dark).onMainsUseBW().onSurfacesUseBW(),
);
```

### Example Application

The included example application uses above color seeding and custom 
tone mapping, and you can also choose any of the built-in pre-configured tone mappings. You can 
choose to use secondary and primary seed colors as additional keys to generate the color schemes.
You can also try to keep all the contrasting onColors black and white. 

With the app we can compare results from `FlexSeedScheme.fromSeeds`, to using the single seed color 
`ColorScheme.fromSeed` seed generated Material 3 `ColorScheme` available in Flutter.

Both use the same key color as primary seed color, but `ColorScheme.fromSeed` can only use it as 
a single seed color, we cannot get any hues from our primary and secondary key colors in the 
produced seed generated `ColorScheme` with it. 


With `ColorScheme.fromSeed` we can also not customize the colorfulness (chroma) 
of its seed generated secondary and tertiary colors. Like we can with `FlexSeedScheme.fromSeeds`, 
demonstrated here by choosing different `FlexTones` configurations. The tonal palette tones to
`ColorScheme` color mappings can also not be modified, lie we can do with
`FlexSeedScheme.fromSeeds`.

| Light from seeds - Custom tones                                                                                         | Dark from seeds - Custom tones                                                                                        |
|-------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/light_app.png?raw=true?" alt="light_app"/> | <img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/dark_app.png?raw=true?" alt="dark_app"/> |

| Light from single seed - Material 3 tones                                                                                     | Dark from single seed - Material 3 tones                                                                                    |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/light_app_m3.png?raw=true?" alt="light_app_m3"/> | <img src="https://github.com/rydmike/flex_seed_scheme/blob/master/doc_assets/dark_app_m3.png?raw=true?" alt="dark_app_m3"/> |

You can try a web version of this example [**here**](https://rydmike.com/flexseedscheme/demo-v1).