/* Bindings for @testing-library/jest-dom 7 matchers.
 *
 * Docs: https://github.com/testing-library/jest-dom
 *
 * These extend Vitest's `expect` at runtime (registered once via
 * vitest.setup.js), so they are typed as `@send` matchers on
 * `Vitest.assertion<'a, Vitest.sync>`, consistent with Vitest.res:
 *   Vitest.expect(el)->JestDom.toBeInTheDocument
 *
 * Only sync matchers are bound; async DOM assertions go through
 * `TestingLibrary.waitFor` instead.
 *
 * Overload convention (ReScript has no overloading, so one JS matcher
 * gets several ReScript names):
 * - `toHaveX(string)` for exact/partial string form.
 * - `toHaveXRegex(%re(...))` for the RegExp form.
 * - `toHaveXWith(value, opts)` where upstream takes an options object.
 * - Absence checks (upstream called with no argument, e.g.
 *   `not.toHaveDescription()`) are bound as `toHaveNoX`.
 *
 * Deprecated upstream matchers (`toBeInTheDOM`, `toBeEmpty`,
 * `toHaveDescription`, `toHaveErrorMessage`) are still bound because
 * jest-dom 7.0.1 ships them; prefer their replacements.
 */

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
@send external toBeInTheDocument: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInTheDocument"

/** Asserts element visibility: `expect(el)->toBeVisible`. */
@send external toBeVisible: Vitest.assertion<'a, Vitest.sync> => unit = "toBeVisible"

/** @deprecated since v1.9.0, use `toBeInTheDocument`. */
@send external toBeInTheDOM: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInTheDOM"

/** @deprecated since v5.9.0, use `toBeEmptyDOMElement`. */
@send external toBeEmpty: Vitest.assertion<'a, Vitest.sync> => unit = "toBeEmpty"

/** Asserts an element has no content: `expect(el)->toBeEmptyDOMElement`. */
@send external toBeEmptyDOMElement: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBeEmptyDOMElement"

/** Asserts the element is disabled: `expect(el)->toBeDisabled`. */
@send external toBeDisabled: Vitest.assertion<'a, Vitest.sync> => unit = "toBeDisabled"

/** Asserts the element is enabled: `expect(el)->toBeEnabled`. */
@send external toBeEnabled: Vitest.assertion<'a, Vitest.sync> => unit = "toBeEnabled"

/** Asserts a form element is invalid: `expect(form)->toBeInvalid`. */
@send external toBeInvalid: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInvalid"

/** Asserts a form element is required: `expect(input)->toBeRequired`. */
@send external toBeRequired: Vitest.assertion<'a, Vitest.sync> => unit = "toBeRequired"

/** Asserts a form element is valid: `expect(form)->toBeValid`. */
@send external toBeValid: Vitest.assertion<'a, Vitest.sync> => unit = "toBeValid"

/** Asserts a checkbox/radio is checked: `expect(input)->toBeChecked`. */
@send external toBeChecked: Vitest.assertion<'a, Vitest.sync> => unit = "toBeChecked"

/** Asserts a checkbox is partially checked (`aria-checked="mixed"`). */
@send external toBePartiallyChecked: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBePartiallyChecked"

/** Asserts a button is pressed (`aria-pressed="true"`). */
@send external toBePressed: Vitest.assertion<'a, Vitest.sync> => unit = "toBePressed"

/** Asserts a button is partially pressed (`aria-pressed="mixed"`). */
@send external toBePartiallyPressed: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBePartiallyPressed"

/** Asserts an element has focus: `expect(input)->toHaveFocus`. */
@send external toHaveFocus: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveFocus"

/** Asserts exact text content: `expect(el)->toHaveTextContent("hi")`. */
@send external toHaveTextContent: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveTextContent"

/** Asserts text content by pattern: `expect(el)->toHaveTextContentRegex(%re("/^hi/"))`. */
@send external toHaveTextContentRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit = "toHaveTextContent"

