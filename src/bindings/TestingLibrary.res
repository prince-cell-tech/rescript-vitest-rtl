/* Bindings for @testing-library/react 16 (React 19 compatible).
 *
 * Docs: https://testing-library.com/docs/react-testing-library/intro
 *
 * All `external`s inline to zero JS output, e.g.
 *   TestingLibrary.render(<App />)
 * compiles to
 *   import { render } from "@testing-library/react"; render(App.make({}))
 *
 * Coverage (full parity, no new deps — no @testing-library/user-event):
 * - 8 query families: LabelText, PlaceholderText, Text, AltText, Title,
 *   DisplayValue, Role, TestId
 * - 6 variants each: getBy, getAllBy, queryBy (->option), queryAllBy,
 *   findBy (->promise), findAllBy (->promise<array>)
 * - Each variant has string, Regex, and With (typed options) forms, e.g.
 *   `getByText`, `getByTextRegex`, `getByTextWith(text, opts)`.
 * - `findBy*WithWait` additionally takes `waitForOptions` (timeout/interval).
 * - `fireEvent` for the common event set; `*With` forms take `{..}` init.
 * - `within`, `waitFor`/`waitForWith`, `waitForElementToBeRemoved`,
 *   `configure`, `debug`, `cleanup`.
 *
 * Usage notes:
 * - Tests run under jsdom (see `environment` in vite.config.mjs).
 * - This project imports from "vitest" explicitly (no globals), so the
 *   automatic cleanup does not apply: call `cleanup` in an `afterEach`,
 *   e.g. `Vitest.afterEach(TestingLibrary.cleanup)`.
 * - `getBy*` queries throw when nothing matches; `queryBy*` return
 *   `option<Dom.element>` so a missing element is unrepresentable as a
 *   plain element; `queryAllBy*`/`getAllBy*` return arrays.
 * - `findBy*`/`findAllBy*` retry until timeout and return promises; use
 *   `Vitest.testAsync` with `await`.
 * - Typed options cover the common fields. Omitted upstream fields:
 *   - `ignore` only as string (upstream also allows bool).
 *   - `ByRoleOptions.value` (now/min/max/text object) omitted.
 *   - `name`/`description` as predicate functions omitted (use string/RegExp).
 *   - `waitForOptions` only timeout/interval (upstream also has
 *     container/onTimeout/mutationObserverOptions).
 */

/** Opaque result of `render`, for `unmount` / `rerender` / `container`. */
type renderResult

/** Renders an element into a detached DOM container:
    `render(<App />)`. */
@module("@testing-library/react") external render: React.element => renderResult = "render"

/** Unmounts a rendered tree: `result->unmount`. */
@send external unmount: renderResult => unit = "unmount"

/** Re-renders with a new element: `result->rerender(<App />)`. */
@send external rerender: (renderResult, React.element) => unit = "rerender"

/** The container the element was rendered into. */
@get external container: renderResult => Dom.element = "container"

/* ------------------------------------------------------------------ */
/* Options                                                             */
/* ------------------------------------------------------------------ */

/** Common matcher options (exact/trim/collapseWhitespace/suggest). */
type matcherOptions = {
  exact?: bool,
  trim?: bool,
  collapseWhitespace?: bool,
  suggest?: bool,
}

/** Text matcher options: matcher options plus CSS scope and ignore set.
    `ignore` is typed as string (e.g. `"script, style"`); the rare
    boolean form is omitted. */
type textOptions = {
  exact?: bool,
  trim?: bool,
  collapseWhitespace?: bool,
  suggest?: bool,
  selector?: string,
  ignore?: string,
}

/** Role query options with string accessible name/description. */
type roleOptions = {
  hidden?: bool,
  selected?: bool,
  busy?: bool,
  checked?: bool,
  pressed?: bool,
  expanded?: bool,
  suggest?: bool,
  queryFallbacks?: bool,
  level?: int,
  name?: string,
  description?: string,
}

/** Role query options with regex accessible name/description. */
type roleOptionsRegex = {
  hidden?: bool,
  selected?: bool,
  busy?: bool,
  checked?: bool,
  pressed?: bool,
  expanded?: bool,
  suggest?: bool,
  queryFallbacks?: bool,
  level?: int,
  name?: RegExp.t,
  description?: RegExp.t,
}

/** Retry options for `findBy*` and `waitFor`. */
type waitForOptions = {
  timeout?: int,
  interval?: int,
}

/* ------------------------------------------------------------------ */
/* Queries: LabelText (uses textOptions)                               */
/* ------------------------------------------------------------------ */

