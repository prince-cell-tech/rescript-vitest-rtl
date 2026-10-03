/* Unified assertion entry point: every `expect` matcher in one namespace.
 *
 * Docs: https://vitest.dev/api/expect,
 *   https://github.com/testing-library/jest-dom
 *
 * Re-declares (zero-cost, same attributes and JS payloads):
 * - `Vitest`'s `expect` machinery, asymmetric helpers, core `toX` matchers,
 *   mock matchers, and the `Assert` submodule.
 * - All `JestDom` matchers, same overload convention (`toHaveX`,
 *   `toHaveXRegex`, `toHaveXWith`, `toHaveNoX`).
 *
 * Use this instead of `Vitest.expect` / `JestDom.*` so `Expect.` completes
 * with the full matcher list (including docs) in the editor, e.g.
 *   Expect.expect(el)->Expect.toBeInTheDocument
 *
 * `Vitest` (runner: describe/test/hooks/Vi) and `JestDom` keep working;
 * `App_test.res` uses this module. When adding a matcher upstream, add it
 * here too — see `src/bindings/README.md`. Regenerate with
 * `python3 scripts/gen_expect.py` (never hand-edit the re-declared blocks).
 */

/** Same handle as `Vitest.assertion`: aliases (not new types), so `Expect`
    values interoperate with anything typed as `Vitest.assertion`. */
type sync = Vitest.sync

type async = Vitest.async

type assertion<'value, 'mode> = Vitest.assertion<'value, 'mode>

/* ------------------------------------------------------------------ */
/* Expect                                                              */
/* https://vitest.dev/api/expect                                        */
/* ------------------------------------------------------------------ */


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
   `Vitest.Vi.mock`, and arg/return values are checked against the mock's function
   type, so e.g. `expect(42)->toHaveBeenCalled` fails to compile. */

/** Mock was called at least once: `expect(m)->toHaveBeenCalled`. */
@send external toHaveBeenCalled: assertion<Vitest.Vi.mock<'fn>, sync> => unit = "toHaveBeenCalled"

