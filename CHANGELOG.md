# Changelog

All notable changes to the **FlexSeedScheme** (FSS) package are documented here.

## 1.2.0-dev.1

**Dec 21, 2022**

Requires minimum Flutter 3.7.0-1.2.pre (beta channel). This is a development pre-release to support `outlineVariant` and `scrim` colors in `ColorScheme`. It is used for development and testing against new Material 3 features in Flutter 3.7 beta and master channel. It will be released as a stable version when the new color properties land in the Flutter stable channel, most likely after January 25, 2023.

The release also adds new features to allow customization of seed generation of error, neutral and neutral variant tonal palettes.

**NEW**

* Adds support for `outlineVariant` and `scrim` colors in `ColorScheme`.
* Added support for customizing seed generation for error, neutral and neutral variant tonal palettes. 


* To support the new features the `SeedColorScheme.fromSeeds` got the following new `Color` properties `errorKey`, `neutralKey` and `neutralVariantKey`.
* The `FlexTones` class got the following new `double` properties
  `errorChroma`, `errorMinChroma`, `neutralMinChroma` and `neutralVariantMinChroma`
* The `FlexCorePalette.fromSeeds` factory got the following new `int` properties `error`, `neutral`, `neutralVariant` and `neutralVariantMinChroma`. As well as new `double` properties `errorChroma`, `errorMinChroma`, `neutralChroma`, `neutralMinChroma`, `neutralVariantChroma` and `neutralVariantMinChroma`.


* The demo application got and **About** dialog, and it shows the `ColorScheme` applied on common **Material** components.

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

Tone mappings for some pre-configured `FlexTones` were slightly modified. They now produce improved and more usable color schemes. Most significantly, the mappings for `FlexTones.vividSurfaces` were modified to provide a more usable and improved vivid surfaces tinted color schemes, while still offering a slightly more tinted surface design than `FlexTones.vivid`. Tone mapping changes are as follows:

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