/** Finds one element by label text, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByLabelText: string => Dom.element = "getByLabelText"

/** Finds one element by label-text pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByLabelTextRegex: RegExp.t => Dom.element = "getByLabelText"

/** Finds one element by label text with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByLabelTextWith: (string, textOptions) => Dom.element = "getByLabelText"

/** Finds all elements by label text, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByLabelText: string => array<Dom.element> = "getAllByLabelText"

/** Finds all elements by label-text pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByLabelTextRegex: RegExp.t => array<Dom.element> = "getAllByLabelText"

/** Finds all elements by label text with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByLabelTextWith: (string, textOptions) => array<Dom.element> = "getAllByLabelText"

@module("@testing-library/react") @scope("screen")
external _queryByLabelText: string => Nullable.t<Dom.element> = "queryByLabelText"
@module("@testing-library/react") @scope("screen")
external _queryByLabelTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByLabelText"
@module("@testing-library/react") @scope("screen")
external _queryByLabelTextWith: (string, textOptions) => Nullable.t<Dom.element> = "queryByLabelText"

/** Finds zero or one elements by label text. Returns `None` when missing. */
let queryByLabelText: string => option<Dom.element> = text =>
  _queryByLabelText(text)->Nullable.toOption

/** Finds zero or one elements by label-text pattern. Returns `None` when missing. */
let queryByLabelTextRegex: RegExp.t => option<Dom.element> = re =>
  _queryByLabelTextRegex(re)->Nullable.toOption

/** Finds zero or one elements by label text with options. Returns `None` when missing. */
let queryByLabelTextWith: (string, textOptions) => option<Dom.element> = (text, opts) =>
  _queryByLabelTextWith(text, opts)->Nullable.toOption

/** Finds all elements by label text. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByLabelText: string => array<Dom.element> = "queryAllByLabelText"

/** Finds all elements by label-text pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByLabelTextRegex: RegExp.t => array<Dom.element> = "queryAllByLabelText"

/** Finds all elements by label text with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByLabelTextWith: (string, textOptions) => array<Dom.element> =
  "queryAllByLabelText"

/** Retries until an element by label text appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByLabelText: string => promise<Dom.element> = "findByLabelText"

/** Retries until an element by label-text pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByLabelTextRegex: RegExp.t => promise<Dom.element> = "findByLabelText"

/** Retries until an element by label text appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByLabelTextWith: (string, textOptions) => promise<Dom.element> = "findByLabelText"

/** Retries until an element by label text appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByLabelTextWithWait: (string, textOptions, waitForOptions) => promise<Dom.element> =
  "findByLabelText"

/** Retries until elements by label text appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByLabelText: string => promise<array<Dom.element>> = "findAllByLabelText"

/** Retries until elements by label-text pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByLabelText"

/** Retries until elements by label text appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextWith: (string, textOptions) => promise<array<Dom.element>> =
  "findAllByLabelText"

/** Retries until elements by label text appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextWithWait: (string, textOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByLabelText"

/* ------------------------------------------------------------------ */
/* Queries: PlaceholderText (uses matcherOptions)                      */
/* ------------------------------------------------------------------ */

/** Finds one input by placeholder text, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByPlaceholderText: string => Dom.element = "getByPlaceholderText"

/** Finds one input by placeholder-text pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByPlaceholderTextRegex: RegExp.t => Dom.element = "getByPlaceholderText"

/** Finds one input by placeholder text with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByPlaceholderTextWith: (string, matcherOptions) => Dom.element =
  "getByPlaceholderText"

/** Finds all inputs by placeholder text, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByPlaceholderText: string => array<Dom.element> = "getAllByPlaceholderText"

/** Finds all inputs by placeholder-text pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByPlaceholderTextRegex: RegExp.t => array<Dom.element> =
  "getAllByPlaceholderText"

/** Finds all inputs by placeholder text with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByPlaceholderTextWith: (string, matcherOptions) => array<Dom.element> =
  "getAllByPlaceholderText"

@module("@testing-library/react") @scope("screen")
external _queryByPlaceholderText: string => Nullable.t<Dom.element> = "queryByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external _queryByPlaceholderTextRegex: RegExp.t => Nullable.t<Dom.element> =
  "queryByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external _queryByPlaceholderTextWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByPlaceholderText"

/** Finds zero or one inputs by placeholder text. Returns `None` when missing. */
let queryByPlaceholderText: string => option<Dom.element> = text =>
  _queryByPlaceholderText(text)->Nullable.toOption

/** Finds zero or one inputs by placeholder-text pattern. Returns `None` when missing. */
let queryByPlaceholderTextRegex: RegExp.t => option<Dom.element> = re =>
  _queryByPlaceholderTextRegex(re)->Nullable.toOption

/** Finds zero or one inputs by placeholder text with options. Returns `None` when missing. */
let queryByPlaceholderTextWith: (string, matcherOptions) => option<Dom.element> = (text, opts) =>
  _queryByPlaceholderTextWith(text, opts)->Nullable.toOption

