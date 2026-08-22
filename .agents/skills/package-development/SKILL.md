---
name: package-development
description: Develop and maintain FlexSeedScheme: public lib/src/flex API, forked MCU, tests, 100% coverage, example app. Use when editing this package's source, tests, example, or CI.
---

# Package development

Maintain FlexSeedScheme as a public Flutter package. Consumer usage belongs in [.agents/skills/flex-seed-scheme/SKILL.md](../flex-seed-scheme/SKILL.md). Documentation and review conventions are separate skills.

## Public vs internal

Barrel [`lib/flex_seed_scheme.dart`](../../../lib/flex_seed_scheme.dart) exports:

- `SeedColorScheme` only from `flex_seed_scheme.dart` (not `FlexSeedScheme`)
- `FlexTones`, `FlexSchemeVariant`, `FlexCorePalette`, `FlexTonalPalette`, `FlexPaletteType`
- `FlexColorSeedColorExtensions` (`value32bit`, `alpha8bit`, `red8bit`, `green8bit`, `blue8bit`)
- MCU: `Blend`, `Cam16`, `CorePalette`, `DynamicColor`, `DynamicScheme`, `Hct`, `MaterialDynamicColors`, `Scheme`, `TonalPalette`, `ViewingConditions`

`FlexSeedScheme` is `@internal`. Callers use `SeedColorScheme.fromSeeds`. Do not expand MCU exports without explicit demand and a stability review.

`FlexSchemeVariant` UI metadata (`variantName`, `description`, `configDetails`, `icon`, `shade`) may change in patches; that is documented policy, not a breaking API.

## Two generation paths

Orchestration: [`lib/src/flex/flex_seed_scheme.dart`](../../../lib/src/flex/flex_seed_scheme.dart) (`SeedColorScheme.fromSeeds`).

1. **FlexTones** — [`flex_tones.dart`](../../../lib/src/flex/flex_tones.dart). `FlexCorePalette` builds six palettes; tones map to `ColorScheme` roles. Modifiers chain on `FlexTones`. Custom configs start from `FlexTones.light` / `FlexTones.dark`.
2. **DynamicScheme / MCU** — `variant` with `isFlutterScheme: true`. Forked schemes under `lib/src/mcu/scheme/`. Multi-seed keys still apply (FSS fork). `contrastLevel` is honored only on this path.

`tones` and `variant` are mutually exclusive. Both null → `FlexTones.material`. Debug asserts if both set; release prefers `variant`.

`useExpressiveOnContainerColors` (default true since 4.0.0) and `respectMonochromeSeed` (default false) apply on both paths. Apply expressive-on **before** FlexTones modifiers; last modifier wins on conflicts.

## MCU fork

`lib/src/mcu/` is a bundled fork of Material Color Utilities. MCU is 0.x; Flutter pins it, so a pub dependency cannot track Flutter channels cleanly.

FSS-specific deltas — do not remove them:

- Multi-seed `DynamicScheme` constructors (secondary / tertiary / error / neutral / neutralVariant sources)
- `respectMonochromeSeed` and monochrome flags
- `useExpressiveOnContainerColors` on `DynamicScheme` / `MaterialDynamicColors`
- `errorPalette` (renamed from `customErrorPalette` in 4.0.0 to match MCU 0.13)

Rules:

- Sync from upstream surgically. Re-run `test/mcu/**` and the `ColorScheme.fromSeed` parity loop in FSS tests.
- Keep Google license headers.
- Never replace the fork with a pub `material_color_utilities` dependency unless the maintainers explicitly ask.
- Do not “simplify” scheme constructors or contrast-curve wiring.

## Testing

Keep **100%** Codecov coverage. New branches and functions need tests. `fvm flutter test --coverage` at the repo root.

### FSS (`test/flex_*_test.dart`)

- `flutter_test`, numbered groups: `group('FTO1: WITH FlexTones ', …)` then `test('FTO1.01a: GIVEN … EXPECT …')`.
- Config tests: `equals` on `FlexTones` fields and objects.
- Single-seed parity: `SeedColorScheme.fromSeeds` equals `ColorScheme.fromSeed` after `.copyWith(surfaceVariant: flutter.surfaceVariant)` (Flutter still fills the deprecated role).
- Multi-seed / flag regressions: `scheme.toString(minLevel: DiagnosticLevel.fine)` + `equalsIgnoringHashCodes(...)`. These blobs are intentional locks against HCT/MCU drift. Update them only when the behavior change is deliberate.

### MCU (`test/mcu/`)

- Mostly `package:test` plus [`test/mcu/utils/color_matcher.dart`](../../../test/mcu/utils/color_matcher.dart): `isColor` (exact ARGB), `isCloseToColor` (Cam16 distance ≤ 5).
- Hex expectations are Google-ported goldens. Do not casual-edit them. Scheme helper: `test/mcu/utils/scheme_from_variant.dart`.

### Adding coverage

| Change                              | Tests                                                                   |
| ----------------------------------- | ----------------------------------------------------------------------- |
| New `FlexTones` factory or modifier | `test/flex_tones_test.dart` plus a `fromSeeds` case if mapping changes  |
| New `fromSeeds` flag or seed key    | `test/flex_seed_scheme_test.dart` (parity and/or golden)                |
| `FlexSchemeVariant` value           | `test/flex_scheme_variant_test.dart` and a generation smoke/parity case |
| MCU algorithm / scheme class        | matching `test/mcu/*_test.dart` hex or contrast matrix                  |

`example/test/widget_test.dart` is smoke only. It does not replace package unit tests.

## Do not edit without intent

- `lib/src/mcu/**` — fork + license; only for upstream sync or FSS deltas
- MCU hex expectations and large FSS golden `toString` strings
- `coverage/`, `build/`, `.dart_tool/`
- Generated Claude mirrors (`CLAUDE.md`, `.claude/skills/`) — regenerate with `./scripts/sync_claude_code_config.sh`

## Example and release

- User-facing behavior: update `example/` (especially `example/lib/theme/model/app_theme.dart`) and README.
- CHANGELOG tags: `BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE` (also `PACKAGE`, `WEB DEMO` when those apply).
- Web demo deploys from `.github/workflows/deploy.yml` on GitHub **release**, not from `dart pub publish`. Publishing to pub.dev is manual.
- CI (PRs to `master`): `dart analyze`, `dart format --output=none --set-exit-if-changed .`, `flutter test --coverage` → Codecov.

## Style reminders

Package imports, `dart format`, `public_member_api_docs` on `lib/`. Unresolved dartdoc `[Type]` fails CI. Details: [AGENTS.md](../../../AGENTS.md) and [.agents/skills/code-documentation/SKILL.md](../code-documentation/SKILL.md).
