---
name: code-documentation
description: Update Dart documentation for completeness and helpfulness in FlexSeedScheme. Use when the user asks for documentation, and when creating or updating public API, comments, README, or CHANGELOG.
---

# Code Documentation

Document intent and purpose so humans and agents can maintain this package. The user may request a scope: file(s), folder(s), a selected change, or uncommitted work.

**Never** document the entire repository in one pass.

## Existing comments

- Do not remove or shorten comments unless the user asks, or the comment is stale, wrong, or refers to removed APIs.
- When you touch a comment, leave it more accurate than before.
- Keep Google Apache-2.0 license headers on MCU files. Do not rewrite MCU comments into a new voice unless they are factually wrong.

## Completeness

- Public classes, enums, constructors, and members in `lib/` need `///` dartdoc. `public_member_api_docs` is enforced on the package; the example app turns it off.
- Private helpers use `//`. Terse is fine when the code is obvious; add more when the logic is not (HCT, chroma caps, tone mapping, contrast curves).
- Explain purpose, defaults, and how parameters interact. Usage tutorials belong in README and [.agents/skills/flex-seed-scheme/SKILL.md](../flex-seed-scheme/SKILL.md), not in every member doc.

### Dartdoc references

- **`//` comments:** Do not use `[Type]` or `[member]`. Dartdoc does not resolve them there. Use ASCII backticks.
- **`///` comments:** Use `[Type]` / `[member]` only when the symbol is in dartdoc scope (same rules as analyzer unresolved-identifier warnings). If it is not in scope, use backticks. Do not add imports only to bring a symbol into doc scope.
- Unresolved references in `///` produce analyzer info-level issues that fail CI.

### Language

- Use simple, direct language. Avoid jargon that does not help.
- Tone and chroma integers (40, 80, 36, …) **are** the domain. Name what they map to in comments. Do not invent a spacing-token system for them.
- Short `dart` snippets on `fromSeeds`, `FlexTones`, and `FlexSchemeVariant` are welcome when they show a default, an interaction, or a migration. Do not paste the README.

### Magic numbers

- Prefer a named local or static constant when a number is reused or its meaning is not obvious from context.
- Document what the value is, what it does, and how it was chosen when that is known (Material spec tone, MCU chroma cap, FSS extension).

## Verify claims against code

Any doc comment stating a number (tone, chroma, default, count, version) must be verified against its source of truth before you write or keep it — the 5.0.0 doc sweep found the same stale values repeated in 6+ places. Sources of truth:

- `FlexTones.light` / `FlexTones.dark` parameter defaults in [flex_tones.dart](../../../lib/src/flex/flex_tones.dart) — neutralChroma **6**, neutralVariantChroma **8**, paletteType extended, useCam16 true
- `FlexCorePalette.fromSeeds` fallbacks in [flex_core_palette.dart](../../../lib/src/flex/flex_core_palette.dart) — primaryMinChroma `?? 48`, other minChromas `?? 0`, tertiaryHueRotation `?? 60`, error default hue 25 / chroma 84
- `FlexTonalPalette.commonTones` (15) and `extendedTones` (**30**) in [flex_tonal_palette.dart](../../../lib/src/flex/flex_tonal_palette.dart)
- MCU palette definitions in `lib/src/mcu/scheme/scheme_*.dart` for the `isFlutterScheme` variants

Historic traps — claims that keep resurfacing stale:

- `background`, `onBackground`, `surfaceVariant`: **deprecated** in Flutter 3.22, still present as deprecated in material_ui 1.0.1 — say "deprecated", not "removed". FSS stopped mapping them in 3.1.0.
- `useExpressiveOnContainerColors` defaults to **true** since FSS 4.0.0 (was false in 3.0.0). Flutter 3.44+ always uses expressive on-containers, no opt-out. The flag only switches the light-mode on-container tone 30/10, never the ContrastCurve.
- `customErrorPalette` was renamed `errorPalette` in FSS 4.0.0.
- Material-3 neutral chroma default changed 4 → 6 in FSS 2.0.0 / Flutter 3.22 (primary 48 → 36, neutral 4 → 6); "chroma 4" and "min 48, matching Flutter" claims are usually pre-2.0 leftovers.
- The `FlexPaletteType.common` high-tone chroma clamp (max 40 at tone >= 90) was deleted in FSS 2.0.0 — the palette types now differ only in their tone sets.

## FlexSchemeVariant UI string conventions

`configDetails` lines follow two distinct hue-rotation phrasings — they encode different code behavior:

- `'Tertiary - Hue primary rotated 60 degrees or key, Chroma 24'` — a provided key color's hue is used **as-is**; rotation applies only as fallback from primary.
- `'Secondary - Hue from primary or key rotated 10-18 degrees, Chroma 24'` — the rotation is applied **even to a provided key** (MCU `getRotatedHue` variants: vibrant, expressive; fruitSalad's fixed −50).

Other conventions: `description` has no trailing period; every configDetails block ends with `'Variant style: Material Color Utilities (MCU)'` or `'Variant style: Flex Seed Scheme (FSS)'`; the shared error line is `'Error - Hue 25, Chroma 84. Optionally Hue and Chroma from key'`.

## Public API docs

On `SeedColorScheme.fromSeeds`, `FlexTones`, `FlexSchemeVariant`, and palettes, cover:

- What the API is for and when to choose it
- Defaults (both `tones` and `variant` null → `FlexTones.material`; `useExpressiveOnContainerColors` true since 4.0.0; `respectMonochromeSeed` false)
- Interactions: `tones` vs `variant` exclusivity; `contrastLevel` only if `variant.isFlutterScheme`; modifiers only on `tones`; seed keys vs color overrides (pinning)
- Breaking or default-flip history when it still affects callers

`FlexSchemeVariant` UI metadata (`variantName`, `description`, `configDetails`, `icon`, `shade`) may change in patches; say so if you document those fields.

## On-demand extras

Only when the user asks, or when the change is user-facing:

- Update README and CHANGELOG for behavior or API that consumers will notice
- Keep comments in `example/` accurate, especially `example/lib/theme/model/app_theme.dart`

Do not create per-folder README files under `lib/`.