/** Finds all inputs by placeholder text. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderText: string => array<Dom.element> = "queryAllByPlaceholderText"

/** Finds all inputs by placeholder-text pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderTextRegex: RegExp.t => array<Dom.element> =
  "queryAllByPlaceholderText"

/** Finds all inputs by placeholder text with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderTextWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByPlaceholderText"

/** Retries until an input by placeholder text appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByPlaceholderText: string => promise<Dom.element> = "findByPlaceholderText"

/** Retries until an input by placeholder-text pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextRegex: RegExp.t => promise<Dom.element> = "findByPlaceholderText"

/** Retries until an input by placeholder text appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextWith: (string, matcherOptions) => promise<Dom.element> =
  "findByPlaceholderText"

/** Retries until an input by placeholder text appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextWithWait: (string, matcherOptions, waitForOptions) => promise<
  Dom.element,
> = "findByPlaceholderText"

/** Retries until inputs by placeholder text appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderText: string => promise<array<Dom.element>> =
  "findAllByPlaceholderText"

/** Retries until inputs by placeholder-text pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextRegex: RegExp.t => promise<array<Dom.element>> =
  "findAllByPlaceholderText"

/** Retries until inputs by placeholder text appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByPlaceholderText"

/** Retries until inputs by placeholder text appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextWithWait: (
  string,
  matcherOptions,
  waitForOptions,
) => promise<array<Dom.element>> = "findAllByPlaceholderText"

/* ------------------------------------------------------------------ */
/* Queries: Text (uses textOptions)                                    */
/* ------------------------------------------------------------------ */

/** Finds one element by text, throws when missing: `screen.getByText("hi")`. */
@module("@testing-library/react") @scope("screen")
external getByText: string => Dom.element = "getByText"

/** Finds one element by text pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTextRegex: RegExp.t => Dom.element = "getByText"

/** Finds one element by text with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTextWith: (string, textOptions) => Dom.element = "getByText"

/** Finds all elements matching text, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByText: string => array<Dom.element> = "getAllByText"

/** Finds all elements matching a text pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTextRegex: RegExp.t => array<Dom.element> = "getAllByText"

/** Finds all elements matching text with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTextWith: (string, textOptions) => array<Dom.element> = "getAllByText"

/** Finds zero or one elements by text. Returns `None` when missing
    (RTL returns `null`, converted here so null is unrepresentable). */
@module("@testing-library/react") @scope("screen")
external _queryByText: string => Nullable.t<Dom.element> = "queryByText"

@module("@testing-library/react") @scope("screen")
external _queryByTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByText"

@module("@testing-library/react") @scope("screen")
external _queryByTextWith: (string, textOptions) => Nullable.t<Dom.element> = "queryByText"

/** See `_queryByText`. */
let queryByText: string => option<Dom.element> = text => _queryByText(text)->Nullable.toOption

/** Finds zero or one elements by text pattern. Returns `None` when missing. */
let queryByTextRegex: RegExp.t => option<Dom.element> = re =>
  _queryByTextRegex(re)->Nullable.toOption

/** Finds zero or one elements by text with options. Returns `None` when missing. */
let queryByTextWith: (string, textOptions) => option<Dom.element> = (text, opts) =>
  _queryByTextWith(text, opts)->Nullable.toOption

/** Finds all elements by text. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByText: string => array<Dom.element> = "queryAllByText"

/** Finds all elements by text pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTextRegex: RegExp.t => array<Dom.element> = "queryAllByText"

/** Finds all elements by text with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTextWith: (string, textOptions) => array<Dom.element> = "queryAllByText"

/** Retries until an element by text appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByText: string => promise<Dom.element> = "findByText"

/** Retries until an element by text pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTextRegex: RegExp.t => promise<Dom.element> = "findByText"

/** Retries until an element by text appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTextWith: (string, textOptions) => promise<Dom.element> = "findByText"

/** Retries until an element by text appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByTextWithWait: (string, textOptions, waitForOptions) => promise<Dom.element> =
  "findByText"

/** Retries until elements by text appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByText: string => promise<array<Dom.element>> = "findAllByText"

/** Retries until elements by text pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByText"

/** Retries until elements by text appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTextWith: (string, textOptions) => promise<array<Dom.element>> =
  "findAllByText"

/** Retries until elements by text appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByTextWithWait: (string, textOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByText"

/* ------------------------------------------------------------------ */
/* Queries: AltText (uses matcherOptions)                              */
/* ------------------------------------------------------------------ */

