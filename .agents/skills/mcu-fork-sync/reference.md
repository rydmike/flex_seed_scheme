# MCU fork reference

Dart-only map of upstream MCU `dart/` onto this fork. Load from [SKILL.md](SKILL.md).

## Sources

- GitHub: [material-foundation/material-color-utilities](https://github.com/material-foundation/material-color-utilities) — Dart tree is `dart/lib/` and `dart/test/`
- Pub: [material_color_utilities](https://pub.dev/packages/material_color_utilities)
- Dart changelog: [dart/CHANGELOG.md](https://github.com/material-foundation/material-color-utilities/blob/main/dart/CHANGELOG.md)
- Scheme migration doc (upstream): [dev_guide/creating_color_scheme.md](https://github.com/material-foundation/material-color-utilities/blob/main/dev_guide/creating_color_scheme.md)

This fork does **not** use the pub package. Flutter pins MCU independently; FSS may be newer.

## Path map (`dart/lib` → `lib/src/mcu`)

Folder names match. Example: `dart/lib/hct/cam16.dart` → `lib/src/mcu/hct/cam16.dart`.

| Upstream folder                          | Fork folder                                 |
| ---------------------------------------- | ------------------------------------------- |
| `dart/lib/blend/`                        | `lib/src/mcu/blend/`                        |
| `dart/lib/contrast/`                     | `lib/src/mcu/contrast/`                     |
| `dart/lib/dislike/`                      | `lib/src/mcu/dislike/`                      |
| `dart/lib/dynamiccolor/`                 | `lib/src/mcu/dynamiccolor/`                 |
| `dart/lib/hct/`                          | `lib/src/mcu/hct/`                          |
| `dart/lib/palettes/`                     | `lib/src/mcu/palettes/`                     |
| `dart/lib/quantize/`                     | `lib/src/mcu/quantize/`                     |
| `dart/lib/scheme/`                       | `lib/src/mcu/scheme/`                       |
| `dart/lib/score/`                        | `lib/src/mcu/score/`                        |
| `dart/lib/temperature/`                  | `lib/src/mcu/temperature/`                  |
| `dart/lib/utils/`                        | `lib/src/mcu/utils/`                        |
| `dart/lib/material_color_utilities.dart` | `lib/src/mcu/material_color_utilities.dart` |

Nested `src/` files follow the same rule (`hct/src/hct_solver.dart`, `dynamiccolor/src/contrast_curve.dart`, `quantize/src/point_provider_lab.dart`).

Public MCU types this package re-exports from [`lib/flex_seed_scheme.dart`](../../../lib/flex_seed_scheme.dart): `Blend`, `Cam16`, `CorePalette`, `DynamicColor`, `DynamicScheme`, `Hct`, `MaterialDynamicColors`, `Scheme`, `TonalPalette`, `ViewingConditions`. Do not expand that list without demand and a stability review.

## Test map (`dart/test` → `test/mcu`)

Google tests live as `test/mcu/<name>_test.dart` (for example `hct_test.dart`, `scheme_tonal_spot_test.dart`).

Fork extras — keep them:

- [`test/mcu/scheme_correctness_test.dart`](../../../test/mcu/scheme_correctness_test.dart)
- [`test/mcu/hct_round_trip_test.dart`](../../../test/mcu/hct_round_trip_test.dart)
- [`test/mcu/utils/color_matcher.dart`](../../../test/mcu/utils/color_matcher.dart) — `isColor` (exact ARGB), `isCloseToColor` (Cam16 distance ≤ 5)
- [`test/mcu/utils/scheme_from_variant.dart`](../../../test/mcu/utils/scheme_from_variant.dart)

FSS `test/flex_*_test.dart` is not upstream. If MCU color math changes, the `ColorScheme.fromSeed` parity loop and golden `toString` blobs may need **intentional** updates.

## FSS deltas (do not strip)

When upstream rewrites a file, re-apply these.

### Multi-seed `DynamicScheme` constructors

`SchemeTonalSpot`, `SchemeContent`, `SchemeFidelity`, `SchemeExpressive`, `SchemeFruitSalad`, `SchemeMonochrome`, `SchemeNeutral`, `SchemeRainbow`, `SchemeVibrant` accept optional `Hct` sources:

- `secondarySourceColorHct`
- `tertiarySourceColorHct`
- `neutralSourceColorHct`
- `neutralVariantSourceColorHct`
- `errorSourceColorHct`

### Monochrome seed

`respectMonochromeSeed` plus `isPrimaryMonochrome`, `isSecondaryMonochrome`, `isTertiaryMonochrome`, `isNeutralMonochrome`, `isNeutralVariantMonochrome`, `isErrorMonochrome`. When both the respect flag and the palette flag are true, chroma for that palette is 0.

### Expressive on-container colors

`DynamicScheme.useExpressiveOnContainerColors` (default `true` since FSS 4.0.0). `MaterialDynamicColors` reads it via `_useExpressiveOnContainers`. FSS keeps the older higher-contrast on-container tones when the flag is `false`. Do not hard-code MCU 0.12+ light on-container behavior as the only path.

### `errorPalette`

`DynamicScheme` takes `errorPalette` (renamed from `customErrorPalette` in FSS 4.0.0 to match MCU 0.13). Scheme constructors pass it through when `errorSourceColorHct` is set.

### `Scheme` kept available

Upstream deprecates `Scheme`. This fork does not. Keep the class, FSS dartdoc (including the migration URL), and extra roles added for Flutter 3.22+ `ColorScheme` compatibility. Do not add `@Deprecated`.

### `CorePalettes`

Upstream type is unused and incomplete vs `CorePalette` (no error palette). This fork adds `==`, `hashCode`, and `toString`. Keep those.

## Style translation

| Upstream Dart MCU                             | This fork                                                                      |
| --------------------------------------------- | ------------------------------------------------------------------------------ |
| Relative imports (`../utils/math_utils.dart`) | `package:flex_seed_scheme/src/mcu/utils/math_utils.dart`                       |
| Often inferred locals                         | Explicit types where the rest of the file uses them (`final double hue = ...`) |
| Google dartfmt ~80 cols                       | `page_width: 120`, `trailing_commas: preserve`; run `dart format`              |
| `@Deprecated` on `Scheme`                     | Omit; keep FSS docs instead                                                    |

Keep Google license headers. Keep `// RydMike:` and FlexSeedScheme notes. Do not rewrite MCU comments unless they are factually wrong ([code-documentation](../code-documentation/SKILL.md)).

## Canonical example (0.13.1)

Upstream commit [158b9c1](https://github.com/material-foundation/material-color-utilities/commit/158b9c185a25c53fddd051cba811d542e6b94d68) replaced an inline Cam16 hue wrap with `MathUtils.sanitizeDegreesDouble`. For `atan2` hues in `(-180, 180]` that is DRY, not a color-output change. FSS already had it in 4.0.0; 5.0.0 only recorded pub 0.13.1 parity plus the `Scheme` doc URL. That is the “already applied” pattern.
