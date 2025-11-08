# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FlexSeedScheme (FSS) is a Flutter package that provides a more flexible and powerful alternative to Flutter's `ColorScheme.fromSeed`. It enables using multiple seed colors (up to 6), custom chroma settings, and configurable tone mapping for Material Design 3 color schemes.

**Key Value Proposition:**
- Use separate seed keys for primary, secondary, tertiary, error, neutral, and neutralVariant palettes
- Customize chromacity (colorfulness) in the HCT (Hue-Chroma-Tone) color space
- Customize tonal palette tone mappings to ColorScheme colors
- Support for both FlexTones-based and DynamicSchemeVariant-based color generation
- Built-in high contrast and accessibility variants

## Build, Test, and Lint Commands

### Testing
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run a single test file
flutter test test/flex_seed_scheme_test.dart
```

### Analysis and Formatting
```bash
# Analyze code
dart analyze

# Format code (required before commits)
dart format .

# Check if code is properly formatted (fails if not)
dart format --output=none --set-exit-if-changed .
```

### Package Management
```bash
# Get dependencies
flutter pub get

# Check for outdated dependencies
flutter pub outdated
```

### Version Management
The project uses FVM (Flutter Version Manager):
```bash
# FVM is configured via .fvmrc
# Use the configured Flutter version
fvm flutter <command>
```

## Architecture

### Core Components

The codebase is organized into two main source directories:

#### 1. `/lib/src/flex/` - FlexSeedScheme Core API
This is the primary public API layer:

- **`flex_seed_scheme.dart`**: Contains `SeedColorScheme.fromSeeds()` - the main entry point for creating color schemes. It's an extension on `ColorScheme` that orchestrates the entire seed generation process.

- **`flex_tones.dart`**: Defines `FlexTones` - the configuration class that maps tonal palette tones to ColorScheme colors. Contains 11+ predefined tone strategies (material, vivid, soft, candyPop, oneHue, etc.) and supports custom configurations via `.light()` and `.dark()` factories. Includes modifiers like `onMainsUseBW()`, `onSurfacesUseBW()`, `monochromeSurfaces()`, `higherContrastFixed()`, and `expressiveOnContainer()`.

- **`flex_core_palette.dart`**: Enhanced version of MCU's `CorePalette` that generates the six tonal palettes (primary, secondary, tertiary, error, neutral, neutralVariant) from multiple seed colors instead of just one.

- **`flex_tonal_palette.dart`**: Extended tonal palette that supports both `common` (15 tones) and `extended` (30 tones) palette types. Extended type is required for Flutter 3.22+ compatibility.

- **`flex_scheme_variant.dart`**: Enum defining all available scheme variant algorithms, including both Flutter SDK's DynamicSchemeVariant-based variants (tonalSpot, fidelity, content, etc.) and FlexTones-based variants.

- **`flex_color_seed_color_extensions.dart`**: Non-deprecated 8-bit color channel getters for Color (value32bit, alpha8bit, red8bit, green8bit, blue8bit).

#### 2. `/lib/src/mcu/` - Material Color Utilities Fork
Internal fork of Google's Material Color Utilities with custom enhancements:

- **`hct/`**: HCT (Hue-Chroma-Tone) color space implementation including CAM16 color appearance model
- **`palettes/`**: Core palette and tonal palette generation (base MCU functionality)
- **`scheme/`**: DynamicScheme implementations for each variant (tonalSpot, vibrant, expressive, fidelity, content, monochrome, neutral, fruitSalad, rainbow)
- **`dynamiccolor/`**: Dynamic color system with contrast curves and material dynamic colors
- **`quantize/`**: Color quantization algorithms (Celebi, Wu, WSMeans, Map)
- **`blend/`**: Color blending utilities
- **`contrast/`**: Contrast calculation utilities
- **`utils/`**: Math and color utility functions
- **`temperature/`**: Color temperature cache
- **`dislike/`**: Dislike analyzer for color preferences
- **`score/`**: Color scoring algorithms

**Key Custom Enhancement**: The MCU fork enables using multiple seed colors with DynamicSchemeVariant-based schemes, which the official MCU/Flutter SDK doesn't support. This is a core differentiator of FlexSeedScheme.

### Key Architectural Patterns

**Seed-to-Scheme Flow:**
1. User provides 1-6 seed colors to `SeedColorScheme.fromSeeds()`
2. Either `FlexTones` or `FlexSchemeVariant` (with optional `contrastLevel`) is specified
3. `FlexCorePalette` generates six tonal palettes from the seed colors
4. Each palette contains 15 (common) or 30 (extended) tones
5. Tones are mapped to the 40+ ColorScheme colors based on the selected strategy
6. Returns a complete Material 3 `ColorScheme`

**Two Generation Paths:**
- **FlexTones Path**: Uses custom FSS tone mapping configurations (more flexible, custom chroma control)
- **DynamicScheme Path**: Uses Flutter SDK's MCU-based schemes (fidelity, content, etc.) but enhanced to support multiple seed colors

**Palette Type System:**
- `FlexPaletteType.common`: 15 tones (legacy, pre-Flutter 3.22)
- `FlexPaletteType.extended`: 30 tones (required for Flutter 3.22+, includes new surface tones and fixed colors)

## Important Development Notes

### Strict Analysis
This project uses very strict linting rules (see `analysis_options.yaml`):
- Includes ALL lint rules from `all_lint_rules.yaml`
- Enables strict-casts, strict-inference, strict-raw-types
- Must pass `dart analyze` with zero warnings/errors
- Must be formatted with `dart format` (enforced in CI/CD)

### Test Coverage
- Comprehensive test coverage is required
- Tests are located in `/test/` with parallel structure to `/lib/src/`
- MCU tests in `/test/mcu/` validate the forked Material Color Utilities
- FSS tests validate the core FlexSeedScheme functionality
- CI enforces that tests pass and uploads coverage to Codecov

### Version Compatibility
- Requires Flutter SDK >=3.35.0
- Requires Dart SDK >=3.0.0 <4.0.0
- Uses Flutter 3.22+ extended ColorScheme features by default
- Backward compatible with older Flutter via `FlexPaletteType.common`

### Key Implementation Details

**Monochrome Seed Handling:**
When `respectMonochromeSeed: true`, monochrome RGB input (R=G=B) creates greyscale tonal palettes instead of the legacy behavior that produced cyan/red tones.

**Expressive On-Container Colors:**
When `useExpressiveOnContainerColors: true` in light mode, on-container tones change from 10 to 30 for more expressive (but lower contrast) colors. This aligns with newer Material 3 specs.

**Brand Color Pinning:**
Common pattern: Use brand color as both seed key and override the result (e.g., `primaryKey: brandColor, primary: brandColor`) to guarantee the brand color appears in the scheme. Works well for light mode; in dark mode, prefer pinning to `primaryContainer`.

**FlexTones Modifiers:**
Modifiers can be chained on FlexTones configurations. Order matters when modifiers affect the same colors - last one wins:
```dart
FlexTones.vivid(Brightness.light)
  .monochromeSurfaces()
  .onMainsUseBW()
  .onSurfacesUseBW()
```

### File Organization
- Main library export: `/lib/flex_seed_scheme.dart`
- Implementation: `/lib/src/flex/` and `/lib/src/mcu/`
- Tests mirror source structure: `/test/flex_*_test.dart` and `/test/mcu/`
- Example app: `/example/` (has web demo at rydmike.com/flexseedscheme/demo-v3)

### Dependencies
- `collection: ^1.18.0` - Used by MCU tonal_palette.dart
- `meta: ^1.9.1` - For @internal annotations
- Flutter SDK's material package

### Relationship to FlexColorScheme
FlexSeedScheme was extracted from FlexColorScheme v6+. FlexColorScheme depends on this package and re-exports its API. This package can be used standalone without FlexColorScheme.
