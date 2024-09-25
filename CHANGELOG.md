# Changelog

All notable changes to the **FlexSeedScheme** (FSS) package are documented here.

## 3.4.1

**Sep 25, 2024**

**PACKAGE**

* No changes to the FlexSeedScheme package!

**WEB DEMO**

* Updated the web demo example to use FlexColorPicker version 3.6.0, where the tonal palette can now also respect monochrome seed colors as its displayed Material tonal palette. This is a new feature in FlexColorPicker 3.6.0. 
  * In the updated Web demo, the picker's setting is tied into the demo using the setting `respectMonochromeSeed` so the picker only uses it when the FlexSeedScheme web demo is configured to do so. The setting for the FlexColorPicker to make monochrome tonal palette for monochrome input and to use chroma of selected color, is a separate feature in the picker, it is not tied to FlexSeedScheme, but for this demo they are linked and use the same settings toggle.    

## 3.4.0

**Sep 23, 2024**

**CHANGE**

* The parameter `useExpressiveOnContainerColors` in `SeedColorScheme.fromSeeds` now works with a scheme `variant` regardless of if it has `isFlutterScheme` set to true or false. Meaning it impacts both MCU `DynamicSchemeVariant` and FSS `FlexTones` based scheme variants.

  * For `FlexTones` based variants, when using a built-in `FlexTones` or even a custom one, it is no longer necessary to use the `FlexTones` modifier `.expressiveOnContainer()` on the used `tones` to get a seeded color scheme with expressive on container tones in light mode.
  * The `FlexTones` based modifier `.expressiveOnContainer()` is still used, but it is applied internally when the flag `useExpressiveOnContainerColors` is set to true.
  * The `useExpressiveOnContainerColors` only applies in light mode to on container tones that are equal to 10, other tones are considered custom on purpose and are not changed. This is in-line with that the MCU `DynamicSchemeVariant`s that did not use tone 30 before as on container color in light mode, like Fidelity, Monochrome and Content were not affected by this change in MCU 0.12.0. In the same manner, this flag no longer changes `FlexTones` based schemes that have on container tones that are not 10. This applies to some on container colors in UltraContrast, Candy Pop and Chroma predefined `FlexTones`.
  * This change makes this flag consistent and applicable to all seed generated schemes, regardless of if it is based on `DynamicSchemeVariant`, built-in `FlexTones` or even custom `FlexTones` configurations.
  * For MCU seed generated schemes, `useExpressiveOnContainerColors` only has any impact when contrast level is at the default value (0), normal contrast.
  * When using FFS seed generated schemes with `useExpressiveOnContainerColors` set to true, the modifier is applied before any `FlexTones` modifiers. Using tones modifiers, like e.g. `onMainsUseBW()` will thus as expected, override this setting and set on container colors to tone 0 or tone 100, depending on the container colors brightness.
  
**NEW**

* A new `bool` parameter, `respectMonochromeSeed` in `SeedColorScheme.fromSeeds` can now be used to make seed generated ColorSchemes that work as expected if a monochrome color is used as seed color input.
  * When set to `true`, any monochrome RGB input value will result in the creation of a greyscale tonal palette for the palette using the monochrome seed color. An RGB monochrome value is one where Red, Green and Blue values are all equal.
  * Previously in FSS and in Material Color Utilities (MCU) and thus still as default in Flutter `ColorScheme.fromSeed`, using a monochrome seed color value or white, resulted in a tonal palette with cyan color tones. A black input resulted in red like color tones. This is not very intuitive and not really expected when using monochrome seed colors.
  * FSS still defaults to setting `respectMonochromeSeed` to `false`, to not break any existing code that may rely on the old behavior. 
  * Prefer setting `respectMonochromeSeed` to `true`, to get more logical seed results when using monochrome seed colors or white and black as seed colors. 
  * **NOTE:** When using `respectMonochromeSeed` with `DynamicSchemeVariant` variants `fidelity` or `content`, for some monochrome input colors they produce `primaryContainer` and `onPrimaryContainer` as well as `tertiaryContainer` and `onTertiaryContainer` color pairs, with low contrast. Consider using some other scheme variants with monochrome seed colors. All others work well with any monochrome seed color. This is just how the MCU `DynamicScheme`s `SchemeContent` and `SchemeFidelity` are defined in MCU. They also produce fairly low contrast for these color pairs with very dark seed colors. This behavior with MCU's `SchemeContent` and `SchemeFidelity` could be fixed in FlexSeedScheme's internal MCU fork, but we want to keep the result of these schemes consistent with MCU.  

## 3.3.0

**Sep 7, 2024**

**NEW**

* Exposed `DynamicColor`, `MaterialDynamicColors` and `Scheme` from the underlying forked Material Color Utilities (MCU) library.
* Un-deprecated `Scheme`, that original MCU deprecated. It does not conflict with the new `DynamicSchemes` that replaced it, thus in the internal MCU fork, we do not need to deprecate it and can offer it for legacy access to old `ColorScheme.fromSeed` scheme result in use before Flutter 3.22.0. 
  * Internally FlexSeedScheme does not use `Scheme` for its own legacy version of the same scheme, it uses its FlexTones based setup instead, but produces the same color values. We still recommend using its tones `FlexTones.material3Legacy` version instead of `Scheme` for a legacy Material-3 seed generated `ColorScheme`. 
  * This API is provided for legacy access to the old MCU `Scheme` style and API, that was used in Flutter 3.19.0 and earlier in its `ColorScheme.fromSeed` constructor back then. If you want to recreate its exact older internal API algorithm, you can now do so using `Scheme` that it used to use before Flutter 3.22.0.
  * This revived `Scheme` class was also complemented with the new `ColorScheme` colors added in Flutter 3.22.0, but it uses legacy Flutter 3.19 and earlier tone mappings for all colors that existed then. Except for dark mode `onErrorContainer` that it corrected from 80 to 90. It was always a bug in Flutter version 3.19 and earlier that tone 80 was used.

