---
name: flex-seed-scheme
description: Use FlexSeedScheme to generate Material 3 ColorSchemes from one to six seed colors. Use when replacing ColorScheme.fromSeed, writing ThemeData, FlexTones, FlexSchemeVariant, brand pinning, contrastLevel, or respectMonochromeSeed.
---

# Using FlexSeedScheme

Copy this skill into a consuming app’s `.agents/skills/` or `.cursor/skills/`. It does not depend on this repository’s `AGENTS.md`.

Galleries and longer prose: [pub.dev/packages/flex_seed_scheme](https://pub.dev/packages/flex_seed_scheme).

If the app already uses **FlexColorScheme ≥ 6**, FlexSeedScheme is already a dependency and its API is re-exported. Add a direct `flex_seed_scheme` dependency only when calling these APIs without FCS.

## Entry point

```dart
import 'package:flex_seed_scheme/flex_seed_scheme.dart';

final ColorScheme scheme = SeedColorScheme.fromSeeds(
  brightness: Brightness.light, // or Brightness.dark
  primaryKey: brandColor, // required
  secondaryKey: secondaryBrand, // optional
  tertiaryKey: tertiaryBrand, // optional
  // errorKey, neutralKey, neutralVariantKey optional
);
```

Pass the result to `ThemeData(colorScheme: scheme)` like any other `ColorScheme`. Use the same seed keys for light and dark so palettes match; only the tone mapping changes with brightness.

Do not construct `FlexSeedScheme`. It is internal.

## Seeds are not role colors

A seed key sets **hue and chroma** of a tonal palette. It does **not** become `ColorScheme.primary` (or secondary, …) unless you also pass that color as an override.

**Light:** pin brand to `primary` / `secondary` / `tertiary` (and `error` if used).

```dart
SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: brand,
  primary: brand,
);
```

**Dark:** the same brand is usually too dark and chromatic for `primary`. Pin to `primaryContainer` (and the other `*Container` roles).

If a pinned light color needs dark text, also override `onPrimary` / `onSecondary` / `onTertiary`.

## Choose a path: `tones` or `variant`

They are mutually exclusive. Do not pass both (debug asserts; release prefers `variant`). If both are omitted, you get `FlexTones.material`.

| Need                                                | Use                                                                                        |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Flutter `DynamicSchemeVariant` plus `contrastLevel` | `variant: FlexSchemeVariant.tonalSpot` (or `fidelity`, …) where `isFlutterScheme` is true  |
| Custom chroma, tone map, or BW/mono modifiers       | `tones: FlexTones.vivid(brightness)` or a custom `FlexTones`                               |
| MCU-style algorithm **and** extra seed keys         | `variant` still accepts all seed keys (FSS fork). Modifiers still require the `tones` path |

`contrastLevel` is −1.0…1.0 (Material medium/high ≈ 0.5 / 1.0). It is **ignored** unless `variant.isFlutterScheme` is true.

## Flags

- `useExpressiveOnContainerColors` — default **true** since 4.0.0. In **light** mode, on-container tones 10 become 30 (more color, less contrast). Set `false` for the older, higher-contrast on-containers. Dark mode unchanged. Meaningful on the MCU path mainly at `contrastLevel == 0`.
- `respectMonochromeSeed` — default **false** (MCU: grey seeds can yield cyan/red-ish palettes). Set **true** so equal R=G=B seeds stay greyscale. Prefer this for grey brands. Avoid `fidelity` / `content` with some greys if containers look washed out.

## `FlexSchemeVariant`

**MCU / Flutter** (`isFlutterScheme: true`): `tonalSpot`, `fidelity`, `monochrome`, `neutral`, `vibrant`, `expressive`, `content`, `rainbow`, `fruitSalad`.

**FlexTones presets** (`isFlutterScheme: false`): `material`, `material3Legacy`, `soft`, `vivid`, `vividSurfaces`, `highContrast`, `ultraContrast`, `jolly`, `vividBackground`, `oneHue`, `candyPop`, `chroma`.

`variant.tones(brightness)` returns the matching `FlexTones` for FlexTones presets, or `FlexTones.material` for Flutter schemes. Chain modifiers on that result when you stay on the `tones` path.

`tonalSpot` is the Flutter SDK default. `material` is the FlexTones equivalent of post-3.22 Material. For exact `ColorScheme.fromSeed` parity with a single seed, omit `tones`/`variant` or use `tonalSpot`. `oneHue` does not rotate tertiary hue when `tertiaryKey` is omitted.

## `FlexTones`

Named factories take `Brightness`: `material`, `material3Legacy`, `soft`, `vivid`, `vividSurfaces`, `vividBackground`, `highContrast`, `ultraContrast`, `jolly`, `oneHue`, `candyPop`, `chroma`. Custom configs: `FlexTones.light` / `FlexTones.dark` and override only what you need. Prefer `paletteType: FlexPaletteType.extended` (default on built-in tones). `FlexPaletteType.common` is legacy.

### Modifiers

Call on a `FlexTones` instance. Order matters; last write wins on the same roles.

- `onMainsUseBW()` — main on-colors → black or white
- `onSurfacesUseBW()` — `onSurface`, `onSurfaceVariant`, `onInverseSurface` → BW
- `surfacesUseBW()` — white surfaces in light / black in dark
- `monochromeSurfaces()` — untinted greyscale neutrals
- `higherContrastFixed()` — stronger fixed/fixedDim tones
- `expressiveOnContainer()` — light on-container 10→30

Example (example app pattern):

```dart
tones: FlexSchemeVariant.vivid.tones(Brightness.light)
    .monochromeSurfaces()
    .onMainsUseBW()
    .onSurfacesUseBW(),
```

`fromSeeds` `useExpressiveOnContainerColors` runs before these modifiers.

## Anti-patterns

- Treating `primaryKey` as `ColorScheme.primary` without a pin override
- Passing both `tones` and `variant`
- Expecting `contrastLevel` or FlexTones modifiers to apply on the other path
- Constructing `FlexSeedScheme`
- Passing deprecated `background` / `onBackground` / `surfaceVariant` overrides (removed)
- Using `FlexPaletteType.common` unless you must match pre-3.22 palettes
- Adding a second `flex_seed_scheme` constraint in an app that already depends on FlexColorScheme ≥ 6, unless you call FSS APIs directly and need a floor
