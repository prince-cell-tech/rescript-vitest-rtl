# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - TBD

First release.

### Added

- Zero-cost ReScript bindings for `vitest@5` (`Vitest`: suites, tests,
  hooks, `Vi` mocks/timers, `expect` + matchers, `Assert`).
- Zero-cost bindings for `@testing-library/react@16` (`TestingLibrary`):
  8 query families × 6 variants with typed options, `fireEvent` set,
  native `focusElement`/`blurElement`, `within`, `waitFor` helpers.
- Zero-cost bindings for `@testing-library/jest-dom@7` (`JestDom`).
- Unified `Expect` assertion facade (single autocomplete namespace).
- Demo app + 14 proof tests.
- Package namespacing (`RescriptVitestBindings`) for consumers.