/** Asserts text content with whitespace options. */
@send external toHaveTextContentWith: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
  textContentOptions,
) => unit = "toHaveTextContent"

/** Asserts text-content pattern with whitespace options. */
@send external toHaveTextContentRegexWith: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
  textContentOptions,
) => unit = "toHaveTextContent"

/** Asserts an input's value: `expect(input)->toHaveValue("typed")`. */
@send external toHaveValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveValue"

/** Asserts a numeric input's value: `expect(input)->toHaveValueInt(5)`. */
@send external toHaveValueInt: (Vitest.assertion<'a, Vitest.sync>, int) => unit = "toHaveValue"

/** Asserts a numeric input's float value. */
@send external toHaveValueFloat: (Vitest.assertion<'a, Vitest.sync>, float) => unit = "toHaveValue"

/** Asserts a multi-select's values: `expect(sel)->toHaveValues(["a", "b"])`. */
@send external toHaveValues: (Vitest.assertion<'a, Vitest.sync>, array<string>) => unit =
  "toHaveValue"

/** Asserts an empty/null value: `expect(input)->toHaveValueNullable(Nullable.null)`. */
@send external toHaveValueNullable: (Vitest.assertion<'a, Vitest.sync>, Nullable.t<string>) => unit =
  "toHaveValue"

/** Asserts a form element's displayed value: `expect(input)->toHaveDisplayValue("Luca")`. */
@send external toHaveDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveDisplayValue"

/** Asserts a form element's displayed value by pattern. */
@send external toHaveDisplayValueRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveDisplayValue"

/** Asserts a multi-select's displayed values. */
@send external toHaveDisplayValues: (Vitest.assertion<'a, Vitest.sync>, array<string>) => unit =
  "toHaveDisplayValue"

/** Asserts a CSS class is present: `expect(el)->toHaveClass("active")`.
    Space-separated strings match several classes. */
@send external toHaveClass: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveClass"

/** Asserts a CSS class pattern is present. */
@send external toHaveClassRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveClass"

/** Asserts exact class membership: `expect(el)->toHaveClassExact("a b", {exact: true})`. */
@send external toHaveClassExact: (Vitest.assertion<'a, Vitest.sync>, string, exactOptions) => unit =
  "toHaveClass"

/** Asserts an attribute is present: `expect(btn)->toHaveAttribute("disabled")`. */
@send external toHaveAttribute: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAttribute"

/** Asserts an attribute value: `expect(btn)->toHaveAttributeWith("type", "submit")`.
    The value is generic so strings, regexes, and asymmetric matchers all type-check. */
@send external toHaveAttributeWith: (Vitest.assertion<'a, Vitest.sync>, string, 'b) => unit =
  "toHaveAttribute"

/** Asserts an element contains another: `expect(parent)->toContainElement(child)`. */
@send external toContainElement: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toContainElement"

/** Asserts serialized HTML containment: `expect(el)->toContainHTML("<span />")`. */
@send external toContainHTML: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toContainHTML"

/** Asserts form values: `expect(form)->toHaveFormValues({"username": "jane"})`. */
@send external toHaveFormValues: (Vitest.assertion<'a, Vitest.sync>, {..}) => unit =
  "toHaveFormValues"

/** Asserts CSS declarations: `expect(el)->toHaveStyle("color: red")`. */
@send external toHaveStyle: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveStyle"

/** Asserts CSS declarations as an object: `expect(el)->toHaveStyleObject({"color": "red"})`. */
@send external toHaveStyleObject: (Vitest.assertion<'a, Vitest.sync>, {..}) => unit = "toHaveStyle"

/** Asserts implicit/explicit ARIA role: `expect(btn)->toHaveRole("button")`. */
@send external toHaveRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveRole"

/** Asserts text selection: `expect(input)->toHaveSelectionWith("selected")`. */
@send external toHaveSelectionWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveSelection"

/** Asserts an element has no text selection. */
@send external toHaveNoSelection: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveSelection"

/** @deprecated, use `toHaveAccessibleDescription`. */
@send external toHaveDescription: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveDescription"

/** @deprecated regex form of `toHaveDescription`. */
@send external toHaveDescriptionRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveDescription"

/** @deprecated absence form: `expect(el)->Vitest.not->toHaveNoDescription`. */
@send external toHaveNoDescription: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveDescription"

/** Asserts presence of an accessible description. */
@send external toHaveAccessibleDescription: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleDescription"

/** Asserts an accessible description value. */
@send external toHaveAccessibleDescriptionWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAccessibleDescription"

/** Asserts an accessible description pattern. */
@send external toHaveAccessibleDescriptionRegex: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
) => unit = "toHaveAccessibleDescription"

/** Asserts presence of an accessible error message. */
@send external toHaveAccessibleErrorMessage: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleErrorMessage"

/** Asserts an accessible error message value. */
@send external toHaveAccessibleErrorMessageWith: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
) => unit = "toHaveAccessibleErrorMessage"

/** Asserts an accessible error-message pattern. */
@send external toHaveAccessibleErrorMessageRegex: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
) => unit = "toHaveAccessibleErrorMessage"

/** Asserts presence of an accessible name. */
@send external toHaveAccessibleName: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleName"

/** Asserts an accessible name value: `expect(input)->toHaveAccessibleNameWith("Name")`. */
@send external toHaveAccessibleNameWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAccessibleName"

/** Asserts an accessible-name pattern. */
@send external toHaveAccessibleNameRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveAccessibleName"

/** @deprecated since v5.17.0, use `toHaveAccessibleErrorMessage`. */
@send external toHaveErrorMessage: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveErrorMessage"

/** @deprecated regex form of `toHaveErrorMessage`. */
@send external toHaveErrorMessageRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveErrorMessage"

/** Asserts DOM order: `expect(a)->toAppearBefore(b)`. */
@send external toAppearBefore: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toAppearBefore"

/** Asserts DOM order: `expect(b)->toAppearAfter(a)`. */
@send external toAppearAfter: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toAppearAfter"

/** Asserts an element contains a descendant by alt text. */
@send external toContainAnyByAltText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByAltText"

/** Asserts an element contains exactly one descendant by alt text. */
@send external toContainOneByAltText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByAltText"

/** Asserts an element contains a descendant by display value. */
@send external toContainAnyByDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByDisplayValue"

/** Asserts an element contains exactly one descendant by display value. */
@send external toContainOneByDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByDisplayValue"

/** Asserts an element contains a descendant by label text. */
@send external toContainAnyByLabelText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByLabelText"

/** Asserts an element contains exactly one descendant by label text. */
@send external toContainOneByLabelText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByLabelText"

/** Asserts an element contains a descendant by placeholder text. */
@send external toContainAnyByPlaceholderText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByPlaceholderText"

/** Asserts an element contains exactly one descendant by placeholder text. */
@send external toContainOneByPlaceholderText: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
) => unit = "toContainOneByPlaceholderText"

/** Asserts an element contains a descendant by role. */
@send external toContainAnyByRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByRole"

/** Asserts an element contains exactly one descendant by role. */
@send external toContainOneByRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByRole"

/** Asserts an element contains a descendant by test id. */
@send external toContainAnyByTestId: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByTestId"

/** Asserts an element contains exactly one descendant by test id. */
@send external toContainOneByTestId: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByTestId"

/** Asserts an element contains a descendant by text. */
@send external toContainAnyByText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByText"

/** Asserts an element contains exactly one descendant by text. */
@send external toContainOneByText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByText"

/** Asserts an element contains a descendant by title. */
@send external toContainAnyByTitle: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByTitle"

/** Asserts an element contains exactly one descendant by title. */
@send external toContainOneByTitle: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByTitle"