## 3.2.0

**Aug 27, 2024**


**CHANGE**
  
* The `FlexPaletteType.extended` tones got three new tones, tones 65, 75 and 84. It now has 30 tones.
  
**NEW**

* The `tones` configuration class `FlexTones` got a new modifier, `higherContrastFixed()`. It can be applied to any predefined or custom `FlexTones` to make a returned `FlexTones` instance where the tones for the fixed colors `fixed`, `onFixed`, `fixedDim` and `onFixedVariant` are set to **92, 6, 84 and 12** instead of their Material-3 specification tones **90, 10, 80 and 30**. This for an alternative set of fixed colors with more contrast.


## 3.1.2

**July 23, 2024**

**FIX**

* FIX the faulty tones for the modified `FlexTones.vividSurfaces` surface tones. They were in version 3.1.0 set to **96** for a light scheme and **10** for a dark scheme. The values need to be **98** and **6** to not clash with any other important tones used by all the surface colors and provide separation to them. Tones **98** and **6** are also the default tones in M3 design for them, there is very little wiggle room here.

* FIX tone for the modified `FlexTones.vividBackground` it was in version 3.1.0 set to **97** for its light scheme, it needs to use value 100 (white) to really provide a "vivid" background mode in light mode and offer some differentiation to `FlexTones.vividSurfaces` in light mode. In dark mode it still uses tone **5**, which is already different and darker than **6** used by `FlexTones.vividSurfaces`.

**INFO**

* How to use legacy `FlexTones.vividSurfaces` and `FlexTones.vividBackground` tone mappings?
  * FSS version 3.1.0 removed the deprecated colors `background`, `onBackground` and `surfaceVariant` from being defined as a part of the `SeedColorScheme.fromSeeds` result. They still get color values, but they are whatever the default values the default Flutter SDK `ColorScheme()` constructor gives them. These colors were deprecated in Flutter 3.22.0 and are now removed from being defined and accessed by FSS.
  * FSS 3.1.0 also changed the tone mappings for `FlexTones.vividSurfaces` and `FlexTones.vividBackground` to make them have some distinguishing differences when `background` color no longer has any effect or usage, and also to adhere to new the `ColorScheme` design intent.
  * You should prefer to map one of the new surface colors that are already of a shade close to old surface and background colors, to theme colors as needed by your design. There are **eight** different surface shades to choose from in the ColorScheme introduced in Flutter 3.22, compared to **three** before.
  * If you really need the pre-Flutter 3.22 legacy style for `FlexTones.vividSurfaces` or `FlexTones.vividBackground` you can optionally recreate them with `copyWith` on their definitions like this:

```dart
// For light legacy FlexTones.vividSurfaces 
final ColorScheme vividSurfacesLight = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: mySeedColor,
    tones: FlexTones.vividSurfaces(Brightness.light).copyWith(surfaceTone: 95),
  );
// For dark legacy FlexTones.vividSurfaces 
final ColorScheme vividSurfacesDark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: mySeedColor,
    tones: FlexTones.vividSurfaces(Brightness.dark).copyWith(surfaceTone: 20),
  );

// For light legacy FlexTones.vividBackground 
final ColorScheme vividBackgroundLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: mySeedColor,
  tones: FlexTones.vividBackground(Brightness.light).copyWith(surfaceTone: 98),
);
// For dark legacy FlexTones.vividBackground 
final ColorScheme vividBackgroundDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: mySeedColor,
  tones: FlexTones.vividBackground(Brightness.dark).copyWith(surfaceTone: 6),
);
```

## 3.1.1

**July 13, 2024**

**CHORE**

* FIX the pub score.
* Update readme.

## 3.1.1-dev.1

**July 12, 2024**

**CHORE**

* Experiment to find and remove references from the package to deprecated properties for scoring purposes. The deprecated colors are **NOT** used anymore, but pub's pana analyzer still complains. It happily ignores the "allow usage of self-deprecated members" setting. It also complains about references used in doc comments. This is the first attempt to find and fix all things it complains about.

## 3.1.0

**July 12, 2024**

**CHANGE**
* Removes the in Flutter 3.22.0 deprecated `ColorScheme` colors `background`, `onBackground` and `surfaceVariant` from being defined as a part of the `SeedColorScheme.fromSeeds` result. They still get color values, but they are whatever the default values the default Flutter SDK `ColorScheme()` constructor gives them. These colors were deprecated in Flutter 3.22.0 and are now removed from being defined and accessed by FSS.
  * The removal is done to keep FSS in sync with Flutter SDK and to avoid using deprecated colors.
  * These colors should in application usage be replaced by `surface`, `onSurface` and `surfaceContainerLowest` in Flutter 3.22.0 and later.
    * If you for some reason in Flutter 3.22.0 and later still need the deprecated colors, use FSS version 3.0.0.

* To make `FlexTones.vividSurfaces` and `FlexTones.vividBackground` have some distinguishing differences when `background` color no longer has any effect or usage, the following changes were made to their tone mappings:
  * `FlexTones.vividSurfaces`: 
    * Light: surfaceTone 95 -> 96, 
    * Dark: surfaceTone 20 -> 10.
  * `FlexTones.vividBackground`:
    * Light: surfaceTone 98 -> 97,
    * Dark: surfaceTone 6 -> 5.

