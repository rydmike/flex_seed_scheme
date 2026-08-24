---
name: code-review
description: Review FlexSeedScheme changes for correctness, API stability, coverage, and conventions. Use when reviewing a pull request, branch, or uncommitted diff, or when the user asks for a code review.
---

# Code Review

Review the requested scope: current branch, given files or folders, a specific change, or all uncommitted work.

When reviewing the **entire current branch**, start from its real base (usually `master`). Do not review merge commits from other branches. Limit the review to work actually done on this branch.

## Summary

First explain intent: what changed, why, and how it is implemented. Call out user benefit and impact on the published API. Use a mermaid flowchart only when a new generation path is hard to follow in prose.

## Principles

Find issues automated review bots would flag, before they do.

### Structure

- Number findings by **major**, **medium**, **minor**.
- Say what is good as well as what is bad.
- Be direct and polite.

### Complexity

Prefer simple, clear code. Flag over-engineering that does not add value. Suggest simplifications that keep behavior unchanged.

### Dead code

Unused variables, functions, classes, consts, and commented-out blocks.

### Logging, documentation, tests

- This package has no app logging stack. Do not ask for log statements.
- Documentation: public `///` on `lib/` API; comments on non-obvious paths. Path moves must update imports, comments, README, and example — not only Dart imports.
- Testing: where coverage is strong vs weak; whether new branches need FSS unit tests, MCU hex locks, or golden `toString` updates. See [.agents/skills/package-development/SKILL.md](../package-development/SKILL.md).

Ignore generated file churn (`coverage/`, `build/`, `.dart_tool/`).

## Package review checks

Classify by real impact (major / medium / minor).

### API stability

- New required parameters, renamed public symbols, or default flips. `useExpressiveOnContainerColors` defaulting to `true` in 4.0.0 is the cautionary case.
- Anything FlexColorScheme or other consumers inherit from the barrel export.
- Expanding the MCU re-export set in `lib/flex_seed_scheme.dart` needs demand and a stability review.
- `FlexSchemeVariant` UI strings (`variantName`, `description`, `configDetails`, `icon`, `shade`) are documented as patch-level, not breaking — do not treat those edits as major API breaks.

### Coverage

- Every new public and private branch must be tested. Codecov is 100%; a drop is major.
- MCU hex expectations and FSS golden `toString` blobs change only when behavior is meant to change. Unexplained golden churn is major.

### MCU fork

- Do not “simplify” or remove multi-seed, `respectMonochromeSeed`, or `useExpressiveOnContainerColors` parameters.
- Keep Google license headers.
- Casual refactors of `lib/src/mcu/` without an upstream sync and matching tests are major.

### Parity

- Single-seed `SeedColorScheme.fromSeeds` must still match `ColorScheme.fromSeed` (tests copy deprecated `surfaceVariant` from the Flutter scheme for equality).
- Do not reintroduce `background`, `onBackground`, or `surfaceVariant` as FSS-owned seed overrides.

### Docs and example

- README, dartdoc, and `example/lib/theme/model/app_theme.dart` stay aligned for user-facing behavior.
- CHANGELOG section tags when the change will ship.

### Analyzer and format

- `dart format` and `dart analyze` clean. New `// ignore:` needs a reason that survives being read aloud.

## Reporting

Use GitHub-friendly markdown: `#` / `##` / `###` headings, numbered lists. Do not hard-wrap paragraphs. Do **not** use wide tables or `::code-comment` fences (GitHub cannot parse the latter).

### Implementation analysis

If a simpler approach would reach the same outcome, show it with a snippet. If the change is sound, do not invent noise.

### Fix suggestions

For each numbered finding, give an adoptable snippet and any extra tests (FSS `GIVEN`/`EXPECT` or MCU `isColor`) that should land with the fix.

## Summary counts

- Issues by level: major, medium, minor
- Fix suggestions
- Additional tests suggested
