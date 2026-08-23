# FlexSeedScheme

FlexSeedScheme (FSS) is a published Flutter package that replaces `ColorScheme.fromSeed` with up to six seed keys, custom chroma, and configurable tone mapping. It was extracted from FlexColorScheme (FCS) v6+. FCS depends on this package and re-exports its API. Breaking changes here break FCS and other downstream apps. Documentation quality, tests, and **100% Codecov coverage** are required.

SDK constraints live in `pubspec.yaml`. Use `fvm flutter` locally.

## Agent configuration

`AGENTS.md` is the only instruction master. Skills live in `.agents/skills/`.

Claude Code uses generated `CLAUDE.md` and a generated skills mirror. Recreate them after master edits:

```bash
./scripts/sync_claude_code_config.sh
```

The script rewrites skill paths for Claude. Optional teardown: `./scripts/delete_claude_code_config.sh`. Never hand-edit generated Claude files. Cursor: keep **Include third-party Plugins, Skills, and other configs** off so the generated mirror is not loaded twice. Details: [scripts/README.md](scripts/README.md).

## Skills

Load the matching skill; do not paste their contents into this file.

| Skill                                                                                      | When                                                                                 |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| [.agents/skills/package-development/SKILL.md](.agents/skills/package-development/SKILL.md) | Changing `lib/`, `test/`, `example/`, or CI                                          |
| [.agents/skills/mcu-fork-sync/SKILL.md](.agents/skills/mcu-fork-sync/SKILL.md)             | Checking or porting Dart MCU upstream (`material_color_utilities`, Cam16, fork sync) |
| [.agents/skills/flex-seed-scheme/SKILL.md](.agents/skills/flex-seed-scheme/SKILL.md)       | Using the package (`example/`, or copy into a consuming app)                         |
| [.agents/skills/code-documentation/SKILL.md](.agents/skills/code-documentation/SKILL.md)   | Writing or updating dartdoc and comments                                             |
| [.agents/skills/code-review/SKILL.md](.agents/skills/code-review/SKILL.md)                 | Reviewing a branch, PR, or uncommitted diff                                          |

## Commands

`example/` is a separate package, not a pub workspace.

```bash
fvm flutter pub get
(cd example && fvm flutter pub get)
dart format lib test example --fix
dart analyze
fvm flutter test --coverage
```

CI also runs `dart format --output=none --set-exit-if-changed .`. Optional local HTML: `genhtml coverage/lcov.info -o coverage/html`. Never hand-edit `coverage/` or `build/`.

## Layout

- `lib/flex_seed_scheme.dart` — public barrel
- `lib/src/flex/` — FSS API (`SeedColorScheme`, `FlexTones`, `FlexSchemeVariant`, palettes, color extensions)
- `lib/src/mcu/` — forked Material Color Utilities. Do not casually edit
- `test/flex_*_test.dart` — FSS tests; `test/mcu/` — MCU tests; matchers in `test/mcu/utils/`
- `example/` — demo app; keep it in sync with user-facing behavior
- `doc_assets/` — README screenshots

## Seed to scheme

Entry point: `SeedColorScheme.fromSeeds`. `FlexSeedScheme` is `@internal` — never construct it from outside.

Two exclusive paths:

- `tones: FlexTones` — custom chroma and tone mapping; modifiers (`onMainsUseBW`, `monochromeSurfaces`, …) only work here
- `variant: FlexSchemeVariant` — includes Flutter `DynamicSchemeVariant` values (`isFlutterScheme: true`) and FlexTones presets. `contrastLevel` applies only when `isFlutterScheme` is true

If both are null, the default is `FlexTones.material`. If both are set, debug asserts; in release `variant` wins.

Seed keys (`primaryKey`, `secondaryKey`, …) set hue and chroma of palettes. They are **not** the `ColorScheme` role colors unless you also pass that color as an override (`primary: brand` in light, typically `primaryContainer: brand` in dark).

## Quality bar

- **Coverage:** keep 100% on Codecov. Every new branch and function needs tests. Never ship a coverage drop.
- **Docs:** `public_member_api_docs` is on for `lib/`. Unresolved dartdoc `[Type]` references fail CI. Explain *why* and how parameters interact; usage tutorials belong in README and the consume skill.
- **API:** no breaking public API without discussion. See [CONTRIBUTING.md](CONTRIBUTING.md). FlexColorScheme inherits this surface.
- **User-facing changes:** update `example/` and README. CHANGELOG sections: `BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE`.

## Style

`dart format` owns layout (`page_width: 120`, trailing commas preserved). Use package imports (`always_use_package_imports`), PascalCase types, lowerCamelCase members, `_` for private. Match file names to the primary type (`flex_tones.dart`, `seed_color_scheme.dart`).

`///` on public API; `//` on private helpers. In `//`, wrap names in backticks — never `[Type]`. In `///`, use `[Type]` only when the symbol is in dartdoc scope.

## Tests

FSS suites use numbered `GIVEN` / `EXPECT` names (`FCS7`, `FTO1`, …), Flutter `equals`, or golden `toString` + `equalsIgnoringHashCodes`. MCU suites are Google-ported hex locks via `isColor` / `isCloseToColor`. Do not rewrite MCU hex values or FSS golden blobs unless the behavior change is intentional. Recipes: [package-development](.agents/skills/package-development/SKILL.md).

## Git and PRs

Tagged imperative messages (`FIX:`, `ADD:`, `CHORE:`, or existing `fix:` / `chore:` / `test:`), optional `#issue`. PRs target `master`. Summarize motivation, functional changes, example screenshots if UI, analyzer + test results, and any API or behavior risk.

## Worktrees

Cursor and Codex run `bash scripts/setup_worktree.sh` automatically. Claude Code does not — run it before the first `pub get`, test, or example run. Guide: [docs/guides/using-worktrees-guidance.md](docs/guides/using-worktrees-guidance.md).
