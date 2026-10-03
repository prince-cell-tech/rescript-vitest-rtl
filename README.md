# rescript-vitest-bindings

Zero-cost ReScript bindings for Vitest, `@testing-library/react`, and
`@testing-library/jest-dom`, with a unified `Expect` assertion namespace
and a small demo app proving the bindings work.

## Installation

```sh
npm install
```

Requires the peer dependencies in `package.json`
(`vitest`, `@testing-library/react`, `@testing-library/jest-dom`).

## Scripts

- Build ReScript: `npm run res:build`
- Clean: `npm run res:clean`
- Build & watch: `npm run res:dev`
- Dev server (demo app): `npm run dev`
- Tests: `npm test`
- Tests in watch mode: `npm run test:watch`

## Layout

- `src/bindings/` — the library: `Vitest`, `TestingLibrary`, `JestDom`,
  and `Expect` (unified assertions, the one to use in tests). See
  `src/bindings/README.md`.
- `src/demo/` — demo app (`App`) + proof tests (`App_test`).
- `src/Main.res` — demo entry point.

The package sets `"namespace": true` in `rescript.json`, so consumers
see modules as `RescriptVitestBindings.Expect`, etc.

## Compatibility

Bindings are pinned to `vitest@5`, `@testing-library/react@16`, and
`@testing-library/jest-dom@7` (see `peerDependencies`).
