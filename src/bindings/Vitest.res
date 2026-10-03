/* Full bindings for Vitest 5 (verified against vitest@5.0.0, the `latest` tag).
 *
 * Docs: https://vitest.dev/api/
 *
 * All `external`s inline to zero JS output, e.g.
 *   Vitest.test("1+1", () => Vitest.expect(1 + 1)->Vitest.toBe(2))
 * compiles to
 *   test("1+1", () => expect(1 + 1).toBe(2))
 *
 * Usage notes:
 * - `test` and `it` are aliases in Vitest; both are bound, use either.
 * - `describe` and `suite` are aliases; `suite`/`suiteAsync` are bound, all
 *   `describe*` variants behave identically on `suite`.
 * - Async bodies: use `testAsync`/`itAsync`/`describeAsync` with an
 *   `async () => {...}` function returning `promise<unit>`.
 * - `*_test.res` files are picked up by `vitest.config.mjs`
 *   (its `include` points at the compiled `*_test.res.mjs` files).
 * - Assertions carry a phantom sync/async mode: `resolves`/`rejects`
 *   switch to `async`, whose matchers (`toBeAsync`, ...) return
 *   `promise<unit>` and must be awaited.
 * - Mocks carry their function type (`Vi.mock<'fn>`); mock matchers only
 *   accept `expect(mock)` and check args/returns against it.
 *
 * Intentionally NOT bound (with reason):
 * - `bench` top-level: removed in Vitest 5, now a `test()` context fixture.
 * - `test.extend` / `test.override` fixtures: higher-order typed-context API;
 *   use module-level `let` bindings for shared fixtures in ReScript instead.
 * - `vi.mock` / `vi.unmock` / `vi.importMock` / `vi.hoisted`: rely on import
 *   hoisting; use dependency injection instead in ReScript.
 * - `expectTypeOf` / `assertType`: compile-time only, no runtime behavior;
 *   ReScript's own type system covers this.
 * - `should` (chai): mutates `Object.prototype`, not idiomatic in ReScript.
 * - `inject`, `getCurrentSuite` / `getCurrentTest`: custom runner/reporter
 *   internals, not needed for writing tests.
 * - Browser-mode APIs: different environment, out of scope here.
 * - `expect.getState` / `setState`: reporter internals.
 * - `toMatchInlineSnapshot`: rewrites the call-site file, which is a
 *   generated `.res.mjs` file; use `toMatchSnapshot` instead.
 * - `test.only` / `it.only` / `describe.only`: deliberately NOT bound.
 *   Vitest hard-errors on `.only` in CI, so expressing it must stay
 *   impossible; focus locally via a scratch file outside the suite.
 */

/* ------------------------------------------------------------------ */
/* Suites: describe / suite                                            */
/* https://vitest.dev/api/describe                                      */
/* ------------------------------------------------------------------ */

/** Defines a suite of related tests: `describe(name, fn)`. */
@module("vitest") external describe: (string, unit => unit) => unit = "describe"

/** Async suite body: `describe(name, async () => {...})`. */
@module("vitest") external describeAsync: (string, unit => promise<unit>) => unit = "describe"

/** Suite with a timeout in ms: `describe(name, fn, timeout)`. */
@module("vitest") external describeWithTimeout: (string, unit => unit, int) => unit = "describe"

/** Skipped suite, body never runs: `describe.skip(name, fn)`. */
@module("vitest") @scope("describe") external describeSkip: (string, unit => unit) => unit = "skip"

/** Suite stubbed as todo: `describe.todo(name, fn)`. */
@module("vitest") @scope("describe") external describeTodo: (string, unit => unit) => unit = "todo"

/** Concurrent suite, children may run in parallel: `describe.concurrent(name, fn)`. */
@module("vitest") @scope("describe")
external describeConcurrent: (string, unit => unit) => unit = "concurrent"

/** Concurrent suite with async body. */
@module("vitest") @scope("describe")
external describeConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"

/** Shuffled suite, children run in random order: `describe.shuffle(name, fn)`. */
@module("vitest") @scope("describe") external describeShuffle: (string, unit => unit) => unit = "shuffle"

/** Conditional skip: `describe.skipIf(cond)(name, fn)`. Skipped when `cond` is true. */
@module("vitest") @scope("describe")
external describeSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"

/** Conditional run: `describe.runIf(cond)(name, fn)`. Runs only when `cond` is true. */
@module("vitest") @scope("describe")
external describeRunIf: bool => ((string, unit => unit) => unit) = "runIf"