/** Finds one image by alt text, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByAltText: string => Dom.element = "getByAltText"

/** Finds one image by alt-text pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByAltTextRegex: RegExp.t => Dom.element = "getByAltText"

/** Finds one image by alt text with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByAltTextWith: (string, matcherOptions) => Dom.element = "getByAltText"

/** Finds all images by alt text, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByAltText: string => array<Dom.element> = "getAllByAltText"

/** Finds all images by alt-text pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByAltTextRegex: RegExp.t => array<Dom.element> = "getAllByAltText"

/** Finds all images by alt text with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByAltTextWith: (string, matcherOptions) => array<Dom.element> = "getAllByAltText"

@module("@testing-library/react") @scope("screen")
external _queryByAltText: string => Nullable.t<Dom.element> = "queryByAltText"
@module("@testing-library/react") @scope("screen")
external _queryByAltTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByAltText"
@module("@testing-library/react") @scope("screen")
external _queryByAltTextWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByAltText"

/** Finds zero or one images by alt text. Returns `None` when missing. */
let queryByAltText: string => option<Dom.element> = text =>
  _queryByAltText(text)->Nullable.toOption

/** Finds zero or one images by alt-text pattern. Returns `None` when missing. */
let queryByAltTextRegex: RegExp.t => option<Dom.element> = re =>
  _queryByAltTextRegex(re)->Nullable.toOption

/** Finds zero or one images by alt text with options. Returns `None` when missing. */
let queryByAltTextWith: (string, matcherOptions) => option<Dom.element> = (text, opts) =>
  _queryByAltTextWith(text, opts)->Nullable.toOption

/** Finds all images by alt text. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByAltText: string => array<Dom.element> = "queryAllByAltText"

/** Finds all images by alt-text pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByAltTextRegex: RegExp.t => array<Dom.element> = "queryAllByAltText"

/** Finds all images by alt text with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByAltTextWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByAltText"

/** Retries until an image by alt text appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByAltText: string => promise<Dom.element> = "findByAltText"

/** Retries until an image by alt-text pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByAltTextRegex: RegExp.t => promise<Dom.element> = "findByAltText"

/** Retries until an image by alt text appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByAltTextWith: (string, matcherOptions) => promise<Dom.element> = "findByAltText"

/** Retries until an image by alt text appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByAltTextWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByAltText"

/** Retries until images by alt text appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByAltText: string => promise<array<Dom.element>> = "findAllByAltText"

/** Retries until images by alt-text pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByAltTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByAltText"

/** Retries until images by alt text appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByAltTextWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByAltText"

/** Retries until images by alt text appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByAltTextWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByAltText"

/* ------------------------------------------------------------------ */
/* Queries: Title (uses matcherOptions)                                */
/* ------------------------------------------------------------------ */

/** Finds one element by title attribute, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTitle: string => Dom.element = "getByTitle"

/** Finds one element by title pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTitleRegex: RegExp.t => Dom.element = "getByTitle"

/** Finds one element by title with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTitleWith: (string, matcherOptions) => Dom.element = "getByTitle"

/** Finds all elements by title, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTitle: string => array<Dom.element> = "getAllByTitle"

/** Finds all elements by title pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTitleRegex: RegExp.t => array<Dom.element> = "getAllByTitle"

/** Finds all elements by title with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTitleWith: (string, matcherOptions) => array<Dom.element> = "getAllByTitle"

@module("@testing-library/react") @scope("screen")
external _queryByTitle: string => Nullable.t<Dom.element> = "queryByTitle"
@module("@testing-library/react") @scope("screen")
external _queryByTitleRegex: RegExp.t => Nullable.t<Dom.element> = "queryByTitle"
@module("@testing-library/react") @scope("screen")
external _queryByTitleWith: (string, matcherOptions) => Nullable.t<Dom.element> = "queryByTitle"

/** Finds zero or one elements by title. Returns `None` when missing. */
let queryByTitle: string => option<Dom.element> = text =>
  _queryByTitle(text)->Nullable.toOption

/** Finds zero or one elements by title pattern. Returns `None` when missing. */
let queryByTitleRegex: RegExp.t => option<Dom.element> = re =>
  _queryByTitleRegex(re)->Nullable.toOption

/** Finds zero or one elements by title with options. Returns `None` when missing. */
let queryByTitleWith: (string, matcherOptions) => option<Dom.element> = (text, opts) =>
  _queryByTitleWith(text, opts)->Nullable.toOption

/** Finds all elements by title. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTitle: string => array<Dom.element> = "queryAllByTitle"

/** Finds all elements by title pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTitleRegex: RegExp.t => array<Dom.element> = "queryAllByTitle"

/** Finds all elements by title with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTitleWith: (string, matcherOptions) => array<Dom.element> = "queryAllByTitle"

/** Retries until an element by title appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTitle: string => promise<Dom.element> = "findByTitle"

/** Retries until an element by title pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTitleRegex: RegExp.t => promise<Dom.element> = "findByTitle"

/** Retries until an element by title appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTitleWith: (string, matcherOptions) => promise<Dom.element> = "findByTitle"

/** Retries until an element by title appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByTitleWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByTitle"

/** Retries until elements by title appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTitle: string => promise<array<Dom.element>> = "findAllByTitle"

/** Retries until elements by title pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTitleRegex: RegExp.t => promise<array<Dom.element>> = "findAllByTitle"

/** Retries until elements by title appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTitleWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByTitle"

/** Retries until elements by title appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByTitleWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByTitle"

/* ------------------------------------------------------------------ */
/* Queries: DisplayValue (uses matcherOptions)                         */
/* ------------------------------------------------------------------ */

