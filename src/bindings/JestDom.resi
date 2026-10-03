/* Interface for JestDom bindings — keeps `external`s inlinable.
   Mirrors JestDom.res exactly (attributes included). See it for docs. */

type exactOptions = {
  exact: bool,
}

type textContentOptions = {
  normalizeWhitespace?: bool,
}

@send external toBeInTheDocument: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInTheDocument"
@send external toBeVisible: Vitest.assertion<'a, Vitest.sync> => unit = "toBeVisible"
@send external toBeInTheDOM: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInTheDOM"
@send external toBeEmpty: Vitest.assertion<'a, Vitest.sync> => unit = "toBeEmpty"
@send external toBeEmptyDOMElement: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBeEmptyDOMElement"
@send external toBeDisabled: Vitest.assertion<'a, Vitest.sync> => unit = "toBeDisabled"
@send external toBeEnabled: Vitest.assertion<'a, Vitest.sync> => unit = "toBeEnabled"
@send external toBeInvalid: Vitest.assertion<'a, Vitest.sync> => unit = "toBeInvalid"
@send external toBeRequired: Vitest.assertion<'a, Vitest.sync> => unit = "toBeRequired"
@send external toBeValid: Vitest.assertion<'a, Vitest.sync> => unit = "toBeValid"
@send external toBeChecked: Vitest.assertion<'a, Vitest.sync> => unit = "toBeChecked"
@send external toBePartiallyChecked: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBePartiallyChecked"
@send external toBePressed: Vitest.assertion<'a, Vitest.sync> => unit = "toBePressed"
@send external toBePartiallyPressed: Vitest.assertion<'a, Vitest.sync> => unit =
  "toBePartiallyPressed"
@send external toHaveFocus: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveFocus"
@send external toHaveTextContent: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveTextContent"
@send external toHaveTextContentRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit = "toHaveTextContent"
@send external toHaveTextContentWith: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
  textContentOptions,
) => unit = "toHaveTextContent"
@send external toHaveTextContentRegexWith: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
  textContentOptions,
) => unit = "toHaveTextContent"
@send external toHaveValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveValue"
@send external toHaveValueInt: (Vitest.assertion<'a, Vitest.sync>, int) => unit = "toHaveValue"
@send external toHaveValueFloat: (Vitest.assertion<'a, Vitest.sync>, float) => unit = "toHaveValue"
@send external toHaveValues: (Vitest.assertion<'a, Vitest.sync>, array<string>) => unit =
  "toHaveValue"
@send external toHaveValueNullable: (Vitest.assertion<'a, Vitest.sync>, Nullable.t<string>) => unit =
  "toHaveValue"
@send external toHaveDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveDisplayValue"
@send external toHaveDisplayValueRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveDisplayValue"
@send external toHaveDisplayValues: (Vitest.assertion<'a, Vitest.sync>, array<string>) => unit =
  "toHaveDisplayValue"
@send external toHaveClass: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveClass"
@send external toHaveClassRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveClass"
@send external toHaveClassExact: (Vitest.assertion<'a, Vitest.sync>, string, exactOptions) => unit =
  "toHaveClass"
@send external toHaveAttribute: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAttribute"
@send external toHaveAttributeWith: (Vitest.assertion<'a, Vitest.sync>, string, 'b) => unit =
  "toHaveAttribute"
@send external toContainElement: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toContainElement"
@send external toContainHTML: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toContainHTML"
@send external toHaveFormValues: (Vitest.assertion<'a, Vitest.sync>, {..}) => unit =
  "toHaveFormValues"
@send external toHaveStyle: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveStyle"
@send external toHaveStyleObject: (Vitest.assertion<'a, Vitest.sync>, {..}) => unit = "toHaveStyle"
@send external toHaveRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit = "toHaveRole"
@send external toHaveSelectionWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveSelection"
@send external toHaveNoSelection: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveSelection"
@send external toHaveDescription: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveDescription"
@send external toHaveDescriptionRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveDescription"
@send external toHaveNoDescription: Vitest.assertion<'a, Vitest.sync> => unit = "toHaveDescription"
@send external toHaveAccessibleDescription: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleDescription"
@send external toHaveAccessibleDescriptionWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAccessibleDescription"
@send external toHaveAccessibleDescriptionRegex: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
) => unit = "toHaveAccessibleDescription"
@send external toHaveAccessibleErrorMessage: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleErrorMessage"
@send external toHaveAccessibleErrorMessageWith: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
) => unit = "toHaveAccessibleErrorMessage"
@send external toHaveAccessibleErrorMessageRegex: (
  Vitest.assertion<'a, Vitest.sync>,
  RegExp.t,
) => unit = "toHaveAccessibleErrorMessage"
@send external toHaveAccessibleName: Vitest.assertion<'a, Vitest.sync> => unit =
  "toHaveAccessibleName"
@send external toHaveAccessibleNameWith: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveAccessibleName"
@send external toHaveAccessibleNameRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveAccessibleName"
@send external toHaveErrorMessage: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toHaveErrorMessage"
@send external toHaveErrorMessageRegex: (Vitest.assertion<'a, Vitest.sync>, RegExp.t) => unit =
  "toHaveErrorMessage"
@send external toAppearBefore: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toAppearBefore"
@send external toAppearAfter: (Vitest.assertion<'a, Vitest.sync>, Dom.element) => unit =
  "toAppearAfter"
@send external toContainAnyByAltText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByAltText"
@send external toContainOneByAltText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByAltText"
@send external toContainAnyByDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByDisplayValue"
@send external toContainOneByDisplayValue: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByDisplayValue"
@send external toContainAnyByLabelText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByLabelText"
@send external toContainOneByLabelText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByLabelText"
@send external toContainAnyByPlaceholderText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByPlaceholderText"
@send external toContainOneByPlaceholderText: (
  Vitest.assertion<'a, Vitest.sync>,
  string,
) => unit = "toContainOneByPlaceholderText"
@send external toContainAnyByRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByRole"
@send external toContainOneByRole: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByRole"
@send external toContainAnyByTestId: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByTestId"
@send external toContainOneByTestId: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByTestId"
@send external toContainAnyByText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByText"
@send external toContainOneByText: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByText"
@send external toContainAnyByTitle: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainAnyByTitle"
@send external toContainOneByTitle: (Vitest.assertion<'a, Vitest.sync>, string) => unit =
  "toContainOneByTitle"
