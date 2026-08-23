---
name: release
description: Release FlexSeedScheme to pub.dev and deploy the web demo. Use when publishing a new version, making a dev/prerelease, bumping the version, tagging a release, or verifying release readiness.
---

# Release

Releases are manual and ordered. Publishing to pub.dev does NOT deploy the web demo — publishing a **GitHub release** does, via [.github/workflows/deploy.yml](../../../.github/workflows/deploy.yml).

## Versioning

- `version:` lives in [pubspec.yaml](../../../pubspec.yaml). CHANGELOG top section heading must match it, with a `**Mon DD, YYYY**` date line.
- Prereleases for testing on pub use `-dev.N` (example: `5.0.0-dev.1`), released with a `chore:` commit. The final version gets its own CHANGELOG heading; fold the dev-release notes into it.
- Flutter's guidance: a bump of the required Flutter SDK is a **major** release even with no API changes — state that explicitly in the CHANGELOG (see 5.0.0).

## Pre-flight (all must pass)

```bash
fvm flutter pub get
(cd example && fvm flutter pub get)
fvm dart analyze
fvm dart format --output=none --set-exit-if-changed .
fvm flutter test --coverage
dart pub publish --dry-run
```

Also verify:

- CHANGELOG top section: correct version, date, and tags (`BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE`; `PACKAGE`, `WEB DEMO` when they apply).
- Coverage still 100% (Codecov gate).
- README and `example/` updated for any user-facing change; README web-demo links point at the current demo path (v5: `/flexseedscheme/demo-v5/`).
- No dry-run warnings you cannot explain.

## Publish

1. Commit and push; PR to `master` if not already there. CI (test.yml) must be green.
2. `dart pub publish` — manual, interactive; the user runs it or explicitly asks for it.
3. Tag `X.Y.Z` and publish a **GitHub release** with the CHANGELOG section as body.
4. The GitHub release triggers deploy.yml: analyze → format check → tests → Codecov → `flutter build web --base-href "/flexseedscheme/demo-v5/"` → push to `rydmike/rydmike.github.io`. A new major demo path needs deploy.yml **and** README links updated together.

## Post-release

- Check the pub.dev page: version, score, changelog rendering.
- Check the web demo URL serves the new build.
- Downstream coordination: **FlexColorScheme** consumes and re-exports this API — plan its constraint bump. The example app's **flex_color_picker** also depends on FSS (chicken-and-egg: publish FSS → update picker → then a FSS patch release can drop `MaterialUiCompatibilityBridge` from the example; documented in the 5.0.0 CHANGELOG).

## Do not

- Publish with failing/red CI, a coverage drop, or unexplained golden churn.
- Create the GitHub release before pub publish succeeded (the demo would advertise an unpublished version).
- Edit released CHANGELOG sections later — corrections get a new entry.
