# Test bindings

Zero-cost ReScript bindings for the JS test stack. Every `external`
inlines to its JS counterpart, so e.g. `TestingLibrary.render(<App />)`
compiles to `import { render } from "@testing-library/react"`.

Each module has a `.res` (docs + implementation) and a mirrored `.resi`
(keeps `external`s inlinable). Names must match between the two.

## For consumers

This package sets `"namespace": true`, so downstream projects see every
module under `RescriptVitestBindings` — no collisions with their own
`Expect` / `App` / etc.:

```rescript
RescriptVitestBindings.Expect.expect(el)->RescriptVitestBindings.Expect.toBeInTheDocument
```

Inside this repo, use the short names (`Expect`, `TestingLibrary`, …);
namespacing only affects consumers.

## Modules

- `Vitest.res` — suites (`describe`/`suite`), tests (`test`/`it`),
  hooks, `Vi` mocks/timers, `expect` + matchers with phantom
  sync/async modes, `Assert` helpers. Pinned to `vitest@5.0.0`.
- `Expect.res` — **use this in tests**: unified assertion entry point
  re-declaring `Vitest`'s `expect` machinery + core matchers and all
  `JestDom` matchers in one namespace, so `Expect.` completes with the
  full matcher list. `Vitest` (runner) and `JestDom` keep working;
  when adding a matcher upstream, add it here too.
- `TestingLibrary.res` — `@testing-library/react@16` queries for all
  8 families (LabelText, PlaceholderText, Text, AltText, Title,
  DisplayValue, Role, TestId) × 6 variants (getBy/getAllBy/queryBy/
  queryAllBy/findBy/findAllBy), each in string, `Regex`, and `With`
  (typed options) forms; `fireEvent` for the common event set;
  native `focusElement`/`blurElement` (these move
  `document.activeElement`, unlike `fireEvent.focus/blur`);
  `within`, `waitFor`, `waitForElementToBeRemoved`, `configure`,
  `debug`, `cleanup`.
- `JestDom.res` — `@testing-library/jest-dom@7` matchers as `@send`
  on `Vitest.assertion`. Overload convention: `toHaveX(string)`,
  `toHaveXRegex(RegExp.t)`, `toHaveXWith(value, opts)`; absence
  checks are `toHaveNoX`.

## Deliberately omitted

- `@testing-library/user-event` — no new dependencies by decision.
  Use `fireEvent` + native `focusElement`/`blurElement`.
- `Vitest`: `bench`, `test.extend` fixtures, `vi.mock` hoisting,
  `expectTypeOf`, `test.only`/`describe.only` (see module header).
- Role `name`/`description` as predicate functions; `ByRoleOptions.value`;
  `waitForOptions` beyond timeout/interval; `ignore` in boolean form.
- Deprecated jest-dom matchers (`toBeInTheDOM`, `toBeEmpty`,
  `toHaveDescription`, `toHaveErrorMessage`) are still bound for
  completeness — prefer their replacements.

## Conventions

- `queryBy*` returns `option<Dom.element>` (`null` is unrepresentable);
  `findBy*` returns `promise<...>` — use `Vitest.testAsync` + `await`.
- Tests are colocated: `Foo_test.res` lives next to `Foo.res`.
- New bindings go here, not in `src/demo/`.
