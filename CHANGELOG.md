# Changelog

All notable changes to the **FlexSeedScheme** (FSS) package are documented here.

## 1.0.0

**Aug 30, 2022**

First stable release.

* Document updates
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
 
* The `FlexTonalPalette` method `asList` and constructor `fromList`, now include the values of  
  the error color in produced `asList`, and as required values in `fromList`.

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