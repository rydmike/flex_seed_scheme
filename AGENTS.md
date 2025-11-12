# Repository Guidelines

## Project Structure & Module Organization
- `lib/` holds all production Dart source, including `src/` helpers and the public API surface exported by `flex_seed_scheme.dart`.
- `example/` hosts the Flutter demo and integration playground; update it whenever you add user-facing behaviors so the published sample stays in sync.
- `test/` keeps regression suites grouped by feature; mirror the folder names from `lib/` so it is obvious where a failing test belongs.
- `doc_assets/` stores screenshots referenced from `README.md`, while `coverage/` and `build/` are generated outputs — do not hand-edit them.
- Check `analysis_options.yaml` and `pubspec.yaml` when touching analyzer settings or dependency ranges; both files gate CI.

## Build, Test, and Development Commands
Use Flutter 3.35+ with Dart 3.9.
- `flutter pub get` — refreshes dependencies for the package and the example app.
- `dart format lib test example --fix` — enforces the canonical 2-space indentation before committing.
- `flutter analyze` — runs the strict analyzer + custom lint bundle from `analysis_options.yaml`.
- `flutter test --coverage && genhtml coverage/lcov.info -o coverage/html` — executes all suites and refreshes the LCOV report mirrored on Codecov.

## Coding Style & Naming Conventions
Formatting is always delegated to `dart format`; never hand-align. The repo includes every lint from `all_lint_rules.yaml`, plus `strict-casts`, `strict-inference`, and `strict-raw-types`, so prefer explicit generics and null-safe guards. Expose public symbols in PascalCase, keep members and locals in lowerCamelCase, and prefix private helpers with `_`. Match file names to the primary type (`seed_color_scheme.dart`, `flex_tones.dart`) and keep doc comments focused on reasoning, not usage.

## Testing Guidelines
Tests rely on `flutter_test`, `package:test`, `matcher`, and custom color utilities under `test/utils`. Name files `<feature>_test.dart`, group cases with `group()` labels, and assert tonal values via the shared matchers to keep diffs readable. Aim to maintain or raise the coverage recorded in `coverage/lcov.info`; add regression tests for every bug fix before requesting review.

## Commit & Pull Request Guidelines
Follow the existing short, tagged commit style (`FIX:`, `ADD:`, `CHORE:`) and describe the change in imperative mood, optionally referencing `#issue-id`. Each PR should summarize the motivation, list functional changes, mention any screenshots from `example/`, and link related issues. Confirm analyzer + test output in the PR description, and call out any API or behavior risks so reviewers can focus on them.