/** Data-driven suite, one sub-suite per flat case value:
    `describe.each(cases)(name, value => {...})`.
    Supports `%s/%d/%i/%f/%j/%o/%#` printf placeholders in `name`.
    Limitation: tuple cases are spread by JS, so prefer `describeFor` for
    tuples/objects; `describeEach` is for flat case arrays. */
@module("vitest") @scope("describe")
external describeEach: array<'a> => ((string, 'a => unit) => unit) = "each"

/** Data-driven suite passing each whole case (tuples/objects safe):
    `describe.for(cases)(name, case => {...})`. */
@module("vitest") @scope("describe")
external describeFor: array<'a> => ((string, 'a => unit) => unit) = "for"

/** Alias of `describe`: `suite(name, fn)`. */
@module("vitest") external suite: (string, unit => unit) => unit = "suite"

/** Alias of `describeAsync`: `suite(name, async () => {...})`. */
@module("vitest") external suiteAsync: (string, unit => promise<unit>) => unit = "suite"

/* ------------------------------------------------------------------ */
/* Tests: test / it                                                    */
/* https://vitest.dev/api/test                                          */
/* ------------------------------------------------------------------ */

/** Defines a test: `test(name, fn)`. */
@module("vitest") external test: (string, unit => unit) => unit = "test"

/** Alias of `test`: `it(name, fn)`. */
@module("vitest") external it: (string, unit => unit) => unit = "it"

/** Async test, runner waits for the promise: `test(name, async () => {...})`. */
@module("vitest") external testAsync: (string, unit => promise<unit>) => unit = "test"

/** Async `it`: `it(name, async () => {...})`. */
@module("vitest") external itAsync: (string, unit => promise<unit>) => unit = "it"

/** Test with a timeout in ms: `test(name, fn, timeout)`. */
@module("vitest") external testWithTimeout: (string, unit => unit, int) => unit = "test"

/** `it` with a timeout in ms: `it(name, fn, timeout)`. */
@module("vitest") external itWithTimeout: (string, unit => unit, int) => unit = "it"

/** Skipped test, body never runs: `test.skip(name, fn)`. */
@module("vitest") @scope("test") external testSkip: (string, unit => unit) => unit = "skip"

/** Skipped `it`: `it.skip(name, fn)`. */
@module("vitest") @scope("it") external itSkip: (string, unit => unit) => unit = "skip"

/** Todo stub: `test.todo(name, fn)`, reported as todo. */
@module("vitest") @scope("test") external testTodo: (string, unit => unit) => unit = "todo"

/** Todo `it`: `it.todo(name, fn)`. */
@module("vitest") @scope("it") external itTodo: (string, unit => unit) => unit = "todo"

/** Concurrent test: `test.concurrent(name, fn)`. */
@module("vitest") @scope("test") external testConcurrent: (string, unit => unit) => unit = "concurrent"

/** Concurrent `it`: `it.concurrent(name, fn)`. */
@module("vitest") @scope("it") external itConcurrent: (string, unit => unit) => unit = "concurrent"

/** Concurrent async test: `test.concurrent(name, async () => {...})`. */
@module("vitest") @scope("test")
external testConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"

/** Concurrent async `it`. */
@module("vitest") @scope("it")
external itConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"

/** Expected-failure test, passes iff the body fails: `test.fails(name, fn)`. */
@module("vitest") @scope("test") external testFails: (string, unit => unit) => unit = "fails"

/** Expected-failure `it`: `it.fails(name, fn)`. */
@module("vitest") @scope("it") external itFails: (string, unit => unit) => unit = "fails"

/** Conditional skip: `test.skipIf(cond)(name, fn)`. Skipped when `cond` is true. */
@module("vitest") @scope("test")
external testSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"

/** Conditional skip for `it`: `it.skipIf(cond)(name, fn)`. */
@module("vitest") @scope("it")
external itSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"

/** Conditional run: `test.runIf(cond)(name, fn)`. Runs only when `cond` is true. */
@module("vitest") @scope("test")
external testRunIf: bool => ((string, unit => unit) => unit) = "runIf"

/** Conditional run for `it`: `it.runIf(cond)(name, fn)`. */
@module("vitest") @scope("it")
external itRunIf: bool => ((string, unit => unit) => unit) = "runIf"

/** Data-driven test over flat cases: `test.each(cases)(name, value => {...})`.
    Same tuple-spreading limitation as `describeEach`; prefer `testFor`
    for tuples/objects. */