* How to use legacy `FlexTones.vividSurfaces` and `FlexTones.vividBackground` tone mappings?
  * You should prefer to map one of the new surface colors that are already of a shade close to old surface and background colors, to theme colors as needed by your design. There are **eight** different surface shades to choose from in the ColorScheme introduced in Flutter 3.22, compared to **three** before.
  * If you really need the pre-Flutter 3.22 legacy style for `FlexTones.vividSurfaces` or `FlexTones.vividBackground` you can optionally recreate them with `copyWith` on their definitions like this:

```dart
// For light legacy FlexTones.vividSurfaces 
final ColorScheme vividSurfacesLight = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: mySeedColor,
    tones: FlexTones.vividSurfaces(Brightness.light).copyWith(surfaceTone: 95),
  );
// For dark legacy FlexTones.vividSurfaces 
final ColorScheme vividSurfacesDark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: mySeedColor,
    tones: FlexTones.vividSurfaces(Brightness.dark).copyWith(surfaceTone: 20),
  );

// For light legacy FlexTones.vividBackground 
final ColorScheme vividBackgroundLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: mySeedColor,
  tones: FlexTones.vividBackground(Brightness.light).copyWith(surfaceTone: 98),
);
// For dark legacy FlexTones.vividBackground 
final ColorScheme vividBackgroundDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: mySeedColor,
  tones: FlexTones.vividBackground(Brightness.dark).copyWith(surfaceTone: 6),
);
```

**CHORE**

* Update `all_lint_rules.yaml`.

**EXAMPLE**

* Remove showing the deprecated colors `background`, `onBackground` and `surfaceVariant` in the example app.

## 3.0.0

**June 24, 2024**

