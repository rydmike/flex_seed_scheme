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
