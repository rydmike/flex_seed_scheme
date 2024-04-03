# Changelog

All notable changes to the **FlexSeedScheme** (FSS) package are documented here.

## 2.0.0-dev.1

**April 3, 2024**

This release adds support for the revised Material-3 ColorScheme and new features in Material Color Utilities (MCU) library version 0.11.1.

* **NEW**
  * Support revised Material-3 ColorScheme with colors like...


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
    
    The constant changes in **MCU**, with e.g. recent 3 different breaking-pinned zero-ver versions used in **Flutter** **stable**, **beta** and **master** channels, made it hopeless to depend on **MCU**. Using it caused repeated version conflicts with Flutter's own pinned dependency on different breaking versions of it, in different **Flutter** channels. **FSS** needs to be able to work across all Flutter channels without constant hassle caused by **MCU** and which exact version of it different version of **Flutter** repo itself is pinned to. 
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