/** Finds one form element by display value, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByDisplayValue: string => Dom.element = "getByDisplayValue"

/** Finds one form element by display-value pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByDisplayValueRegex: RegExp.t => Dom.element = "getByDisplayValue"

/** Finds one form element by display value with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByDisplayValueWith: (string, matcherOptions) => Dom.element = "getByDisplayValue"

/** Finds all form elements by display value, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByDisplayValue: string => array<Dom.element> = "getAllByDisplayValue"

/** Finds all form elements by display-value pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByDisplayValueRegex: RegExp.t => array<Dom.element> = "getAllByDisplayValue"

/** Finds all form elements by display value with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByDisplayValueWith: (string, matcherOptions) => array<Dom.element> =
  "getAllByDisplayValue"

@module("@testing-library/react") @scope("screen")
external _queryByDisplayValue: string => Nullable.t<Dom.element> = "queryByDisplayValue"
@module("@testing-library/react") @scope("screen")
external _queryByDisplayValueRegex: RegExp.t => Nullable.t<Dom.element> = "queryByDisplayValue"
@module("@testing-library/react") @scope("screen")
external _queryByDisplayValueWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByDisplayValue"

/** Finds zero or one form elements by display value. Returns `None` when missing. */
let queryByDisplayValue: string => option<Dom.element> = value =>
  _queryByDisplayValue(value)->Nullable.toOption

/** Finds zero or one form elements by display-value pattern. Returns `None` when missing. */
let queryByDisplayValueRegex: RegExp.t => option<Dom.element> = re =>
  _queryByDisplayValueRegex(re)->Nullable.toOption

/** Finds zero or one form elements by display value with options. Returns `None` when missing. */
let queryByDisplayValueWith: (string, matcherOptions) => option<Dom.element> = (value, opts) =>
  _queryByDisplayValueWith(value, opts)->Nullable.toOption

/** Finds all form elements by display value. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValue: string => array<Dom.element> = "queryAllByDisplayValue"

/** Finds all form elements by display-value pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValueRegex: RegExp.t => array<Dom.element> = "queryAllByDisplayValue"

/** Finds all form elements by display value with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValueWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByDisplayValue"

/** Retries until a form element by display value appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByDisplayValue: string => promise<Dom.element> = "findByDisplayValue"

/** Retries until a form element by display-value pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByDisplayValueRegex: RegExp.t => promise<Dom.element> = "findByDisplayValue"

/** Retries until a form element by display value appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByDisplayValueWith: (string, matcherOptions) => promise<Dom.element> =
  "findByDisplayValue"

/** Retries until a form element by display value appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByDisplayValueWithWait: (string, matcherOptions, waitForOptions) => promise<
  Dom.element,
> = "findByDisplayValue"

/** Retries until form elements by display value appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValue: string => promise<array<Dom.element>> = "findAllByDisplayValue"

/** Retries until form elements by display-value pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueRegex: RegExp.t => promise<array<Dom.element>> =
  "findAllByDisplayValue"

/** Retries until form elements by display value appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByDisplayValue"

/** Retries until form elements by display value appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByDisplayValue"

/* ------------------------------------------------------------------ */
/* Queries: Role (uses roleOptions / roleOptionsRegex)                 */
/* ------------------------------------------------------------------ */

/** Finds one element by ARIA role, throws when missing:
    `screen.getByRole("button")`. */
@module("@testing-library/react") @scope("screen")
external getByRole: string => Dom.element = "getByRole"

/** Finds one element by ARIA role with options (e.g. accessible name),
    throws when missing: `getByRole("button", {name: "Submit"})`. */
@module("@testing-library/react") @scope("screen")
external getByRoleWith: (string, roleOptions) => Dom.element = "getByRole"

/** Finds one element by ARIA role with regex accessible name options,
    throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByRoleWithRegex: (string, roleOptionsRegex) => Dom.element = "getByRole"

/** Finds all elements with an ARIA role, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByRole: string => array<Dom.element> = "getAllByRole"

/** Finds all elements with an ARIA role with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByRoleWith: (string, roleOptions) => array<Dom.element> = "getAllByRole"

/** Finds all elements with an ARIA role with regex-name options,
    throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByRoleWithRegex: (string, roleOptionsRegex) => array<Dom.element> = "getAllByRole"

/** Finds zero or one elements by ARIA role. Returns `None` when missing. */
@module("@testing-library/react") @scope("screen")
external _queryByRole: string => Nullable.t<Dom.element> = "queryByRole"

@module("@testing-library/react") @scope("screen")
external _queryByRoleWith: (string, roleOptions) => Nullable.t<Dom.element> = "queryByRole"