@module("vitest") @scope("test")
external testEach: array<'a> => ((string, 'a => unit) => unit) = "each"

/** Data-driven `it` over flat cases: `it.each(cases)(name, value => {...})`. */
@module("vitest") @scope("it")
external itEach: array<'a> => ((string, 'a => unit) => unit) = "each"

/** Data-driven test passing each whole case: `test.for(cases)(name, case => {...})`. */
@module("vitest") @scope("test")
external testFor: array<'a> => ((string, 'a => unit) => unit) = "for"

/** Data-driven `it` passing each whole case: `it.for(cases)(name, case => {...})`. */
@module("vitest") @scope("it")
external itFor: array<'a> => ((string, 'a => unit) => unit) = "for"

/* ------------------------------------------------------------------ */
/* Hooks                                                               */
/* https://vitest.dev/api/hooks                                         */
/* ------------------------------------------------------------------ */

/** Runs once before each test in the scope: `beforeEach(fn)`. */
@module("vitest") external beforeEach: (unit => unit) => unit = "beforeEach"

/** Async `beforeEach`: `beforeEach(async () => {...})`. */
@module("vitest") external beforeEachAsync: (unit => promise<unit>) => unit = "beforeEach"

/** Runs once after each test in the scope: `afterEach(fn)`. */
@module("vitest") external afterEach: (unit => unit) => unit = "afterEach"

/** Async `afterEach`. */
@module("vitest") external afterEachAsync: (unit => promise<unit>) => unit = "afterEach"

/** Runs once before all tests in the scope: `beforeAll(fn)`. */
@module("vitest") external beforeAll: (unit => unit) => unit = "beforeAll"

/** Async `beforeAll`. */
@module("vitest") external beforeAllAsync: (unit => promise<unit>) => unit = "beforeAll"

/** Runs once after all tests in the scope: `afterAll(fn)`. */
@module("vitest") external afterAll: (unit => unit) => unit = "afterAll"

/** Async `afterAll`. */
@module("vitest") external afterAllAsync: (unit => promise<unit>) => unit = "afterAll"

/** Wraps each test, must call `run()` to run it:
    `aroundEach(async run => { ...; await run(); ... })`.
    Extra `(context, suite)` args are ignored by the ReScript function. */
@module("vitest")
external aroundEach: ((unit => promise<unit>) => promise<unit>) => unit = "aroundEach"

/** Wraps the whole suite, must call `run()` to run it:
    `aroundAll(async run => { ...; await run(); ... })`. */
@module("vitest")
external aroundAll: ((unit => promise<unit>) => promise<unit>) => unit = "aroundAll"

/** Registers a callback for the current test's failure:
    `onTestFailed(() => {...})`. Only runs if the test fails. */
@module("vitest") external onTestFailed: (unit => unit) => unit = "onTestFailed"

/** Async `onTestFailed`. */
@module("vitest") external onTestFailedAsync: (unit => promise<unit>) => unit = "onTestFailed"

/** Registers a callback run when the current test finishes:
    `onTestFinished(() => {...})`. */
@module("vitest") external onTestFinished: (unit => unit) => unit = "onTestFinished"

/** Async `onTestFinished`. */
@module("vitest") external onTestFinishedAsync: (unit => promise<unit>) => unit = "onTestFinished"

/* ------------------------------------------------------------------ */
/* Vi utilities: mocks, timers, helpers                                */
/* https://vitest.dev/api/vi, https://vitest.dev/api/mock              */
/* ------------------------------------------------------------------ */

/** `vi.*` utilities. Mocks carry their function type as `mock<'fn>`, so
    `asFn` round-trips soundly and arg/return values are checked against it. */
module Vi = {
  /** Opaque mock of a function `'fn`, from `fn`/`fnWithImpl`/`spyOn`. */
  type mock<'fn>

  /** Creates a no-op mock returning `undefined`: `vi.fn()`.
      The function type is inferred from `asFn` or the first checked use. */
  @module("vitest") @scope("vi") external fn: unit => mock<'fn> = "fn"

  /** Creates a mock with an implementation: `vi.fn(impl)`.
      The impl's type becomes the mock's type. */
  @module("vitest") @scope("vi") external fnWithImpl: 'fn => mock<'fn> = "fn"

  /** Spies on an object's method: `vi.spyOn(obj, "method")`.
      The method type is inferred from use. */
  @module("vitest") @scope("vi") external spyOn: ({..}, string) => mock<'fn> = "spyOn"

