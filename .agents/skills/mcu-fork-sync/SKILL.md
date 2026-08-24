---
name: mcu-fork-sync
description: Check and port Dart-only upstream Material Color Utilities into the customized MCU fork under lib/src/mcu. Use when MCU, material_color_utilities, Cam16, Hct, DynamicScheme, or an upstream fork sync is mentioned, or when a new MCU Dart version is published.
---

# MCU fork sync

Sync **Dart only** from [material-color-utilities](https://github.com/material-foundation/material-color-utilities) `dart/` into this package’s fork at [`lib/src/mcu/`](../../../lib/src/mcu/). Do not fetch, diff, or translate `java/`, `kotlin/`, `swift/`, `typescript/`, or `cpp/`.

This is not a drop-in copy. Keep FSS deltas. Default: **investigate and report**. Port only when the user asks.

Path maps, FSS delta inventory, and style translation: [reference.md](reference.md).

## Baseline

Read, in order:

1. **Last synced** comment in [`lib/src/mcu/material_color_utilities.dart`](../../../lib/src/mcu/material_color_utilities.dart)
2. MCU notes in [`CHANGELOG.md`](../../../CHANGELOG.md)
3. Pub.dev [material_color_utilities changelog](https://pub.dev/packages/material_color_utilities/changelog)
4. GitHub [`dart/CHANGELOG.md`](https://github.com/material-foundation/material-color-utilities/blob/main/dart/CHANGELOG.md) (including Unreleased) and recent commits under `dart/lib/`

Optional: which MCU version Flutter currently pins. FSS may already be ahead; `ColorScheme.fromSeed` parity tests may still target Flutter’s pin.

GitHub `dart/` can land months before pub.dev. Search the fork for the new helper or API before treating it as missing. Canonical case: MCU 0.13.1 `Cam16` hue wrap via `MathUtils.sanitizeDegreesDouble` was already in FSS 4.0.0.

After every completed sync, update the Last-synced line (pub version + GitHub commit/date).

## Collect Dart delta

**In scope:** `dart/lib/**`, `dart/test/**`, `dart/CHANGELOG.md`.

Compare those files to `lib/src/mcu/` and `test/mcu/`. Ignore Google 80-column wrapping; this package uses `page_width: 120` and package imports.

Repo-root docs only if they explain a Dart API or a Dart doc-link fix.

## Classify every hunk

| Class                            | Action                                                                                                                                            |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Already in the fork              | Cite the local line. Do not re-apply.                                                                                                             |
| Algorithm / color math           | Port. Update MCU hex and FSS golden `toString` **only if** output is meant to change.                                                             |
| API rename / new public MCU type | Port. Check [`lib/flex_seed_scheme.dart`](../../../lib/flex_seed_scheme.dart) exports. Expanding MCU exports needs demand and a stability review. |
| Docs / comments / URLs           | Port into FSS voice. Do **not** add `@Deprecated` on `Scheme`.                                                                                    |
| Tests                            | Port useful Google tests into `test/mcu/`. Keep extra FSS tests. Never delete FSS coverage.                                                       |
| Conflicts with FSS deltas        | Re-apply upstream **around** the deltas in [reference.md](reference.md). Do not strip them.                                                       |

Formatter-only wrapping is not a port.

## Sync report (required)

Stop here unless the user asked to implement:

```markdown
# MCU sync report

- Fork last synced: <version / commit from material_color_utilities.dart>
- Upstream Dart: pub <version> | GitHub <commit> | Unreleased: <yes/no>
- Flutter MCU pin (optional): <version>

## Files that differ (Dart)

- `dart/lib/...` → `lib/src/mcu/...` — <class>

## Already applied

- <item and local location>

## Proposed work

- Risk: none | CHORE | CHANGE | BREAKING
- Flutter-parity tests: no change | flag/golden update
- CHANGELOG bullets: ...
```

## Port (only after confirmation)

1. Surgical edits in `lib/src/mcu/` and matching `test/mcu/`.
2. Translate imports to `package:flex_seed_scheme/src/mcu/...`.
3. Keep Google Apache-2.0 headers and FSS `// RydMike:` / FlexSeedScheme notes.
4. Fold FSS constructor parameters and flags back in if upstream rewrote a scheme class.
5. `dart format` owns layout (`page_width: 120`).
6. Update Last-synced and CHANGELOG (`CHORE` for mechanical/docs; `CHANGE` / `BREAKING` if colors or public MCU API move).
7. Never replace the fork with a pub `material_color_utilities` dependency.

Verify:

```bash
fvm dart format lib test example
fvm dart analyze
fvm flutter test --coverage
```

Re-run `test/mcu/**` and the `ColorScheme.fromSeed` parity loop in FSS tests. Unexplained golden churn is a bug.

## Do not

- Copy non-Dart MCU implementations
- “Simplify” scheme constructors or contrast-curve wiring
- Deprecate `Scheme` in this fork
- Casual-edit MCU hex goldens or large FSS `toString` blobs