@module("@testing-library/react") @scope("screen")
external _queryByRoleWithRegex: (string, roleOptionsRegex) => Nullable.t<Dom.element> =
  "queryByRole"

/** See `_queryByRole`. */
let queryByRole: string => option<Dom.element> = role => _queryByRole(role)->Nullable.toOption

/** Finds zero or one elements by ARIA role with options. Returns `None` when missing. */
let queryByRoleWith: (string, roleOptions) => option<Dom.element> = (role, opts) =>
  _queryByRoleWith(role, opts)->Nullable.toOption

/** Finds zero or one elements by ARIA role with regex-name options.
    Returns `None` when missing. */
let queryByRoleWithRegex: (string, roleOptionsRegex) => option<Dom.element> = (role, opts) =>
  _queryByRoleWithRegex(role, opts)->Nullable.toOption

/** Finds all elements by ARIA role. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByRole: string => array<Dom.element> = "queryAllByRole"

/** Finds all elements by ARIA role with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByRoleWith: (string, roleOptions) => array<Dom.element> = "queryAllByRole"

/** Finds all elements by ARIA role with regex-name options.
    Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByRoleWithRegex: (string, roleOptionsRegex) => array<Dom.element> =
  "queryAllByRole"

/** Retries until an element by ARIA role appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByRole: string => promise<Dom.element> = "findByRole"

/** Retries until an element by ARIA role appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByRoleWith: (string, roleOptions) => promise<Dom.element> = "findByRole"

/** Retries until an element by ARIA role appears, with regex-name options.
    Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByRoleWithRegex: (string, roleOptionsRegex) => promise<Dom.element> = "findByRole"

/** Retries until an element by ARIA role appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByRoleWithWait: (string, roleOptions, waitForOptions) => promise<Dom.element> =
  "findByRole"

/** Retries until elements by ARIA role appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByRole: string => promise<array<Dom.element>> = "findAllByRole"

/** Retries until elements by ARIA role appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByRoleWith: (string, roleOptions) => promise<array<Dom.element>> = "findAllByRole"

/** Retries until elements by ARIA role appear, with regex-name options.
    Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByRoleWithRegex: (string, roleOptionsRegex) => promise<array<Dom.element>> =
  "findAllByRole"

/** Retries until elements by ARIA role appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByRoleWithWait: (string, roleOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByRole"

/* ------------------------------------------------------------------ */
/* Queries: TestId (uses matcherOptions)                               */
/* ------------------------------------------------------------------ */

/** Finds one element by `data-testid`, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTestId: string => Dom.element = "getByTestId"

/** Finds one element by `data-testid` pattern, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTestIdRegex: RegExp.t => Dom.element = "getByTestId"

/** Finds one element by `data-testid` with options, throws when missing. */
@module("@testing-library/react") @scope("screen")
external getByTestIdWith: (string, matcherOptions) => Dom.element = "getByTestId"

/** Finds all elements by `data-testid`, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTestId: string => array<Dom.element> = "getAllByTestId"

/** Finds all elements by `data-testid` pattern, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTestIdRegex: RegExp.t => array<Dom.element> = "getAllByTestId"

/** Finds all elements by `data-testid` with options, throws when none match. */
@module("@testing-library/react") @scope("screen")
external getAllByTestIdWith: (string, matcherOptions) => array<Dom.element> = "getAllByTestId"

/** Finds zero or one elements by `data-testid`. Returns `None` when missing. */
@module("@testing-library/react") @scope("screen")
external _queryByTestId: string => Nullable.t<Dom.element> = "queryByTestId"

@module("@testing-library/react") @scope("screen")
external _queryByTestIdRegex: RegExp.t => Nullable.t<Dom.element> = "queryByTestId"

@module("@testing-library/react") @scope("screen")
external _queryByTestIdWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByTestId"

/** See `_queryByTestId`. */
let queryByTestId: string => option<Dom.element> = id => _queryByTestId(id)->Nullable.toOption

/** Finds zero or one elements by `data-testid` pattern. Returns `None` when missing. */
let queryByTestIdRegex: RegExp.t => option<Dom.element> = re =>
  _queryByTestIdRegex(re)->Nullable.toOption

/** Finds zero or one elements by `data-testid` with options. Returns `None` when missing. */
let queryByTestIdWith: (string, matcherOptions) => option<Dom.element> = (id, opts) =>
  _queryByTestIdWith(id, opts)->Nullable.toOption

/** Finds all elements by `data-testid`. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTestId: string => array<Dom.element> = "queryAllByTestId"

/** Finds all elements by `data-testid` pattern. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTestIdRegex: RegExp.t => array<Dom.element> = "queryAllByTestId"

/** Finds all elements by `data-testid` with options. Returns empty array when none match. */
@module("@testing-library/react") @scope("screen")
external queryAllByTestIdWith: (string, matcherOptions) => array<Dom.element> = "queryAllByTestId"