Bring the bundled forked version of the package [Material Color Utilities (MCU)](https://pub.dev/packages/material_color_utilities) to feature parity with version 0.12.0 of the original package. The internal fork for the first time nw also adds features and capabilities that do not exist in the original package. Previously FSS only bundled MCU to avoid version conflicts with Flutter SDK when using different channels. Different Flutter channels typically pin incompatible versions of MCU.

The bundled forked version of MCU also has more tests than the original, allowing us to detect when any new MCU version "silently" changes color results it produced in the past. 


* **BREAKING**
  * The API for `SeedColorScheme.buildDynamicScheme` was changed to enable support for multiple seed colors on the MCU based `DynamicScheme` APIs and its extended schemes. For most normal use cases, you will not notice this, as it is quite a low-level API in FSS that end users normally do not use.
  

* **NEW** 
  * The forked internal MCU version received new features. The `DynamicScheme` can now accept an optional `customErrorPalette` and then `SchemeTonalSpot`, `SchemeContent`, `SchemeFidelity`, `SchemeExpressive`, `SchemeFruitSalad`, `SchemeMonochrome`, `SchemeNeutral`, `SchemeRainbow` and `SchemeVibrant` that extend `DynamicScheme` all received properties to support individual seed colors for all tonal palettes.

  * The above addition enables `SeedColorScheme.fromSeeds` to support using all its key seed colors also when using MCU based `DynamicScheme` variants and not just for `FlexTones` based `tones` and `variants`. When using key seed colors with MCU variants, they still respect their original design intent.  
 
  * Added support for `contrastLevel` to `SeedColorScheme.fromSeeds`. This allows you to set the desired contrast level of the generated color scheme when using `SeedColorScheme.fromSeeds` with the `variant` property, for variants that are based on MCU's `DynamicScheme`. Such variants have their `isFlutterScheme` set to true. 
    * The `contrastLevel` parameter indicates the contrast level between color pairs, such as `primary` and `onPrimary`.The value 0.0 is the default (normal); -1.0 is the lowest; 1.0 is the highest. From Material Design guideline, the medium and high-contrast levels correspond to 0.5 and 1.0 respectively.
    * The `contrastLevel` in Flutter SDK is not yet available in `ColorScheme.fromSeed` in Flutter stable 3.22.x, but is available on the master channel 3.23.x. With FSS you can use it already in Flutter 3.22.x.
    * **NOTE:** Using `contrastLevel` has no effect when using `tones`. However, with `tones` you can create custom tones with even more flexibility in seed generation to make schemes with higher or less contrast. Two pre-configured high contrast tones exist earlier via `FlexTones.highContrast` and `FlexTones.ultraContrast`.
   
  * Updated `MaterialDynamicColors` to optionally use the new Material expressive on-colors spec for none surface on-container colors. This feature is not on by default. You can opt in on this new standard by setting `useExpressiveOnContainerColors` to true in `SeedColorScheme.fromSeeds`.
    * This option is only available when using MCU based `DynamicScheme` variants and not when using `FlexTones` based `tones` and `variants`, plus it only applies to variants that are based on MCU's `DynamicScheme`. Such variants have their `isFlutterScheme` set to true.
    * Opting in changes the light mode color tone for the colors `onPrimaryContainer`, `onSecondaryContainer`, `onTertiaryContainer` and `onErrorContainer` from 10 to 30 making them more color expressive, but they also have less contrast.
    * The accepted min contrast curve is thus now `ContrastCurve(3, 4.5, 7, 11)` instead of `ContrastCurve(4.5, 7, 11, 21)` for the on-container colors. Meaning normal contrast of 4.5 is now accepted when it was 7 before. 
    * Prior to MCU version 0.12.0 the `MaterialDynamicColors` used an older M3 spec. Flutter stable 3.22.x and Flutter master 3.23.x still use MCU versions lower than 0.12.0 and default to the older color tones 10 in light mode. This will be changed in Flutter SDK when Flutter is updated to use MCU 0.12.0 or later. With FSS 3.0.0, you can opt in on using the new spec already now. But FSS still also defaults to the older spec with more contrast. When Flutter stable changes to use the new spec, FSS will also change to use it as default. While Flutter and MCU will then no longer offer the older higher contrast version, FSS will continue to do so.
    * The optional usage of the expressive colors for on-container colors is also a customization of MCU features in the forked version. We see value in being able to offer both the higher contrast older version and the new more color expressive one. 
    
  * The `tones` configuration class `FlexTones` got a new built-in modifier, `monochromeSurfaces()`. It can be applied to any predefined or custom `FlexTones` to make the surface colors monochrome and use pure greyscale for the neutral and neutral variant tonal palettes, with no color tint from their key color or primary key seed color. 

  * The `tones` configuration class `FlexTones` also got the new modifier, `expressiveOnContainer()`. It can be applied to any predefined or custom `FlexTones` to make a returned `FlexTones` instance where the tones for light mode on container tones are set to 30 for more color expressive container text and icons on none surface containers.
    * This modifier only impacts none surface on-container tones that are dark and thus only has any impact on the light theme mode on-container colors.
    * The impacted on container colors are `onPrimaryContainerTone`,`onSecondaryContainerTone`, `onTertiaryContainerTone` and `onErrorContainerTone`.
    * This feature brings optional light mode expressive on-container colors to any predefined or custom `FlexTones` configuration. The expressive on-color in light mode containers are a new change to Material Design 3 ColorScheme. It was introduced in Material Color Utilities (MCU) package v0.12.0.
    * This modifier is equivalent to setting the `SeedColorScheme.fromSeeds` and its `useExpressiveOnContainerColors` to true when using MCU dynamic scheme variant based seeded color schemes.
  

* **COLOR VALUE STYLE BREAKING**
  * Changed `FlexTones.chroma` tone `secondaryTone` from 60 to 50 in light mode for better chroma fidelity when using `FlexTone.chroma` in light mode.
  


* **CHANGE**
  * Revert Flutter constraint back to `>=3.22.0` from `>=3.22.0-0.3.pre` that was only used by FSS dev release `2.1.0-dev.1`. Since beta and master are now on `3.23.0` or higher versions, the `>=3.22.0` constraint can now be used by master and beta channels without any issue.
  * Improved the descriptions and config info strings of `FlexSchemeVariant` enum values. 
  * The EXAMPLE APP was extensively revised to include support for all the new features and to also show some old features not demonstrated before.


* **FIX**
  * The `FlexTones.material3Legacy` was corrected. It had some incorrect tones and chroma in its configuration. The mistakes were fixed. Tests were added to check the FlexTones.material3Legacy compared to the MCU deprecated Scheme-based colors, for colors that exist in both.
  * EXAMPLE APP: The key color to seed the error palette was not used in the main example in dark mode.
  

## 2.1.0-dev.1

**May 21, 2024**

This is a temp pre-release of FFS 2.1.0.

**FIX**
* [FIX #13](https://github.com/rydmike/flex_seed_scheme/issues/13). Sets Flutter version constraint to flutter: `>=3.22.0-0.3.pre`, so that the package can also be used on **beta** and **stable** channels, while they are still on 3.22.0-a.b.pre versions, which is considered smaller than **3.22.0**, used in the stable release of the package. You can use this version of the package if you need to use **beta** or **master** channel before they have been bumped to 3.23.x. This release is apart from the version constraint difference identical to the `2.0.0` release. 


## 2.0.0

**May 14, 2024**

This release adds support for the revised Material-3 `ColorScheme` released in Flutter version 3.22.0 and for seeded scheme variants, that will arrive in the Flutter stable release after 3.22.x.

* **CHANGE**
  * Bring the internal Material Color Utilities (MCU) library version to parity with its latest package release 0.11.1. Flutter SDK stable 3.22 still uses MCU 0.8.0, but the Flutter master channel already uses MCU 0.11.1.
  * The `FlexPaletteType.extended` tones got two new tones added, tone 2, and 24. It now has 27 tones.
  

* **NEW**
  * Support revised Material-3 `ColorScheme` with the new colors `primaryFixed`, `primaryFixedDim`, `onPrimaryFixed`, `onPrimaryFixedVariant`, `secondaryFixed`, `secondaryFixedDim`, `onSecondaryFixed`, `onSecondaryFixedVariant`, `tertiaryFixed`, `tertiaryFixedDim`, `onTertiaryFixed`, `onTertiaryFixedVariant`, `surfaceDim`, `surfaceBright`, `surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh` and `surfaceContainerHighest`.
   
  * New alternative way to specify the used seeding algorithm in `SeedColorScheme.fromSeeds` by providing new enum value `FlexSchemeVariant` to its `variant` property.  
    * In addition to supporting selection of built-in `FlexTones`, the `variant` property also supports using Flutter SDK, MCU based scheme variants `tonalSpot`, `monochrome`, `neutral`, `vibrant`, `expressive`, `content`,`rainbow` and `fruitSalad` in by specifying them in property `variant` in `SeedColorScheme.fromSeeds`. In Flutter 3.22 only the default `tonalSpot` is available, but with FSS you can use any of the other variants as well already in Flutter 3.22. The other variants are not yet available in Flutter 3.22, but they are available in the `ColorScheme` API in the master channel and will be available in Flutter `ColorScheme.fromSeed` in the next stable release after 3.22. With FSS you can use them already starting from Flutter 3.22.0.
    * With the `variants` enum property you can also select built-in `FlexTones` that you could use before in `SeedColorScheme.fromSeeds` in `tones`. The `FlexTones` are still available and can be used as before, it has some advantages. With `tones` you can create customized seed extractions based on `FlexTones` and you can use tones surface quick modifiers, `onMainsUseBW`, `onSurfacesUseBW` and `surfacesUseBW`.
    * When using `variants`, if the variant is one of the Flutter SDK/MCU variants, it will not use more than one key color, the primary as seed color. The `FlexSchemeVariant` that have their property `isFlutterScheme` set to true are part of the Flutter SDK/MCU variants.
    * The Flutter SDK/MCU variants are `tonalSpot`, `fidelity`, `monochrome`, `neutral`, `vibrant`, `expressive`, `content`, `rainbow` and `fruitSalad`.
    * The other `FlexSchemeVariant` that have their property `isFlutterScheme` set to false are part of the `FlexTones` variants using the corresponding built-in `FlexTones` as seed extraction. The variants are `material`, `material3Legacy`, `soft`, `vivid`, `vividSurfaces`, `highContrast`, `ultraContrast`, `jolly`, `vividBackground`, `oneHue`, `candyPop` and `chroma`. The `chroma` option is similar to the new nice SDK/MCU one called `fidelity`, in that it follows chroma of seed color, with the added benefit that it can use a separate seed color for each tonal palette.
    * The APIs `variant` and `tones` are mutually exclusive, you can only use one of them in `SeedColorScheme.fromSeeds`. Both can be unspecified, but if you specify one, the other must be unspecified/null. 
  
 * A new `FlexTones.material3Legacy` was added. This `FlexTones` configuration preserves and provides access to the seed generation used by Flutter prior to Flutter version 3.22 and as used by `FlexTones.material`in FlexSeedScheme before version 2.0.0. If you in Flutter 3.22 and FlexSeedScheme 2.0.0 need to replicate this style you can use this `FlexTones` in `SeedColorScheme.fromSeeds` property `tones` or the `FlexSchemeVariant.material3Legacy` in `variants`. 


* **BREAKING**
  * The Material-3 `ColorScheme` colors `background`, `onBackground` and `surfaceVariant` have been deprecated since they are also deprecated in Flutter 3.22.
    * These **deprecated** colors are **still supported** in `SeedColorScheme.fromSeeds` and `FlexTones`, but they will be removed in a future release. They are replaced by `surface`, `onSurface` and `surfaceContainerLowest`. There are also many new surface colors, like `surfaceDim`, `surfaceBright` and `surfaceContainerLowest` in the new Material-3 `ColorScheme` in Flutter 3.22.
    * The fact that these deprecated colors are still **referenced** in the package **will reduce** its **pub.dev** score with **10 points**, but they are kept for now to maintain **FULL** compatibility with **Flutter 3.22** that also still provides values for these deprecated colors and uses them in code. This package needs to provide the same values to be fully compatible. The `ColorScheme` colors `background`, `onBackground` and `surfaceVariant` may only be fully removed when they have been removed from the Flutter SDK stable channel. If later tests show they can be removed without breaking any styles earlier, they will be removed in a future release of this package, even if they are still available in the Flutter SDK stable channel. A future dev version may also remove them to provide compatibility with the Flutter master channel when they are removed there.
  

* **BREAKING STYLES**

  * All built-in `FlexTones` now use the `paletteType` extended via `FlexPaletteType.extended` as default for additional tone fidelity. This is used for compatibility with Flutter 3.22 and its revised `ColorScheme`.
  
  * The default tones for the built-in `FlexTones` have been adjusted to match the new Material-3 `ColorScheme` in Flutter 3.22. The new tones and default styles are marginally different but also better than in previous Flutter versions. If you need the result and style used in Flutter 3.19 and earlier, you can use the `FlexTones.material3Legacy` as `tones` in `SeedColorScheme.fromSeeds` to get the result `FlexTones.material` produced in FSS before version 2.0.0 and that was also the default in Flutter in version 3.19 and earlier.
  
   
  * The `FlexSchemeVariant.tonalSpot` is the `variant` that Flutter SDK uses from MCU in `ColorScheme.fromSeed` in **Flutter 3.22 and later** when you make seed generated color schemes with it. This generated scheme is different from the one `ColorScheme.fromSeed` generated in **Flutter 3.19 and earlier**. If you need the result and style used in Flutter 3.19 and earlier, you can use the `material3Legacy` as `tones` or `variant` in `SeedColorScheme.fromSeeds` to get the result `FlexTones.material` produced in FSS before version 2.0.0 and that was also the default in Flutter in version 3.19 and earlier when using `ColorScheme.fromSeed`. 

  * The `FlexTones.material` has been updated and now produces the same result as `tonalSpot` in tests. There may be some edge cases where there are rounding differences. The `material` alternative can be used both in `variant` and `tones`. It provides the advantages over `tonalSpot` that since it is a `FlexTones`, it can use multiple seed colors and if used in `tones`, its results can be quick adjusted with `onMainsUseBW`, `onSurfacesUseBW` and `surfacesUseBW`. The `tonalSpot` is a Flutter SDK/MCU variant and does not support these customizations.  

## 1.5.0

**April 3, 2024**

* **NEW**
  * Exposed `Hct` and `ViewingConditions` from the underlying Material Color Utilities (MCU) library. They are exposed for convenience, you no longer have to add and import (MCU) to use them. 
  * Add `CODE_OF_CONDUCT.md` and `CONTRIBUTING.md` files for guidance on contributing to the package.

## 1.4.0

**July 2, 2023**

* **NEW** 
  * Added support for new HCT tones used by updated Material3 color system, that were added during the first half of 2023 to the Material 3 color system specification. The added tones 4, 6, 12, 17, 22 are for new dark mode surfaces in revised Material 3 dark surface colors. Likewise, added tones 97, 96, 94, 92, 87 are for light mode surfaces in the updated Material 3 color system. For more information, see: https://m3.material.io/styles/color/the-color-system/color-roles.
    * The change and additions are none breaking. APIs that want and can use the extended tones can pass in an optional `paletteType` of `FlexPaletteType` and set it to `FlexPaletteType.extended`, by default its values `FlexPaletteType.common` resulting in the 15 tones `[0, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 98, 99, 100]` being produced as before.
    * The complete list of the 25 extended tones are `[0, 4, 5, 6, 10, 12, 17, 20, 22, 30, 40, 50, 60, 70, 80, 87, 90, 92, 94, 95, 96, 97, 98, 99, 100]`.
    * None breaking Changed APIs that now support using `paletteType` of `FlexPaletteType`are: 
      * `FlexTonalPalette.of`
      * `FlexTonalPalette.fromList`
      * `FlexCorePalette.of`
      * `FlexCorePalette.fromHueChroma`
      * `FlexCorePalette.fromList`
      * `FlexCorePalette.fromSeeds`
      * `FlexTones`
    * Flutter 3.10 and earlier do not yet use these new tones in its standard `ColorScheme`, but since they are in the Material 3 spec, they will arrive at some later point.
    * `FlexTonalPalette`, like MCU `TonalPalette`, caps chroma for tones higher than or equal to 90, to maximum chroma value of 40. In `FlexTonalPalette` this still applies when using `FlexPaletteType.common`, when you use the `FlexPaletteType.extended`, there is no chroma max cap on high tones, it uses fidelity mode for high tones. When using type `FlexPaletteType.common` the chroma of high tones (>= 90), is limited to maximum 40. This keeps the chromacity of tones 90 to 100, lower than 40. If the source uses has more chromacity than 40, there may be a sudden jump in chroma reduction at tone 90. This is the standard behavior for the original Material-3 tonal palette computation. The `FlexPaletteType.common` type is intended to be used when there is a need to follow strict M3's original palette design.
    * When using the `FlexPaletteType.extended` type tones, there are not only the new tones, but the chroma limit of tones >= 90 is also removed. This increases fidelity of higher tone when high chromacity is used.
  * Added two new pre-configured `FlexTones`s, `candyPop` and `chroma`, they use the new `FlexPaletteType.extended` tonal palette.
  * Added new `FlexTones` modifier `surfacesUseBW()`. It can be used as a modifier to force any `FlexTones` seed strategy to use tone 100 (white) or tone 0 (black) as `background` and `surface` colors, depending on if they are dark or light


* **CHANGE**
  * **Minor style breaking**: To correct and improve produced themes, the tones `primaryContainerTone` and `secondaryContainerTone` for light mode `FlexTones.highContrast` and `FlexTones.ultraContrast` were both changed from 95 to 90. This produces brighter and more punchy themes for these two high-contrast themes in light mode.


* **CHORE**
  * Bump Dart SDK to >= 3.0.0 and Flutter SDK to >= 3.10.0. Fix lints for the bump. 
  * Add all Material Color Utilities (MCU) updates from its Dart version to the internal bundled version. 
    * This includes all PRs up to and including "PR: 28.6.2023 Change var back to double in Java." This equals Dart version 0.8.0 published on June 29, 2023, with its two new schemes fruit salad and rainbow. 
    * At this time, Flutter master was using MCU version 0.5.0 and Flutter stable 3.10.0 still used the MCU version 0.2.0. 
    * Since MCU is using zero semver and Flutter SDK, depends on it, any minor version number change is breaking and cannot be resolved across Flutter channels if a package also uses MCU. This is the reason why (FSS) for now does not use MCU directly. It bundles its own version of it for now. This also means FSS may sometimes use a newer version of MCU than Flutter stable, beta, and master. FSS may stop bundling MCU when it stops getting so many frequent breaking updates that cause dependency hell for a package that needs to depend on MCU and work on all Flutter channels.


* **EXAMPLE**
  * Major refactoring of the example app.
  * Use a theme controller and ListenableBuilder to rebuild the app theme when the theme controller changes.
  * Feature: Add showing generated tonal palettes to the example.
  * Feature: Separate controls for making on Main and on Surface colors black and white.
  * Feature: Change seed colors in the app with Color picker.
  * Feature: Add switching between showing common tones and extended tones.
  * Feature: Add selecting a custom color as key color for error palette.


## 1.3.0

**May 11, 2023**

**INTERNAL CHANGE**
 
- Removed the **Material Color Utilities** (MCU) dependency. 
  - It is now included and maintained as a separate forked code base in **FSS**, while keeping **MCU**'s original license in place for its parts. The included **MCU** library was only modified to abide by the much stricter lint rules used in **FSS**. More unit tests for better test coverage of **MCU** were added as well. 
  - Why is **MCU** included as a forked version baked into **FSS**? 
    
    The constant changes in **MCU**, with e.g., recent three different breaking-pinned zero-ver versions used in **Flutter** **stable**, **beta** and **master** channels, made it hopeless to depend on **MCU**. Using it caused repeated version conflicts with Flutter's own pinned dependency on different breaking versions of it, in different **Flutter** channels. **FSS** needs to be able to work across all Flutter channels without constant hassle caused by **MCU** and which exact version of it different version of **Flutter** repo itself is pinned to. 
  - The included forked version will be kept in sync with the original and updated when needed. Currently included **MCU** version is 0.5.0, the latest one, which is what **Flutter master** channel currently uses. However, new **Flutter stable** 3.10 is still using **MCU** 0.2.0. If the **MCU** package stabilizes and improves its constant breaking changes, **FSS** may later again be changed to depend on the original package. Until then, it embeds the code for it in its package to avoid the version conflict hassles it has repeatedly caused. These changes are all internal to the **FSS** package and do not affect how it works.

**NEW**

- Exposed `Blend`, `CorePalette` and `TonalPalette` from **MCU**. Previously only `Cam16` was exposed. These APIs from **MCU** are exposed because [FlexColorScheme (FCS)](https://pub.dev/packages/flex_color_scheme) uses them. By exposing these APIs from the included **MCU** in **FSS**, it also no longer has any dependency on the **MCU** package that Flutter depends on. This makes it easier for the latest release of **FCS** to also work on all current Flutter channels.


Future versions of **FSS** may expose a few more APIs from **MCU**, but more likely it will offer a few new alternative ones with its own twist. Like it is for example, doing with `SeedColorScheme.fromSeeds`.

## 1.2.4

**Apr 16, 2023**

- Bumped Flutter sdk version constraint to `>=2.19.0 <4.0.0` (from `>=2.18.0 <3.0.0`)
- Changed `material_color_utilities` version constraint to `>=0.2.0 <0.4.0` from `^0.2.0`.

These changes enable the package to be used on current Flutter **stable** 3.7 versions, as well as the latest 3.10.x versions on channels **beta** and **master**. It will also work with the next stable Flutter release after 3.7. 

## 1.2.3

**Mar 19, 2023**

- FIX: Version 1.2.0 unintentionally introduced a lower level breaking API from version 1.1.0. This release relaxes the API and fixes the breakage.

## 1.2.2

**Jan 30, 2023**

- Add example screenshots to pubspec.yaml.

## 1.2.1

**Jan 25, 2023**

- Fix date on 1.2.0 changelog.
 
## 1.2.0

**Jan 25, 2023**

Requires minimum Flutter 3.7.0. Now support `outlineVariant` and `scrim` colors in `ColorScheme` in Flutter stable 3.7.0 and later.

This release also adds new features to allow customization of seed generation of error, neutral and neutral variant tonal palettes. All listed features are unchanged from the previous dev pre-release 1.2.0-dev.1.

**NEW**

* Adds support for `outlineVariant` and `scrim` colors in `ColorScheme`.
* Added support for customizing seed generation for error, neutral and neutral variant tonal palettes.


* To support the new features the `SeedColorScheme.fromSeeds` got the following new `Color` properties `errorKey`, `neutralKey` and `neutralVariantKey`.
* The `FlexTones` class got the following new `double` properties
  `errorChroma`, `errorMinChroma`, `neutralMinChroma` and `neutralVariantMinChroma`
* The `FlexCorePalette.fromSeeds` factory got the following new `int` properties `error`, `neutral`, `neutralVariant` and `neutralVariantMinChroma`. As well as new `double` properties `errorChroma`, `errorMinChroma`, `neutralChroma`, `neutralMinChroma`, `neutralVariantChroma` and `neutralVariantMinChroma`.

* The demo application got an **About** dialog. The demo app also shows the `ColorScheme` applied on common **Material** components.

## 1.2.0-dev.1

**Dec 23, 2022**

Requires minimum Flutter 3.7.0-1.2.pre (beta channel). This is a development pre-release to support `outlineVariant` and `scrim` colors in `ColorScheme`. It is used for development and testing against new Material 3 features in Flutter 3.7 beta and master channel. It will be released as a stable version when the new color properties land in the Flutter stable channel, most likely after January 25, 2023.

The release also adds new features to allow customization of seed generation of error, neutral and neutral variant tonal palettes.

**NEW**

* Adds support for `outlineVariant` and `scrim` colors in `ColorScheme`.
* Added support for customizing seed generation for error, neutral and neutral variant tonal palettes. 


* To support the new features the `SeedColorScheme.fromSeeds` got the following new `Color` properties `errorKey`, `neutralKey` and `neutralVariantKey`.
* The `FlexTones` class got the following new `double` properties
  `errorChroma`, `errorMinChroma`, `neutralMinChroma` and `neutralVariantMinChroma`
* The `FlexCorePalette.fromSeeds` factory got the following new `int` properties `error`, `neutral`, `neutralVariant` and `neutralVariantMinChroma`. As well as new `double` properties `errorChroma`, `errorMinChroma`, `neutralChroma`, `neutralMinChroma`, `neutralVariantChroma` and `neutralVariantMinChroma`.


* The demo application got an **About** dialog. The demo app also shows the `ColorScheme` applied on common **Material** components.

## 1.1.0

**Nov 17, 2022**

**NEW**

* Added new `FlexTones` method `onMainsUseBW`, that can return a new instance of its configurations with tone mapping for its main **on* colors set to tone, 0 (black) or 100 (white), depending on what is appropriate for its main color tones. The main colors are primary, secondary, tertiary, error and their containers. The method works on any configured `FlexTones`, also custom ones, not only the built-in ones.

* Added new `FlexTones` method `onSurfacesUseBW`, that can return a new instance of its configurations with tone mapping for its surface **on* colors set to tone, 0 (black) or 100 (white), depending on what is appropriate for its surface color tones. Surface colors are background, surface, surfaceVariant and inverseSurface. The method works on any configured `FlexTones`, also custom ones, not only the built-in ones.

* To be able to support creating mono-hue seeded color schemes, the `FlexCorePalette.fromSeeds` got a new property
  `tertiaryHueRotation`. It controls the used hue rotation degrees from primary key color, that is used when a tertiary seed key color is not provided. The `tertiaryHueRotation` defaults 60 degrees, same as previously from Material 3 color system hard-coded value.

* Added two new `FlexTones`. 
  - `FlexTones.oneHue` that set `tertiaryHueRotation` to 0, so we can create a mono hue palette if we only provide primary key color as seed.
  - `FlexTones.vividBackground` that is a copy of `FlexTones.vividSurfaces` but with tone mapping for `background` and `surface` swapped.

**CHANGE**

Tone mappings for some pre-configured `FlexTones` were slightly modified. They now produce improved and more usable color schemes. Most significantly, the mappings for `FlexTones.vividSurfaces` were modified to provide a more usable and improved vivid surfaces tinted color scheme, while still offering a slightly more tinted surface design than `FlexTones.vivid`. Tone mapping changes are as follows:

* The `FlexTones.vivid`, brightness **light**:
  - Tone `surfaceTone` was changed from 99 to 98.
* The `FlexTones.vivid`, brightness **dark**:
  - Tone `onErrorContainerTone` was changed from 90 to 80 (dark M3 default).
  - Tone `backgroundTone` was changed from 10 to 5.
* The `FlexTones.vividSurfaces` brightness **light**:
  - Tone `onPrimaryTone` was changed from 95 to 98.
  - Tone `onSecondaryTone` was changed from 95 to 98.
  - Tone `onTertiaryTone` was changed from 95 to 98.
  - Tone `onErrorTone` was changed from 95 to 98.
  - Tone `primaryContainerTone` was changed from 80 to 90 (light M3 default).
  - Tone `secondaryContainerTone` was changed from 80 to 90 (light M3 default).
  - Tone `tertiaryContainerTone` was changed from 80 to 90 (light M3 default).
  - Tone `errorContainerTone` was changed from 80 to 90 (light M3 default).
  - Tone `surfaceVariantTone` was changed from 80 to 90 (light M3 default).
  - Tone `backgroundTone` was changed from 90 to 98.
  - `neutralChroma` was changed from 8 to 5.
  - `neutralVariantChroma` was changed from 16 to 10.
* The `FlexTones.vividSurfaces` brightness **dark**:
  - Tone `primaryContainerTone` was changed from 40 to 20.
  - Tone `tertiaryContainerTone` was changed from 40 to 30 (dark M3 default).
  - Tone `primaryContainerTone` was changed from 40 to 30 (dark M3 default).
  - Tone `onErrorTone` was changed from 20 to 30 (dark M3 default).
  - Tone `onErrorContainerTone` was changed from 90 to 80 (dark M3 default).
  - Tone `surfaceTone` was changed from 10 to 20.
  - Tone `surfaceVariantTone` was changed from 40 to 30 (dark M3 default).
  - Tone `backgroundTone` was changed from 20 to 10.
  - Tone `onSurfaceVariantTone` was changed from 90 to 95.
  - Tone `onInverseSurfaceTone` was changed from 30 to 20 (dark M3 default).
  - `neutralChroma` was changed from 8 to 5.
  - `neutralVariantChroma` was changed from 16 to 10.
* The `FlexTones.ultraContrast` brightness **light**: 
  - Tone `primaryTone` was changed from 30 to 20.
* The `FlexTones.ultraContrast` brightness **dark**:
  - Tone `surfaceTone` was changed from 10 to 5.
  - Tone `backgroundTone` was changed from 10 to 5.

## 1.0.1

**Sep 2, 2022**

**DOCS**

* Readme: Removed old notice about package being a beta release and using Flutter 3.3 beta.
* Readme: Described custom FlexTones config with an example.
* API doc improvements.

**EXAMPLE**

* Allow selection of example custom tones example and all built-in `FlexTones` options.
* Publish example app as a live web demo.

## 1.0.0

**Aug 30, 2022**

First stable release.

* Document updates.
* Updated minimum dependencies to Dart >=2.18.0 and Flutter >= 3.3.0. 

## 0.2.0-dev.2

**Aug 28, 2022**

**NEW**

* From Material Color utilities export and show `Cam16`.

## 0.2.0-dev.1

**Aug 27, 2022**

**NEW**

* Add customization possibility of `error` tonal palette to the default `FlexTonalPalette`
  constructor.

**BREAKING** 
 
* The `FlexTonalPalette` method `asList` and constructor `fromList`, now include the values of the error color in produced `asList`, and as required values in `fromList`.

## 0.1.0-dev.3

**Aug 27, 2022**

* Fix pub points.

## 0.1.0-dev.2

**Aug 27, 2022**

* Relax version constraint to make it work on beta 3.3.0-0.3.pre and later.
* Remove in Flutter beta 3.3.0 unsupported `ColorScheme` colors `scrim` and `outlineVariant`.

## 0.1.0-dev.1

**Aug 26, 2022**

* First dev release of the package.