  /** Checks whether a value is a mock: `vi.isMockFunction(v)`. */
  @module("vitest") @scope("vi") external isMockFunction: 'a => bool = "isMockFunction"

  /** Sound cast back to the mock's own function type (zero-cost `%identity`).
      Example: `let f: int => int = Vi.asFn(Vi.fnWithImpl(x => x + 1))`. */
  external asFn: mock<'fn> => 'fn = "%identity"

  /** Sets the return value: `mock.mockReturnValue(v)`, chainable.
      `v` must match the mock's return type. */
  @send external mockReturnValue: (mock<'args => 'r>, 'r) => mock<'args => 'r> = "mockReturnValue"

  /** One-shot return value: `mock.mockReturnValueOnce(v)`, chainable. */
  @send external mockReturnValueOnce: (mock<'args => 'r>, 'r) => mock<'args => 'r> = "mockReturnValueOnce"

  /** Resolved value for async mocks: `mock.mockResolvedValue(v)`, chainable. */
  @send
  external mockResolvedValue: (mock<'args => promise<'r>>, 'r) => mock<'args => promise<'r>> =
    "mockResolvedValue"

  /** One-shot resolved value: `mock.mockResolvedValueOnce(v)`, chainable. */
  @send
  external mockResolvedValueOnce: (mock<'args => promise<'r>>, 'r) => mock<'args => promise<'r>> =
    "mockResolvedValueOnce"

  /** Sets the implementation: `mock.mockImplementation(impl)`, chainable.
      The impl must match the mock's function type. */
  @send external mockImplementation: (mock<'fn>, 'fn) => mock<'fn> = "mockImplementation"

  /** One-shot implementation: `mock.mockImplementationOnce(impl)`, chainable. */
  @send external mockImplementationOnce: (mock<'fn>, 'fn) => mock<'fn> = "mockImplementationOnce"

  /** Clears call history, keeps implementation: `mock.mockClear()`. */
  @send external mockClear: mock<'fn> => mock<'fn> = "mockClear"

  /** Clears history and removes implementation: `mock.mockReset()`. */
  @send external mockReset: mock<'fn> => mock<'fn> = "mockReset"

  /** Restores the original (spied) implementation: `mock.mockRestore()`. */
  @send external mockRestore: mock<'fn> => mock<'fn> = "mockRestore"

  /** Names the mock for error messages: `mock.mockName(name)`. */
  @send external mockName: (mock<'fn>, string) => mock<'fn> = "mockName"

  /** Enables fake timers: `vi.useFakeTimers()`. */
  @module("vitest") @scope("vi") external useFakeTimers: unit => unit = "useFakeTimers"

  /** Restores real timers: `vi.useRealTimers()`. */
  @module("vitest") @scope("vi") external useRealTimers: unit => unit = "useRealTimers"

  /** Runs all pending timers: `vi.runAllTimers()`. */
  @module("vitest") @scope("vi") external runAllTimers: unit => unit = "runAllTimers"

  /** Async `vi.runAllTimersAsync()`, must be awaited. */
  @module("vitest") @scope("vi") external runAllTimersAsync: unit => promise<unit> = "runAllTimersAsync"

  /** Runs only currently-pending timers: `vi.runOnlyPendingTimers()`. */
  @module("vitest") @scope("vi") external runOnlyPendingTimers: unit => unit = "runOnlyPendingTimers"

  /** Advances fake timers by ms: `vi.advanceTimersByTime(ms)`. */
  @module("vitest") @scope("vi") external advanceTimersByTime: int => unit = "advanceTimersByTime"

  /** Async `vi.advanceTimersByTimeAsync(ms)`, must be awaited. */
  @module("vitest") @scope("vi")
  external advanceTimersByTimeAsync: int => promise<unit> = "advanceTimersByTimeAsync"

  /** Runs the next pending timer: `vi.advanceTimersToNextTimer()`. */
  @module("vitest") @scope("vi") external advanceTimersToNextTimer: unit => unit = "advanceTimersToNextTimer"

  /** Clears all scheduled timers: `vi.clearAllTimers()`. */
  @module("vitest") @scope("vi") external clearAllTimers: unit => unit = "clearAllTimers"

  /** Number of waiting timers: `vi.getTimerCount()`. */
  @module("vitest") @scope("vi") external getTimerCount: unit => int = "getTimerCount"

  /** Whether fake timers are on: `vi.isFakeTimers()`. */
  @module("vitest") @scope("vi") external isFakeTimers: unit => bool = "isFakeTimers"

  /** Mocks the system clock (ms epoch): `vi.setSystemTime(ms)`. */
  @module("vitest") @scope("vi") external setSystemTime: int => unit = "setSystemTime"

  /** Real current time in ms even with fake timers: `vi.getRealSystemTime()`. */
  @module("vitest") @scope("vi") external getRealSystemTime: unit => float = "getRealSystemTime"

  /** Retries `callback` until it stops throwing: `await vi.waitFor(() => {...})`. */
  @module("vitest") @scope("vi") external waitFor: (unit => 'a) => promise<'a> = "waitFor"

  /** Waits until `callback` returns truthy: `await vi.waitUntil(() => flag)`. */
  @module("vitest") @scope("vi") external waitUntil: (unit => 'a) => promise<'a> = "waitUntil"

  /** Defines a global for tests: `vi.stubGlobal(name, value)`. */
  @module("vitest") @scope("vi") external stubGlobal: (string, 'a) => unit = "stubGlobal"

  /** Removes all stubbed globals: `vi.unstubAllGlobals()`. */
  @module("vitest") @scope("vi") external unstubAllGlobals: unit => unit = "unstubAllGlobals"

  /** Stubs `process.env` entry: `vi.stubEnv(name, value)`. */
  @module("vitest") @scope("vi") external stubEnv: (string, string) => unit = "stubEnv"

  /** Restores `process.env`: `vi.unstubAllEnvs()`. */
  @module("vitest") @scope("vi") external unstubAllEnvs: unit => unit = "unstubAllEnvs"

  /** Clears all mocks' history: `vi.clearAllMocks()`. */
  @module("vitest") @scope("vi") external clearAllMocks: unit => unit = "clearAllMocks"

  /** Resets all mocks (history + implementations): `vi.resetAllMocks()`. */
  @module("vitest") @scope("vi") external resetAllMocks: unit => unit = "resetAllMocks"

  /** Restores all spies: `vi.restoreAllMocks()`. */
  @module("vitest") @scope("vi") external restoreAllMocks: unit => unit = "restoreAllMocks"
}

/* ------------------------------------------------------------------ */
/* Expect                                                              */
/* https://vitest.dev/api/expect                                        */
/* ------------------------------------------------------------------ */

/** Opaque assertion handle carrying the asserted value type `'value` and a
    phantom `'mode` (`sync` until `resolves`/`rejects` switches it to `async`).
    Sync matchers require `sync`; `*Async` matchers require `async` and must
    be awaited, so an un-awaited async assertion cannot silently pass. */
type sync

type async

type assertion<'value, 'mode>

/** Starts an assertion in `sync` mode: `expect(actual)`, then pipe into a matcher. */
@module("vitest") external expect: 'a => assertion<'a, sync> = "expect"

/** Non-fatal assertion in `sync` mode, collects failures and continues:
    `expect.soft(actual)`, then pipe into any matcher. */
@module("vitest") @scope("expect") external expectSoft: 'a => assertion<'a, sync> = "soft"

/** Asserts that exactly `n` assertions run in the current test:
    `expect.assertions(n)`. */
@module("vitest") @scope("expect") external expectAssertions: int => unit = "assertions"

/** Asserts that at least one assertion runs: `expect.hasAssertions()`. */
@module("vitest") @scope("expect") external expectHasAssertions: unit => unit = "hasAssertions"

/** Negates the matcher: `expect(x)->not->toBe(y)`. Mode-preserving, so it
    works in both sync and async chains. */
@get external not: assertion<'a, 'mode> => assertion<'a, 'mode> = "not"

/** Unwraps a promise and switches to `async` mode:
    `await expect(promise)->resolves->toBeAsync(value)`. Only `*Async`
    matchers apply afterwards, and they must be awaited. */
@get external resolves: assertion<promise<'a>, sync> => assertion<'a, async> = "resolves"

/** Unwraps a rejected promise and switches to `async` mode:
    `await expect(promise)->rejects->toThrowWithAsync(msg)`. Only `*Async`
    matchers apply afterwards, and they must be awaited. */
@get external rejects: assertion<promise<'a>, sync> => assertion<unknown, async> = "rejects"

/** Asymmetric matcher matching anything but null/undefined:
    `expect.anything()`, for use inside `toEqual`/`toEqualUnknown`. */
@module("vitest") @scope("expect") external expectAnything: unit => unknown = "anything"

/** Asymmetric matcher matching any value from a constructor, e.g.
    `expectAny(Error)`: `expect.any(constructor)`. */
@module("vitest") @scope("expect") external expectAny: 'a => unknown = "any"

/** Asymmetric subset matcher: `expect.objectContaining({...})`. */
@module("vitest") @scope("expect") external expectObjectContaining: 'a => unknown = "objectContaining"

/** Asymmetric array subset matcher: `expect.arrayContaining([...])`. */
@module("vitest") @scope("expect") external expectArrayContaining: array<'a> => unknown = "arrayContaining"

/** Asymmetric substring matcher: `expect.stringContaining(sub)`. */
@module("vitest") @scope("expect") external expectStringContaining: string => unknown = "stringContaining"

/** Asymmetric string/pattern matcher: `expect.stringMatching(string)`. */
@module("vitest") @scope("expect")
external expectStringMatchingString: string => unknown = "stringMatching"

/** Asymmetric regex matcher: `expect.stringMatching(/re/)`. */
@module("vitest") @scope("expect") external expectStringMatchingRegex: RegExp.t => unknown = "stringMatching"

/** Asymmetric number matcher with default precision:
    `expect.closeTo(expected)`. */
@module("vitest") @scope("expect") external expectCloseTo: float => unknown = "closeTo"

/** Asymmetric number matcher: `expect.closeTo(expected, precision)`. */
@module("vitest") @scope("expect") external expectCloseToPrecise: (float, int) => unknown = "closeTo"

/* ------------------------------------------------------------------ */
/* Matchers (Jest-compatible)                                          */
/* ------------------------------------------------------------------ */

/** `Object.is` equality: `expect(x)->toBe(y)`. */
@send external toBe: (assertion<'a, sync>, 'a) => unit = "toBe"

/** Async `toBe` for `resolves` chains, must be awaited. */
@send external toBeAsync: (assertion<'a, async>, 'a) => promise<unit> = "toBe"

/** Recursive structural equality: `expect(x)->toEqual(y)`. */
@send external toEqual: (assertion<'a, sync>, 'a) => unit = "toEqual"

/** Async `toEqual` for `resolves` chains, must be awaited. */
@send external toEqualAsync: (assertion<'a, async>, 'a) => promise<unit> = "toEqual"

/** `toEqual` accepting an `unknown` expected value, e.g. asymmetric
    matchers from `expectObjectContaining`: `expect(x)->toEqualUnknown(m)`. */
@send external toEqualUnknown: (assertion<'a, sync>, unknown) => unit = "toEqual"

/** Strict structural equality incl. types: `expect(x)->toStrictEqual(y)`. */
@send external toStrictEqual: (assertion<'a, sync>, 'a) => unit = "toStrictEqual"

/** String substring or regex match: `expect(s)->toMatchString(sub)`. */
@send external toMatchString: (assertion<string, sync>, string) => unit = "toMatch"

/** Regex match: `expect(s)->toMatchRegex(%re("/^h/"))`. */
@send external toMatchRegex: (assertion<string, sync>, RegExp.t) => unit = "toMatch"

/** Object subset match: `expect(obj)->toMatchObject(subset)`. */
@send external toMatchObject: (assertion<'a, sync>, 'b) => unit = "toMatchObject"

/** Strict-equality membership: `expect(arr)->toContain(item)`. */
@send external toContain: (assertion<array<'a>, sync>, 'a) => unit = "toContain"

/** Structural-equality membership: `expect(arr)->toContainEqual(item)`. */
@send external toContainEqual: (assertion<array<'a>, sync>, 'a) => unit = "toContainEqual"

/** Truthiness: `expect(x)->toBeTruthy`. */
@send external toBeTruthy: assertion<'a, sync> => unit = "toBeTruthy"

/** Falsiness: `expect(x)->toBeFalsy`. */
@send external toBeFalsy: assertion<'a, sync> => unit = "toBeFalsy"

/** Numeric comparison: `expect(n)->toBeGreaterThan(m)`. */
@send external toBeGreaterThan: (assertion<'a, sync>, 'a) => unit = "toBeGreaterThan"

/** Numeric comparison: `expect(n)->toBeGreaterThanOrEqual(m)`. */
@send external toBeGreaterThanOrEqual: (assertion<'a, sync>, 'a) => unit = "toBeGreaterThanOrEqual"

/** Numeric comparison: `expect(n)->toBeLessThan(m)`. */
@send external toBeLessThan: (assertion<'a, sync>, 'a) => unit = "toBeLessThan"

/** Numeric comparison: `expect(n)->toBeLessThanOrEqual(m)`. */
@send external toBeLessThanOrEqual: (assertion<'a, sync>, 'a) => unit = "toBeLessThanOrEqual"

/** NaN check: `expect(Math.acos(2.0))->toBeNaN`. */
@send external toBeNaN: assertion<'a, sync> => unit = "toBeNaN"

/** Undefined check: `expect(None)->toBeUndefined`. */
@send external toBeUndefined: assertion<'a, sync> => unit = "toBeUndefined"

/** Null check: `expect(Nullable.null)->toBeNull`. */
@send external toBeNull: assertion<'a, sync> => unit = "toBeNull"

/** Null-or-undefined check: `expect(x)->toBeNullable`. */
@send external toBeNullable: assertion<'a, sync> => unit = "toBeNullable"

/** Defined check: `expect(x)->toBeDefined`. */
@send external toBeDefined: assertion<'a, sync> => unit = "toBeDefined"

/** `instanceof` check: `expect(err)->toBeInstanceOf(Error)`. */
@send external toBeInstanceOf: (assertion<'a, sync>, 'b) => unit = "toBeInstanceOf"

/** `.length` check: `expect(arr)->toHaveLength(n)`. */
@send external toHaveLength: (assertion<'a, sync>, int) => unit = "toHaveLength"

/** Property existence by dot path: `expect(obj)->toHaveProperty("a.b")`. */
@send external toHaveProperty: (assertion<'a, sync>, string) => unit = "toHaveProperty"

/** Property value by dot path: `expect(obj)->toHavePropertyWith("a.b", v)`. */
@send external toHavePropertyWith: (assertion<'a, sync>, string, 'b) => unit = "toHaveProperty"

/** Float comparison, default 2 digits: `expect(0.1 +. 0.2)->toBeCloseTo(0.3)`. */
@send external toBeCloseTo: (assertion<float, sync>, float) => unit = "toBeCloseTo"

/** Float comparison: `expect(f)->toBeCloseToWithDigits(f2, digits)`. */
@send external toBeCloseToWithDigits: (assertion<float, sync>, float, int) => unit = "toBeCloseTo"

/** Throw check on a function: `expect(() => raise(...))->toThrow`.
    Only accepts `expect` of a function, so asserting a plain value fails to compile. */
@send external toThrow: assertion<unit => 'r, sync> => unit = "toThrow"

/** Throw check with message/constructor: `expect(fn)->toThrowWith("boom")`.
    Only accepts `expect` of a function. */
@send external toThrowWith: (assertion<unit => 'r, sync>, 'b) => unit = "toThrow"

/** Async `toThrow` for `rejects` chains, must be awaited. */
@send external toThrowWithAsync: (assertion<'a, async>, 'b) => promise<unit> = "toThrow"

/** Snapshot check, writes a `.snap` file under `__snapshots__` on first run:
    `expect(x)->toMatchSnapshot`. */
@send external toMatchSnapshot: assertion<'a, sync> => unit = "toMatchSnapshot"

/** Runtime `typeof` check: `expect("hi")->toBeTypeOf(#string)`.
    Only the eight valid `typeof` results are expressible. */
@send external toBeTypeOf: (assertion<'a, sync>, [#bigint | #boolean | #function | #number | #object | #string | #symbol | #undefined]) => unit = "toBeTypeOf"

/** Custom predicate check: `expect(n)->toSatisfy(n => n > 3)`. */
@send external toSatisfy: (assertion<'a, sync>, 'a => bool) => unit = "toSatisfy"

/** Membership in a list/set: `expect(n)->toBeOneOf([1, 2, 3])`. */
@send external toBeOneOf: (assertion<'a, sync>, array<'a>) => unit = "toBeOneOf"

/* Mock matchers: `expect(mock)->...`. They only accept `expect` of a
   `Vi.mock`, and arg/return values are checked against the mock's function
   type, so e.g. `expect(42)->toHaveBeenCalled` fails to compile. */

/** Mock was called at least once: `expect(m)->toHaveBeenCalled`. */
@send external toHaveBeenCalled: assertion<Vi.mock<'fn>, sync> => unit = "toHaveBeenCalled"

/** Mock call count: `expect(m)->toHaveBeenCalledTimes(n)`. */
@send external toHaveBeenCalledTimes: (assertion<Vi.mock<'fn>, sync>, int) => unit = "toHaveBeenCalledTimes"

/** Mock called with one arg: `expect(m)->toHaveBeenCalledWith(arg)`. */
@send external toHaveBeenCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenCalledWith"

/** Mock called with two args: `expect(m)->toHaveBeenCalledWith2(a, b)`. */
@send external toHaveBeenCalledWith2: (assertion<Vi.mock<('a, 'b) => 'c>, sync>, 'a, 'b) => unit = "toHaveBeenCalledWith"

/** Nth call args (1-based): `expect(m)->toHaveBeenNthCalledWith(n, arg)`. */
@send external toHaveBeenNthCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, int, 'a) => unit = "toHaveBeenNthCalledWith"

/** Last call args: `expect(m)->toHaveBeenLastCalledWith(arg)`. */
@send external toHaveBeenLastCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenLastCalledWith"

/** Mock returned without throwing at least once: `expect(m)->toHaveReturned`. */
@send external toHaveReturned: assertion<Vi.mock<'fn>, sync> => unit = "toHaveReturned"

/** Successful return count: `expect(m)->toHaveReturnedTimes(n)`. */
@send external toHaveReturnedTimes: (assertion<Vi.mock<'fn>, sync>, int) => unit = "toHaveReturnedTimes"

/** Returned value: `expect(m)->toHaveReturnedWith(v)`. */
@send external toHaveReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveReturnedWith"

/** Nth return value: `expect(m)->toHaveNthReturnedWith(n, v)`. */
@send external toHaveNthReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, int, 'b) => unit = "toHaveNthReturnedWith"

/** Last return value: `expect(m)->toHaveLastReturnedWith(v)`. */
@send external toHaveLastReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveLastReturnedWith"

/** Mock called exactly once: `expect(m)->toHaveBeenCalledOnce`. */
@send external toHaveBeenCalledOnce: assertion<Vi.mock<'fn>, sync> => unit = "toHaveBeenCalledOnce"

/** Call ordering: `expect(m1)->toHaveBeenCalledBefore(m2)`. */
@send external toHaveBeenCalledBefore: (assertion<Vi.mock<'f>, sync>, Vi.mock<'g>) => unit = "toHaveBeenCalledBefore"

/** Call ordering: `expect(m1)->toHaveBeenCalledAfter(m2)`. */
@send external toHaveBeenCalledAfter: (assertion<Vi.mock<'f>, sync>, Vi.mock<'g>) => unit = "toHaveBeenCalledAfter"

/** At least one async mock call resolved. Must be awaited. */
@send external toHaveResolved: assertion<Vi.mock<'fn>, sync> => promise<unit> = "toHaveResolved"

/** An async mock call resolved with a value. Must be awaited. */
@send external toHaveResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveResolvedWith"

/** Resolved-call count. Must be awaited. */
@send external toHaveResolvedTimes: (assertion<Vi.mock<'fn>, sync>, int) => promise<unit> = "toHaveResolvedTimes"

/** Last resolved value. Must be awaited. */
@send external toHaveLastResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveLastResolvedWith"

/** Nth resolved value. Must be awaited. */
@send external toHaveNthResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, int, 'b) => promise<unit> = "toHaveNthResolvedWith"

/* ------------------------------------------------------------------ */
/* Assert (chai)                                                       */
/* https://vitest.dev/api/assert                                        */
/* ------------------------------------------------------------------ */

/** `assert.*` helpers (`import { assert } from "vitest"`). */
module Assert = {
  /** Truthiness: `assert.ok(value)`. */
  @module("vitest") @scope("assert") external ok: 'a => unit = "ok"

  /** Loose equality: `assert.equal(a, b)`. */
  @module("vitest") @scope("assert") external equal: ('a, 'b) => unit = "equal"

  /** Strict equality: `assert.strictEqual(a, b)`. */
  @module("vitest") @scope("assert") external strictEqual: ('a, 'b) => unit = "strictEqual"

  /** Structural equality: `assert.deepEqual(a, b)`. */
  @module("vitest") @scope("assert") external deepEqual: ('a, 'b) => unit = "deepEqual"

  /** `assert.isTrue(value)`. */
  @module("vitest") @scope("assert") external isTrue: 'a => unit = "isTrue"

  /** `assert.isFalse(value)`. */
  @module("vitest") @scope("assert") external isFalse: 'a => unit = "isFalse"

  /** `assert.isNull(value)`. */
  @module("vitest") @scope("assert") external isNull: 'a => unit = "isNull"

  /** `assert.isUndefined(value)`. */
  @module("vitest") @scope("assert") external isUndefined: 'a => unit = "isUndefined"

  /** Throw check: `assert.throws(() => {...})`. */
  @module("vitest") @scope("assert") external throws: (unit => 'a) => unit = "throws"
}