/** Retries until an element by `data-testid` appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTestId: string => promise<Dom.element> = "findByTestId"

/** Retries until an element by `data-testid` pattern appears. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTestIdRegex: RegExp.t => promise<Dom.element> = "findByTestId"

/** Retries until an element by `data-testid` appears, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findByTestIdWith: (string, matcherOptions) => promise<Dom.element> = "findByTestId"

/** Retries until an element by `data-testid` appears, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findByTestIdWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByTestId"

/** Retries until elements by `data-testid` appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTestId: string => promise<array<Dom.element>> = "findAllByTestId"

/** Retries until elements by `data-testid` pattern appear. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTestIdRegex: RegExp.t => promise<array<Dom.element>> = "findAllByTestId"

/** Retries until elements by `data-testid` appear, with options. Rejects on timeout. */
@module("@testing-library/react") @scope("screen")
external findAllByTestIdWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByTestId"

/** Retries until elements by `data-testid` appear, with options and retry tuning. */
@module("@testing-library/react") @scope("screen")
external findAllByTestIdWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByTestId"

/* ------------------------------------------------------------------ */
/* fireEvent                                                           */
/* ------------------------------------------------------------------ */

/** Clicks an element: `fireEvent.click(button)`. State updates flush
    synchronously, so no `await` is needed. */
@module("@testing-library/react") @scope("fireEvent")
external click: Dom.element => unit = "click"

/** Clicks with event init: `fireEvent.click(el, {button: 2})`. */
@module("@testing-library/react") @scope("fireEvent")
external clickWith: (Dom.element, {..}) => unit = "click"

/** Changes an input's value: `fireEvent.change(input, {"target": {"value": "x"}})`.
    The event init must be an object, so passing a non-object fails to compile. */
@module("@testing-library/react") @scope("fireEvent")
external change: (Dom.element, {..}) => unit = "change"

/** Blurs an element: `fireEvent.blur(el)`. */
@module("@testing-library/react") @scope("fireEvent")
external blur: Dom.element => unit = "blur"

/** Blurs with event init. */
@module("@testing-library/react") @scope("fireEvent")
external blurWith: (Dom.element, {..}) => unit = "blur"

/** Focuses an element: `fireEvent.focus(el)`. */
@module("@testing-library/react") @scope("fireEvent")
external focus: Dom.element => unit = "focus"

/** Focuses with event init. */
@module("@testing-library/react") @scope("fireEvent")
external focusWith: (Dom.element, {..}) => unit = "focus"

/** Moves keyboard focus to an element: `el.focus()`. Unlike
    `fireEvent.focus` (which only dispatches an event), this sets
    `document.activeElement` in jsdom, so `JestDom.toHaveFocus` passes. */
@send external focusElement: Dom.element => unit = "focus"

/** Removes keyboard focus: `el.blur()`. Unlike `fireEvent.blur`, this
    actually moves focus away, so `not->JestDom.toHaveFocus` passes. */
@send external blurElement: Dom.element => unit = "blur"

/** Fires an input event: `fireEvent.input(el, {"target": {"value": "x"}})`. */
@module("@testing-library/react") @scope("fireEvent")
external input: (Dom.element, {..}) => unit = "input"

/** Fires a submit event on a form. */
@module("@testing-library/react") @scope("fireEvent")
external submit: Dom.element => unit = "submit"

/** Fires a submit event with init. */
@module("@testing-library/react") @scope("fireEvent")
external submitWith: (Dom.element, {..}) => unit = "submit"

/** Fires a reset event on a form. */
@module("@testing-library/react") @scope("fireEvent")
external reset: Dom.element => unit = "reset"

/** Fires a keyDown event. */
@module("@testing-library/react") @scope("fireEvent")
external keyDown: (Dom.element, {..}) => unit = "keyDown"

/** Fires a keyPress event. */
@module("@testing-library/react") @scope("fireEvent")
external keyPress: (Dom.element, {..}) => unit = "keyPress"

/** Fires a keyUp event. */
@module("@testing-library/react") @scope("fireEvent")
external keyUp: (Dom.element, {..}) => unit = "keyUp"

/** Fires a double-click event. */
@module("@testing-library/react") @scope("fireEvent")
external dblClick: Dom.element => unit = "dblClick"

/** Fires a double-click event with init. */
@module("@testing-library/react") @scope("fireEvent")
external dblClickWith: (Dom.element, {..}) => unit = "dblClick"

/** Fires a context-menu (right-click) event. */
@module("@testing-library/react") @scope("fireEvent")
external contextMenu: Dom.element => unit = "contextMenu"