/** Mock call count: `expect(m)->toHaveBeenCalledTimes(n)`. */
@send external toHaveBeenCalledTimes: (assertion<Vitest.Vi.mock<'fn>, sync>, int) => unit = "toHaveBeenCalledTimes"

/** Mock called with one arg: `expect(m)->toHaveBeenCalledWith(arg)`. */
@send external toHaveBeenCalledWith: (assertion<Vitest.Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenCalledWith"

/** Mock called with two args: `expect(m)->toHaveBeenCalledWith2(a, b)`. */
@send external toHaveBeenCalledWith2: (assertion<Vitest.Vi.mock<('a, 'b) => 'c>, sync>, 'a, 'b) => unit = "toHaveBeenCalledWith"

/** Nth call args (1-based): `expect(m)->toHaveBeenNthCalledWith(n, arg)`. */
@send external toHaveBeenNthCalledWith: (assertion<Vitest.Vi.mock<'a => 'b>, sync>, int, 'a) => unit = "toHaveBeenNthCalledWith"

/** Last call args: `expect(m)->toHaveBeenLastCalledWith(arg)`. */
@send external toHaveBeenLastCalledWith: (assertion<Vitest.Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenLastCalledWith"

/** Mock returned without throwing at least once: `expect(m)->toHaveReturned`. */
@send external toHaveReturned: assertion<Vitest.Vi.mock<'fn>, sync> => unit = "toHaveReturned"

/** Successful return count: `expect(m)->toHaveReturnedTimes(n)`. */
@send external toHaveReturnedTimes: (assertion<Vitest.Vi.mock<'fn>, sync>, int) => unit = "toHaveReturnedTimes"

/** Returned value: `expect(m)->toHaveReturnedWith(v)`. */
@send external toHaveReturnedWith: (assertion<Vitest.Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveReturnedWith"

/** Nth return value: `expect(m)->toHaveNthReturnedWith(n, v)`. */
@send external toHaveNthReturnedWith: (assertion<Vitest.Vi.mock<'args => 'b>, sync>, int, 'b) => unit = "toHaveNthReturnedWith"

/** Last return value: `expect(m)->toHaveLastReturnedWith(v)`. */
@send external toHaveLastReturnedWith: (assertion<Vitest.Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveLastReturnedWith"

/** Mock called exactly once: `expect(m)->toHaveBeenCalledOnce`. */
@send external toHaveBeenCalledOnce: assertion<Vitest.Vi.mock<'fn>, sync> => unit = "toHaveBeenCalledOnce"

/** Call ordering: `expect(m1)->toHaveBeenCalledBefore(m2)`. */
@send external toHaveBeenCalledBefore: (assertion<Vitest.Vi.mock<'f>, sync>, Vitest.Vi.mock<'g>) => unit = "toHaveBeenCalledBefore"

/** Call ordering: `expect(m1)->toHaveBeenCalledAfter(m2)`. */
@send external toHaveBeenCalledAfter: (assertion<Vitest.Vi.mock<'f>, sync>, Vitest.Vi.mock<'g>) => unit = "toHaveBeenCalledAfter"

/** At least one async mock call resolved. Must be awaited. */
@send external toHaveResolved: assertion<Vitest.Vi.mock<'fn>, sync> => promise<unit> = "toHaveResolved"

/** An async mock call resolved with a value. Must be awaited. */
@send external toHaveResolvedWith: (assertion<Vitest.Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveResolvedWith"

/** Resolved-call count. Must be awaited. */
@send external toHaveResolvedTimes: (assertion<Vitest.Vi.mock<'fn>, sync>, int) => promise<unit> = "toHaveResolvedTimes"

/** Last resolved value. Must be awaited. */
@send external toHaveLastResolvedWith: (assertion<Vitest.Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveLastResolvedWith"

/** Nth resolved value. Must be awaited. */
@send external toHaveNthResolvedWith: (assertion<Vitest.Vi.mock<'args => promise<'b>>, sync>, int, 'b) => promise<unit> = "toHaveNthResolvedWith"

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

/* ------------------------------------------------------------------ */
/* jest-dom matchers (re-declared from JestDom, same JS payloads)         */
/* ------------------------------------------------------------------ */

/** Options for exact class matching: `toHaveClass("a b", {exact: true})`. */
type exactOptions = {
  exact: bool,
}

/** Options for text-content matching: whitespace normalization. */
type textContentOptions = {
  normalizeWhitespace?: bool,
}

/** Asserts element presence in the document body:
    `expect(el)->toBeInTheDocument`. */
@send external toBeInTheDocument: assertion<'a, sync> => unit = "toBeInTheDocument"

/** Asserts element visibility: `expect(el)->toBeVisible`. */
@send external toBeVisible: assertion<'a, sync> => unit = "toBeVisible"

/** @deprecated since v1.9.0, use `toBeInTheDocument`. */
@send external toBeInTheDOM: assertion<'a, sync> => unit = "toBeInTheDOM"

/** @deprecated since v5.9.0, use `toBeEmptyDOMElement`. */
@send external toBeEmpty: assertion<'a, sync> => unit = "toBeEmpty"

/** Asserts an element has no content: `expect(el)->toBeEmptyDOMElement`. */
@send external toBeEmptyDOMElement: assertion<'a, sync> => unit =
  "toBeEmptyDOMElement"

/** Asserts the element is disabled: `expect(el)->toBeDisabled`. */
@send external toBeDisabled: assertion<'a, sync> => unit = "toBeDisabled"

/** Asserts the element is enabled: `expect(el)->toBeEnabled`. */
@send external toBeEnabled: assertion<'a, sync> => unit = "toBeEnabled"

/** Asserts a form element is invalid: `expect(form)->toBeInvalid`. */
@send external toBeInvalid: assertion<'a, sync> => unit = "toBeInvalid"

/** Asserts a form element is required: `expect(input)->toBeRequired`. */
@send external toBeRequired: assertion<'a, sync> => unit = "toBeRequired"

/** Asserts a form element is valid: `expect(form)->toBeValid`. */
@send external toBeValid: assertion<'a, sync> => unit = "toBeValid"

/** Asserts a checkbox/radio is checked: `expect(input)->toBeChecked`. */
@send external toBeChecked: assertion<'a, sync> => unit = "toBeChecked"

/** Asserts a checkbox is partially checked (`aria-checked="mixed"`). */
@send external toBePartiallyChecked: assertion<'a, sync> => unit =
  "toBePartiallyChecked"

/** Asserts a button is pressed (`aria-pressed="true"`). */
@send external toBePressed: assertion<'a, sync> => unit = "toBePressed"

/** Asserts a button is partially pressed (`aria-pressed="mixed"`). */
@send external toBePartiallyPressed: assertion<'a, sync> => unit =
  "toBePartiallyPressed"

/** Asserts an element has focus: `expect(input)->toHaveFocus`. */
@send external toHaveFocus: assertion<'a, sync> => unit = "toHaveFocus"

/** Asserts exact text content: `expect(el)->toHaveTextContent("hi")`. */
@send external toHaveTextContent: (assertion<'a, sync>, string) => unit = "toHaveTextContent"

/** Asserts text content by pattern: `expect(el)->toHaveTextContentRegex(%re("/^hi/"))`. */
@send external toHaveTextContentRegex: (assertion<'a, sync>, RegExp.t) => unit = "toHaveTextContent"

/** Asserts text content with whitespace options. */
@send external toHaveTextContentWith: (
  assertion<'a, sync>,
  string,
  textContentOptions,
) => unit = "toHaveTextContent"

/** Asserts text-content pattern with whitespace options. */
@send external toHaveTextContentRegexWith: (
  assertion<'a, sync>,
  RegExp.t,
  textContentOptions,
) => unit = "toHaveTextContent"

/** Asserts an input's value: `expect(input)->toHaveValue("typed")`. */
@send external toHaveValue: (assertion<'a, sync>, string) => unit = "toHaveValue"

/** Asserts a numeric input's value: `expect(input)->toHaveValueInt(5)`. */
@send external toHaveValueInt: (assertion<'a, sync>, int) => unit = "toHaveValue"

/** Asserts a numeric input's float value. */
@send external toHaveValueFloat: (assertion<'a, sync>, float) => unit = "toHaveValue"

/** Asserts a multi-select's values: `expect(sel)->toHaveValues(["a", "b"])`. */
@send external toHaveValues: (assertion<'a, sync>, array<string>) => unit =
  "toHaveValue"

/** Asserts an empty/null value: `expect(input)->toHaveValueNullable(Nullable.null)`. */
@send external toHaveValueNullable: (assertion<'a, sync>, Nullable.t<string>) => unit =
  "toHaveValue"

/** Asserts a form element's displayed value: `expect(input)->toHaveDisplayValue("Luca")`. */
@send external toHaveDisplayValue: (assertion<'a, sync>, string) => unit =
  "toHaveDisplayValue"

/** Asserts a form element's displayed value by pattern. */
@send external toHaveDisplayValueRegex: (assertion<'a, sync>, RegExp.t) => unit =
  "toHaveDisplayValue"

/** Asserts a multi-select's displayed values. */
@send external toHaveDisplayValues: (assertion<'a, sync>, array<string>) => unit =
  "toHaveDisplayValue"

/** Asserts a CSS class is present: `expect(el)->toHaveClass("active")`.
    Space-separated strings match several classes. */
@send external toHaveClass: (assertion<'a, sync>, string) => unit = "toHaveClass"

/** Asserts a CSS class pattern is present. */
@send external toHaveClassRegex: (assertion<'a, sync>, RegExp.t) => unit =
  "toHaveClass"

/** Asserts exact class membership: `expect(el)->toHaveClassExact("a b", {exact: true})`. */
@send external toHaveClassExact: (assertion<'a, sync>, string, exactOptions) => unit =
  "toHaveClass"

/** Asserts an attribute is present: `expect(btn)->toHaveAttribute("disabled")`. */
@send external toHaveAttribute: (assertion<'a, sync>, string) => unit =
  "toHaveAttribute"

/** Asserts an attribute value: `expect(btn)->toHaveAttributeWith("type", "submit")`.
    The value is generic so strings, regexes, and asymmetric matchers all type-check. */
@send external toHaveAttributeWith: (assertion<'a, sync>, string, 'b) => unit =
  "toHaveAttribute"

/** Asserts an element contains another: `expect(parent)->toContainElement(child)`. */
@send external toContainElement: (assertion<'a, sync>, Dom.element) => unit =
  "toContainElement"

/** Asserts serialized HTML containment: `expect(el)->toContainHTML("<span />")`. */
@send external toContainHTML: (assertion<'a, sync>, string) => unit = "toContainHTML"

/** Asserts form values: `expect(form)->toHaveFormValues({"username": "jane"})`. */
@send external toHaveFormValues: (assertion<'a, sync>, {..}) => unit =
  "toHaveFormValues"

/** Asserts CSS declarations: `expect(el)->toHaveStyle("color: red")`. */
@send external toHaveStyle: (assertion<'a, sync>, string) => unit = "toHaveStyle"

/** Asserts CSS declarations as an object: `expect(el)->toHaveStyleObject({"color": "red"})`. */
@send external toHaveStyleObject: (assertion<'a, sync>, {..}) => unit = "toHaveStyle"

/** Asserts implicit/explicit ARIA role: `expect(btn)->toHaveRole("button")`. */
@send external toHaveRole: (assertion<'a, sync>, string) => unit = "toHaveRole"

/** Asserts text selection: `expect(input)->toHaveSelectionWith("selected")`. */
@send external toHaveSelectionWith: (assertion<'a, sync>, string) => unit =
  "toHaveSelection"

/** Asserts an element has no text selection. */
@send external toHaveNoSelection: assertion<'a, sync> => unit = "toHaveSelection"

/** @deprecated, use `toHaveAccessibleDescription`. */
@send external toHaveDescription: (assertion<'a, sync>, string) => unit =
  "toHaveDescription"

/** @deprecated regex form of `toHaveDescription`. */
@send external toHaveDescriptionRegex: (assertion<'a, sync>, RegExp.t) => unit =
  "toHaveDescription"

/** @deprecated absence form: `expect(el)->Vitest.not->toHaveNoDescription`. */
@send external toHaveNoDescription: assertion<'a, sync> => unit = "toHaveDescription"

/** Asserts presence of an accessible description. */
@send external toHaveAccessibleDescription: assertion<'a, sync> => unit =
  "toHaveAccessibleDescription"

/** Asserts an accessible description value. */
@send external toHaveAccessibleDescriptionWith: (assertion<'a, sync>, string) => unit =
  "toHaveAccessibleDescription"

/** Asserts an accessible description pattern. */
@send external toHaveAccessibleDescriptionRegex: (
  assertion<'a, sync>,
  RegExp.t,
) => unit = "toHaveAccessibleDescription"

/** Asserts presence of an accessible error message. */
@send external toHaveAccessibleErrorMessage: assertion<'a, sync> => unit =
  "toHaveAccessibleErrorMessage"

/** Asserts an accessible error message value. */
@send external toHaveAccessibleErrorMessageWith: (
  assertion<'a, sync>,
  string,
) => unit = "toHaveAccessibleErrorMessage"

/** Asserts an accessible error-message pattern. */
@send external toHaveAccessibleErrorMessageRegex: (
  assertion<'a, sync>,
  RegExp.t,
) => unit = "toHaveAccessibleErrorMessage"

/** Asserts presence of an accessible name. */
@send external toHaveAccessibleName: assertion<'a, sync> => unit =
  "toHaveAccessibleName"

/** Asserts an accessible name value: `expect(input)->toHaveAccessibleNameWith("Name")`. */
@send external toHaveAccessibleNameWith: (assertion<'a, sync>, string) => unit =
  "toHaveAccessibleName"

/** Asserts an accessible-name pattern. */
@send external toHaveAccessibleNameRegex: (assertion<'a, sync>, RegExp.t) => unit =
  "toHaveAccessibleName"

/** @deprecated since v5.17.0, use `toHaveAccessibleErrorMessage`. */
@send external toHaveErrorMessage: (assertion<'a, sync>, string) => unit =
  "toHaveErrorMessage"

/** @deprecated regex form of `toHaveErrorMessage`. */
@send external toHaveErrorMessageRegex: (assertion<'a, sync>, RegExp.t) => unit =
  "toHaveErrorMessage"

/** Asserts DOM order: `expect(a)->toAppearBefore(b)`. */
@send external toAppearBefore: (assertion<'a, sync>, Dom.element) => unit =
  "toAppearBefore"

/** Asserts DOM order: `expect(b)->toAppearAfter(a)`. */
@send external toAppearAfter: (assertion<'a, sync>, Dom.element) => unit =
  "toAppearAfter"

/** Asserts an element contains a descendant by alt text. */
@send external toContainAnyByAltText: (assertion<'a, sync>, string) => unit =
  "toContainAnyByAltText"

/** Asserts an element contains exactly one descendant by alt text. */
@send external toContainOneByAltText: (assertion<'a, sync>, string) => unit =
  "toContainOneByAltText"

/** Asserts an element contains a descendant by display value. */
@send external toContainAnyByDisplayValue: (assertion<'a, sync>, string) => unit =
  "toContainAnyByDisplayValue"

/** Asserts an element contains exactly one descendant by display value. */
@send external toContainOneByDisplayValue: (assertion<'a, sync>, string) => unit =
  "toContainOneByDisplayValue"

/** Asserts an element contains a descendant by label text. */
@send external toContainAnyByLabelText: (assertion<'a, sync>, string) => unit =
  "toContainAnyByLabelText"

/** Asserts an element contains exactly one descendant by label text. */
@send external toContainOneByLabelText: (assertion<'a, sync>, string) => unit =
  "toContainOneByLabelText"

/** Asserts an element contains a descendant by placeholder text. */
@send external toContainAnyByPlaceholderText: (assertion<'a, sync>, string) => unit =
  "toContainAnyByPlaceholderText"

/** Asserts an element contains exactly one descendant by placeholder text. */
@send external toContainOneByPlaceholderText: (
  assertion<'a, sync>,
  string,
) => unit = "toContainOneByPlaceholderText"

/** Asserts an element contains a descendant by role. */
@send external toContainAnyByRole: (assertion<'a, sync>, string) => unit =
  "toContainAnyByRole"

/** Asserts an element contains exactly one descendant by role. */
@send external toContainOneByRole: (assertion<'a, sync>, string) => unit =
  "toContainOneByRole"

/** Asserts an element contains a descendant by test id. */
@send external toContainAnyByTestId: (assertion<'a, sync>, string) => unit =
  "toContainAnyByTestId"

/** Asserts an element contains exactly one descendant by test id. */
@send external toContainOneByTestId: (assertion<'a, sync>, string) => unit =
  "toContainOneByTestId"

/** Asserts an element contains a descendant by text. */
@send external toContainAnyByText: (assertion<'a, sync>, string) => unit =
  "toContainAnyByText"

/** Asserts an element contains exactly one descendant by text. */
@send external toContainOneByText: (assertion<'a, sync>, string) => unit =
  "toContainOneByText"

/** Asserts an element contains a descendant by title. */
@send external toContainAnyByTitle: (assertion<'a, sync>, string) => unit =
  "toContainAnyByTitle"

/** Asserts an element contains exactly one descendant by title. */
@send external toContainOneByTitle: (assertion<'a, sync>, string) => unit =
  "toContainOneByTitle"