/** Fires a mouseDown event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseDown: Dom.element => unit = "mouseDown"

/** Fires a mouseUp event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseUp: Dom.element => unit = "mouseUp"

/** Fires a mouseEnter event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseEnter: Dom.element => unit = "mouseEnter"

/** Fires a mouseLeave event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseLeave: Dom.element => unit = "mouseLeave"

/** Fires a mouseMove event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseMove: Dom.element => unit = "mouseMove"

/** Fires a mouseOver event. */
@module("@testing-library/react") @scope("fireEvent")
external mouseOver: Dom.element => unit = "mouseOver"

/** Fires a select event (text selection in inputs). */
@module("@testing-library/react") @scope("fireEvent")
external select: Dom.element => unit = "select"

/** Fires a copy event. */
@module("@testing-library/react") @scope("fireEvent")
external copy: Dom.element => unit = "copy"

/** Fires a cut event. */
@module("@testing-library/react") @scope("fireEvent")
external cut: Dom.element => unit = "cut"

/** Fires a paste event. */
@module("@testing-library/react") @scope("fireEvent")
external paste: Dom.element => unit = "paste"

/** Fires a scroll event. */
@module("@testing-library/react") @scope("fireEvent")
external scroll: Dom.element => unit = "scroll"

/** Fires a wheel event. */
@module("@testing-library/react") @scope("fireEvent")
external wheel: Dom.element => unit = "wheel"

/** Fires a dragStart event. */
@module("@testing-library/react") @scope("fireEvent")
external dragStart: Dom.element => unit = "dragStart"

/** Fires a dragEnd event. */
@module("@testing-library/react") @scope("fireEvent")
external dragEnd: Dom.element => unit = "dragEnd"

/** Fires a drop event. */
@module("@testing-library/react") @scope("fireEvent")
external drop: Dom.element => unit = "drop"

/* ------------------------------------------------------------------ */
/* Async helpers / within / debug / config                             */
/* ------------------------------------------------------------------ */

/** Retries `callback` until it stops throwing (for async UI updates):
    `await waitFor(() => { ... })`. */
@module("@testing-library/react") external waitFor: (unit => 'a) => promise<'a> = "waitFor"

/** Retries `callback` until it stops throwing, with retry tuning. */
@module("@testing-library/react")
external waitForWith: (unit => 'a, waitForOptions) => promise<'a> = "waitFor"

/** Waits until `callback` stops throwing because its element was removed.
    Callback form: `await waitForElementToBeRemoved(() => getByText("hi"))`. */
@module("@testing-library/react")
external waitForElementToBeRemoved: (unit => 'a) => promise<unit> = "waitForElementToBeRemoved"

/** Waits until the given element is removed from the document. */
@module("@testing-library/react")
external waitForElementToBeRemovedElement: Dom.element => promise<unit> =
  "waitForElementToBeRemoved"

/** Opaque scoped query set from `within(element)`. */
type withinResult

/** Scopes all queries to a subtree: `within(container)->withinGetByText("hi")`. */
@module("@testing-library/react") external within: Dom.element => withinResult = "within"

/** `within(container).getByText(text)`. */
@send external withinGetByText: (withinResult, string) => Dom.element = "getByText"

/** `within(container).getByRole(role)`. */
@send external withinGetByRole: (withinResult, string) => Dom.element = "getByRole"

/** `within(container).getByRole(role, options)`. */
@send external withinGetByRoleWith: (withinResult, string, roleOptions) => Dom.element = "getByRole"

/** `within(container).getByTestId(id)`. */
@send external withinGetByTestId: (withinResult, string) => Dom.element = "getByTestId"

/** `within(container).getByLabelText(text)`. */
@send external withinGetByLabelText: (withinResult, string) => Dom.element = "getByLabelText"

/** `within(container).getAllByRole(role)`. */
@send external withinGetAllByRole: (withinResult, string) => array<Dom.element> = "getAllByRole"

/** `within(container).queryByText(text)` (null-safe via option). */
@send external _withinQueryByText: (withinResult, string) => Nullable.t<Dom.element> = "queryByText"

/** See `_withinQueryByText`. */
let withinQueryByText: (withinResult, string) => option<Dom.element> = (scope, text) =>
  _withinQueryByText(scope, text)->Nullable.toOption

/** `within(container).queryAllByText(text)`. */
@send external withinQueryAllByText: (withinResult, string) => array<Dom.element> =
  "queryAllByText"

/** `within(container).findByText(text)`. */
@send external withinFindByText: (withinResult, string) => promise<Dom.element> = "findByText"

/** `within(container).findByRole(role)`. */
@send external withinFindByRole: (withinResult, string) => promise<Dom.element> = "findByRole"

/** Prints the current DOM (`screen.debug()`). */
@module("@testing-library/react") @scope("screen") external debug: unit => unit = "debug"

/** Global config: `configure({testIdAttribute: "data-my-id"})`. */
@module("@testing-library/dom") external configure: {..} => unit = "configure"

/** Unmounts all rendered trees. Call in `afterEach`:
    `Vitest.afterEach(TestingLibrary.cleanup)`. */
@module("@testing-library/react") external cleanup: unit => unit = "cleanup"
