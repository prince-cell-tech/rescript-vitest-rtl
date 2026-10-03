/* Interface for TestingLibrary bindings — keeps `external`s inlinable.
   Mirrors TestingLibrary.res exactly (attributes included). See it for docs. */

type renderResult

@module("@testing-library/react") external render: React.element => renderResult = "render"
@send external unmount: renderResult => unit = "unmount"
@send external rerender: (renderResult, React.element) => unit = "rerender"
@get external container: renderResult => Dom.element = "container"

type matcherOptions = {
  exact?: bool,
  trim?: bool,
  collapseWhitespace?: bool,
  suggest?: bool,
}

type textOptions = {
  exact?: bool,
  trim?: bool,
  collapseWhitespace?: bool,
  suggest?: bool,
  selector?: string,
  ignore?: string,
}

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

type waitForOptions = {
  timeout?: int,
  interval?: int,
}

@module("@testing-library/react") @scope("screen")
external getByLabelText: string => Dom.element = "getByLabelText"
@module("@testing-library/react") @scope("screen")
external getByLabelTextRegex: RegExp.t => Dom.element = "getByLabelText"
@module("@testing-library/react") @scope("screen")
external getByLabelTextWith: (string, textOptions) => Dom.element = "getByLabelText"
@module("@testing-library/react") @scope("screen")
external getAllByLabelText: string => array<Dom.element> = "getAllByLabelText"
@module("@testing-library/react") @scope("screen")
external getAllByLabelTextRegex: RegExp.t => array<Dom.element> = "getAllByLabelText"
@module("@testing-library/react") @scope("screen")
external getAllByLabelTextWith: (string, textOptions) => array<Dom.element> = "getAllByLabelText"
@module("@testing-library/react") @scope("screen")
external _queryByLabelText: string => Nullable.t<Dom.element> = "queryByLabelText"
@module("@testing-library/react") @scope("screen")
external _queryByLabelTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByLabelText"
@module("@testing-library/react") @scope("screen")
external _queryByLabelTextWith: (string, textOptions) => Nullable.t<Dom.element> =
  "queryByLabelText"
let queryByLabelText: string => option<Dom.element>
let queryByLabelTextRegex: RegExp.t => option<Dom.element>
let queryByLabelTextWith: (string, textOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByLabelText: string => array<Dom.element> = "queryAllByLabelText"
@module("@testing-library/react") @scope("screen")
external queryAllByLabelTextRegex: RegExp.t => array<Dom.element> = "queryAllByLabelText"
@module("@testing-library/react") @scope("screen")
external queryAllByLabelTextWith: (string, textOptions) => array<Dom.element> =
  "queryAllByLabelText"
@module("@testing-library/react") @scope("screen")
external findByLabelText: string => promise<Dom.element> = "findByLabelText"
@module("@testing-library/react") @scope("screen")
external findByLabelTextRegex: RegExp.t => promise<Dom.element> = "findByLabelText"
@module("@testing-library/react") @scope("screen")
external findByLabelTextWith: (string, textOptions) => promise<Dom.element> = "findByLabelText"
@module("@testing-library/react") @scope("screen")
external findByLabelTextWithWait: (string, textOptions, waitForOptions) => promise<Dom.element> =
  "findByLabelText"
@module("@testing-library/react") @scope("screen")
external findAllByLabelText: string => promise<array<Dom.element>> = "findAllByLabelText"
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByLabelText"
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextWith: (string, textOptions) => promise<array<Dom.element>> =
  "findAllByLabelText"
@module("@testing-library/react") @scope("screen")
external findAllByLabelTextWithWait: (string, textOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByLabelText"

@module("@testing-library/react") @scope("screen")
external getByPlaceholderText: string => Dom.element = "getByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external getByPlaceholderTextRegex: RegExp.t => Dom.element = "getByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external getByPlaceholderTextWith: (string, matcherOptions) => Dom.element =
  "getByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external getAllByPlaceholderText: string => array<Dom.element> = "getAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external getAllByPlaceholderTextRegex: RegExp.t => array<Dom.element> =
  "getAllByPlaceholderText"
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
let queryByPlaceholderText: string => option<Dom.element>
let queryByPlaceholderTextRegex: RegExp.t => option<Dom.element>
let queryByPlaceholderTextWith: (string, matcherOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderText: string => array<Dom.element> = "queryAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderTextRegex: RegExp.t => array<Dom.element> =
  "queryAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external queryAllByPlaceholderTextWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findByPlaceholderText: string => promise<Dom.element> = "findByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextRegex: RegExp.t => promise<Dom.element> = "findByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextWith: (string, matcherOptions) => promise<Dom.element> =
  "findByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findByPlaceholderTextWithWait: (string, matcherOptions, waitForOptions) => promise<
  Dom.element,
> = "findByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderText: string => promise<array<Dom.element>> =
  "findAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextRegex: RegExp.t => promise<array<Dom.element>> =
  "findAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByPlaceholderText"
@module("@testing-library/react") @scope("screen")
external findAllByPlaceholderTextWithWait: (
  string,
  matcherOptions,
  waitForOptions,
) => promise<array<Dom.element>> = "findAllByPlaceholderText"

@module("@testing-library/react") @scope("screen")
external getByText: string => Dom.element = "getByText"
@module("@testing-library/react") @scope("screen")
external getByTextRegex: RegExp.t => Dom.element = "getByText"
@module("@testing-library/react") @scope("screen")
external getByTextWith: (string, textOptions) => Dom.element = "getByText"
@module("@testing-library/react") @scope("screen")
external getAllByText: string => array<Dom.element> = "getAllByText"
@module("@testing-library/react") @scope("screen")
external getAllByTextRegex: RegExp.t => array<Dom.element> = "getAllByText"
@module("@testing-library/react") @scope("screen")
external getAllByTextWith: (string, textOptions) => array<Dom.element> = "getAllByText"
@module("@testing-library/react") @scope("screen")
external _queryByText: string => Nullable.t<Dom.element> = "queryByText"
@module("@testing-library/react") @scope("screen")
external _queryByTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByText"
@module("@testing-library/react") @scope("screen")
external _queryByTextWith: (string, textOptions) => Nullable.t<Dom.element> = "queryByText"
let queryByText: string => option<Dom.element>
let queryByTextRegex: RegExp.t => option<Dom.element>
let queryByTextWith: (string, textOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByText: string => array<Dom.element> = "queryAllByText"
@module("@testing-library/react") @scope("screen")
external queryAllByTextRegex: RegExp.t => array<Dom.element> = "queryAllByText"
@module("@testing-library/react") @scope("screen")
external queryAllByTextWith: (string, textOptions) => array<Dom.element> = "queryAllByText"
@module("@testing-library/react") @scope("screen")
external findByText: string => promise<Dom.element> = "findByText"
@module("@testing-library/react") @scope("screen")
external findByTextRegex: RegExp.t => promise<Dom.element> = "findByText"
@module("@testing-library/react") @scope("screen")
external findByTextWith: (string, textOptions) => promise<Dom.element> = "findByText"
@module("@testing-library/react") @scope("screen")
external findByTextWithWait: (string, textOptions, waitForOptions) => promise<Dom.element> =
  "findByText"
@module("@testing-library/react") @scope("screen")
external findAllByText: string => promise<array<Dom.element>> = "findAllByText"
@module("@testing-library/react") @scope("screen")
external findAllByTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByText"
@module("@testing-library/react") @scope("screen")
external findAllByTextWith: (string, textOptions) => promise<array<Dom.element>> =
  "findAllByText"
@module("@testing-library/react") @scope("screen")
external findAllByTextWithWait: (string, textOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByText"

@module("@testing-library/react") @scope("screen")
external getByAltText: string => Dom.element = "getByAltText"
@module("@testing-library/react") @scope("screen")
external getByAltTextRegex: RegExp.t => Dom.element = "getByAltText"
@module("@testing-library/react") @scope("screen")
external getByAltTextWith: (string, matcherOptions) => Dom.element = "getByAltText"
@module("@testing-library/react") @scope("screen")
external getAllByAltText: string => array<Dom.element> = "getAllByAltText"
@module("@testing-library/react") @scope("screen")
external getAllByAltTextRegex: RegExp.t => array<Dom.element> = "getAllByAltText"
@module("@testing-library/react") @scope("screen")
external getAllByAltTextWith: (string, matcherOptions) => array<Dom.element> = "getAllByAltText"
@module("@testing-library/react") @scope("screen")
external _queryByAltText: string => Nullable.t<Dom.element> = "queryByAltText"
@module("@testing-library/react") @scope("screen")
external _queryByAltTextRegex: RegExp.t => Nullable.t<Dom.element> = "queryByAltText"
@module("@testing-library/react") @scope("screen")
external _queryByAltTextWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByAltText"
let queryByAltText: string => option<Dom.element>
let queryByAltTextRegex: RegExp.t => option<Dom.element>
let queryByAltTextWith: (string, matcherOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByAltText: string => array<Dom.element> = "queryAllByAltText"
@module("@testing-library/react") @scope("screen")
external queryAllByAltTextRegex: RegExp.t => array<Dom.element> = "queryAllByAltText"
@module("@testing-library/react") @scope("screen")
external queryAllByAltTextWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByAltText"
@module("@testing-library/react") @scope("screen")
external findByAltText: string => promise<Dom.element> = "findByAltText"
@module("@testing-library/react") @scope("screen")
external findByAltTextRegex: RegExp.t => promise<Dom.element> = "findByAltText"
@module("@testing-library/react") @scope("screen")
external findByAltTextWith: (string, matcherOptions) => promise<Dom.element> = "findByAltText"
@module("@testing-library/react") @scope("screen")
external findByAltTextWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByAltText"
@module("@testing-library/react") @scope("screen")
external findAllByAltText: string => promise<array<Dom.element>> = "findAllByAltText"
@module("@testing-library/react") @scope("screen")
external findAllByAltTextRegex: RegExp.t => promise<array<Dom.element>> = "findAllByAltText"
@module("@testing-library/react") @scope("screen")
external findAllByAltTextWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByAltText"
@module("@testing-library/react") @scope("screen")
external findAllByAltTextWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByAltText"

@module("@testing-library/react") @scope("screen")
external getByTitle: string => Dom.element = "getByTitle"
@module("@testing-library/react") @scope("screen")
external getByTitleRegex: RegExp.t => Dom.element = "getByTitle"
@module("@testing-library/react") @scope("screen")
external getByTitleWith: (string, matcherOptions) => Dom.element = "getByTitle"
@module("@testing-library/react") @scope("screen")
external getAllByTitle: string => array<Dom.element> = "getAllByTitle"
@module("@testing-library/react") @scope("screen")
external getAllByTitleRegex: RegExp.t => array<Dom.element> = "getAllByTitle"
@module("@testing-library/react") @scope("screen")
external getAllByTitleWith: (string, matcherOptions) => array<Dom.element> = "getAllByTitle"
@module("@testing-library/react") @scope("screen")
external _queryByTitle: string => Nullable.t<Dom.element> = "queryByTitle"
@module("@testing-library/react") @scope("screen")
external _queryByTitleRegex: RegExp.t => Nullable.t<Dom.element> = "queryByTitle"
@module("@testing-library/react") @scope("screen")
external _queryByTitleWith: (string, matcherOptions) => Nullable.t<Dom.element> = "queryByTitle"
let queryByTitle: string => option<Dom.element>
let queryByTitleRegex: RegExp.t => option<Dom.element>
let queryByTitleWith: (string, matcherOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByTitle: string => array<Dom.element> = "queryAllByTitle"
@module("@testing-library/react") @scope("screen")
external queryAllByTitleRegex: RegExp.t => array<Dom.element> = "queryAllByTitle"
@module("@testing-library/react") @scope("screen")
external queryAllByTitleWith: (string, matcherOptions) => array<Dom.element> = "queryAllByTitle"
@module("@testing-library/react") @scope("screen")
external findByTitle: string => promise<Dom.element> = "findByTitle"
@module("@testing-library/react") @scope("screen")
external findByTitleRegex: RegExp.t => promise<Dom.element> = "findByTitle"
@module("@testing-library/react") @scope("screen")
external findByTitleWith: (string, matcherOptions) => promise<Dom.element> = "findByTitle"
@module("@testing-library/react") @scope("screen")
external findByTitleWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByTitle"
@module("@testing-library/react") @scope("screen")
external findAllByTitle: string => promise<array<Dom.element>> = "findAllByTitle"
@module("@testing-library/react") @scope("screen")
external findAllByTitleRegex: RegExp.t => promise<array<Dom.element>> = "findAllByTitle"
@module("@testing-library/react") @scope("screen")
external findAllByTitleWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByTitle"
@module("@testing-library/react") @scope("screen")
external findAllByTitleWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByTitle"

@module("@testing-library/react") @scope("screen")
external getByDisplayValue: string => Dom.element = "getByDisplayValue"
@module("@testing-library/react") @scope("screen")
external getByDisplayValueRegex: RegExp.t => Dom.element = "getByDisplayValue"
@module("@testing-library/react") @scope("screen")
external getByDisplayValueWith: (string, matcherOptions) => Dom.element = "getByDisplayValue"
@module("@testing-library/react") @scope("screen")
external getAllByDisplayValue: string => array<Dom.element> = "getAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external getAllByDisplayValueRegex: RegExp.t => array<Dom.element> = "getAllByDisplayValue"
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
let queryByDisplayValue: string => option<Dom.element>
let queryByDisplayValueRegex: RegExp.t => option<Dom.element>
let queryByDisplayValueWith: (string, matcherOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValue: string => array<Dom.element> = "queryAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValueRegex: RegExp.t => array<Dom.element> = "queryAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external queryAllByDisplayValueWith: (string, matcherOptions) => array<Dom.element> =
  "queryAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findByDisplayValue: string => promise<Dom.element> = "findByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findByDisplayValueRegex: RegExp.t => promise<Dom.element> = "findByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findByDisplayValueWith: (string, matcherOptions) => promise<Dom.element> =
  "findByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findByDisplayValueWithWait: (string, matcherOptions, waitForOptions) => promise<
  Dom.element,
> = "findByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValue: string => promise<array<Dom.element>> = "findAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueRegex: RegExp.t => promise<array<Dom.element>> =
  "findAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByDisplayValue"
@module("@testing-library/react") @scope("screen")
external findAllByDisplayValueWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByDisplayValue"

@module("@testing-library/react") @scope("screen")
external getByRole: string => Dom.element = "getByRole"
@module("@testing-library/react") @scope("screen")
external getByRoleWith: (string, roleOptions) => Dom.element = "getByRole"
@module("@testing-library/react") @scope("screen")
external getByRoleWithRegex: (string, roleOptionsRegex) => Dom.element = "getByRole"
@module("@testing-library/react") @scope("screen")
external getAllByRole: string => array<Dom.element> = "getAllByRole"
@module("@testing-library/react") @scope("screen")
external getAllByRoleWith: (string, roleOptions) => array<Dom.element> = "getAllByRole"
@module("@testing-library/react") @scope("screen")
external getAllByRoleWithRegex: (string, roleOptionsRegex) => array<Dom.element> = "getAllByRole"
@module("@testing-library/react") @scope("screen")
external _queryByRole: string => Nullable.t<Dom.element> = "queryByRole"
@module("@testing-library/react") @scope("screen")
external _queryByRoleWith: (string, roleOptions) => Nullable.t<Dom.element> = "queryByRole"
@module("@testing-library/react") @scope("screen")
external _queryByRoleWithRegex: (string, roleOptionsRegex) => Nullable.t<Dom.element> =
  "queryByRole"
let queryByRole: string => option<Dom.element>
let queryByRoleWith: (string, roleOptions) => option<Dom.element>
let queryByRoleWithRegex: (string, roleOptionsRegex) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByRole: string => array<Dom.element> = "queryAllByRole"
@module("@testing-library/react") @scope("screen")
external queryAllByRoleWith: (string, roleOptions) => array<Dom.element> = "queryAllByRole"
@module("@testing-library/react") @scope("screen")
external queryAllByRoleWithRegex: (string, roleOptionsRegex) => array<Dom.element> =
  "queryAllByRole"
@module("@testing-library/react") @scope("screen")
external findByRole: string => promise<Dom.element> = "findByRole"
@module("@testing-library/react") @scope("screen")
external findByRoleWith: (string, roleOptions) => promise<Dom.element> = "findByRole"
@module("@testing-library/react") @scope("screen")
external findByRoleWithRegex: (string, roleOptionsRegex) => promise<Dom.element> = "findByRole"
@module("@testing-library/react") @scope("screen")
external findByRoleWithWait: (string, roleOptions, waitForOptions) => promise<Dom.element> =
  "findByRole"
@module("@testing-library/react") @scope("screen")
external findAllByRole: string => promise<array<Dom.element>> = "findAllByRole"
@module("@testing-library/react") @scope("screen")
external findAllByRoleWith: (string, roleOptions) => promise<array<Dom.element>> = "findAllByRole"
@module("@testing-library/react") @scope("screen")
external findAllByRoleWithRegex: (string, roleOptionsRegex) => promise<array<Dom.element>> =
  "findAllByRole"
@module("@testing-library/react") @scope("screen")
external findAllByRoleWithWait: (string, roleOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByRole"

@module("@testing-library/react") @scope("screen")
external getByTestId: string => Dom.element = "getByTestId"
@module("@testing-library/react") @scope("screen")
external getByTestIdRegex: RegExp.t => Dom.element = "getByTestId"
@module("@testing-library/react") @scope("screen")
external getByTestIdWith: (string, matcherOptions) => Dom.element = "getByTestId"
@module("@testing-library/react") @scope("screen")
external getAllByTestId: string => array<Dom.element> = "getAllByTestId"
@module("@testing-library/react") @scope("screen")
external getAllByTestIdRegex: RegExp.t => array<Dom.element> = "getAllByTestId"
@module("@testing-library/react") @scope("screen")
external getAllByTestIdWith: (string, matcherOptions) => array<Dom.element> = "getAllByTestId"
@module("@testing-library/react") @scope("screen")
external _queryByTestId: string => Nullable.t<Dom.element> = "queryByTestId"
@module("@testing-library/react") @scope("screen")
external _queryByTestIdRegex: RegExp.t => Nullable.t<Dom.element> = "queryByTestId"
@module("@testing-library/react") @scope("screen")
external _queryByTestIdWith: (string, matcherOptions) => Nullable.t<Dom.element> =
  "queryByTestId"
let queryByTestId: string => option<Dom.element>
let queryByTestIdRegex: RegExp.t => option<Dom.element>
let queryByTestIdWith: (string, matcherOptions) => option<Dom.element>
@module("@testing-library/react") @scope("screen")
external queryAllByTestId: string => array<Dom.element> = "queryAllByTestId"
@module("@testing-library/react") @scope("screen")
external queryAllByTestIdRegex: RegExp.t => array<Dom.element> = "queryAllByTestId"
@module("@testing-library/react") @scope("screen")
external queryAllByTestIdWith: (string, matcherOptions) => array<Dom.element> = "queryAllByTestId"
@module("@testing-library/react") @scope("screen")
external findByTestId: string => promise<Dom.element> = "findByTestId"
@module("@testing-library/react") @scope("screen")
external findByTestIdRegex: RegExp.t => promise<Dom.element> = "findByTestId"
@module("@testing-library/react") @scope("screen")
external findByTestIdWith: (string, matcherOptions) => promise<Dom.element> = "findByTestId"
@module("@testing-library/react") @scope("screen")
external findByTestIdWithWait: (string, matcherOptions, waitForOptions) => promise<Dom.element> =
  "findByTestId"
@module("@testing-library/react") @scope("screen")
external findAllByTestId: string => promise<array<Dom.element>> = "findAllByTestId"
@module("@testing-library/react") @scope("screen")
external findAllByTestIdRegex: RegExp.t => promise<array<Dom.element>> = "findAllByTestId"
@module("@testing-library/react") @scope("screen")
external findAllByTestIdWith: (string, matcherOptions) => promise<array<Dom.element>> =
  "findAllByTestId"
@module("@testing-library/react") @scope("screen")
external findAllByTestIdWithWait: (string, matcherOptions, waitForOptions) => promise<
  array<Dom.element>,
> = "findAllByTestId"

@module("@testing-library/react") @scope("fireEvent")
external click: Dom.element => unit = "click"
@module("@testing-library/react") @scope("fireEvent")
external clickWith: (Dom.element, {..}) => unit = "click"
@module("@testing-library/react") @scope("fireEvent")
external change: (Dom.element, {..}) => unit = "change"
@module("@testing-library/react") @scope("fireEvent")
external blur: Dom.element => unit = "blur"
@module("@testing-library/react") @scope("fireEvent")
external blurWith: (Dom.element, {..}) => unit = "blur"
@module("@testing-library/react") @scope("fireEvent")
external focus: Dom.element => unit = "focus"
@module("@testing-library/react") @scope("fireEvent")
external focusWith: (Dom.element, {..}) => unit = "focus"
@send external focusElement: Dom.element => unit = "focus"
@send external blurElement: Dom.element => unit = "blur"
@module("@testing-library/react") @scope("fireEvent")
external input: (Dom.element, {..}) => unit = "input"
@module("@testing-library/react") @scope("fireEvent")
external submit: Dom.element => unit = "submit"
@module("@testing-library/react") @scope("fireEvent")
external submitWith: (Dom.element, {..}) => unit = "submit"
@module("@testing-library/react") @scope("fireEvent")
external reset: Dom.element => unit = "reset"
@module("@testing-library/react") @scope("fireEvent")
external keyDown: (Dom.element, {..}) => unit = "keyDown"
@module("@testing-library/react") @scope("fireEvent")
external keyPress: (Dom.element, {..}) => unit = "keyPress"
@module("@testing-library/react") @scope("fireEvent")
external keyUp: (Dom.element, {..}) => unit = "keyUp"
@module("@testing-library/react") @scope("fireEvent")
external dblClick: Dom.element => unit = "dblClick"
@module("@testing-library/react") @scope("fireEvent")
external dblClickWith: (Dom.element, {..}) => unit = "dblClick"
@module("@testing-library/react") @scope("fireEvent")
external contextMenu: Dom.element => unit = "contextMenu"
@module("@testing-library/react") @scope("fireEvent")
external mouseDown: Dom.element => unit = "mouseDown"
@module("@testing-library/react") @scope("fireEvent")
external mouseUp: Dom.element => unit = "mouseUp"
@module("@testing-library/react") @scope("fireEvent")
external mouseEnter: Dom.element => unit = "mouseEnter"
@module("@testing-library/react") @scope("fireEvent")
external mouseLeave: Dom.element => unit = "mouseLeave"
@module("@testing-library/react") @scope("fireEvent")
external mouseMove: Dom.element => unit = "mouseMove"
@module("@testing-library/react") @scope("fireEvent")
external mouseOver: Dom.element => unit = "mouseOver"
@module("@testing-library/react") @scope("fireEvent")
external select: Dom.element => unit = "select"
@module("@testing-library/react") @scope("fireEvent")
external copy: Dom.element => unit = "copy"
@module("@testing-library/react") @scope("fireEvent")
external cut: Dom.element => unit = "cut"
@module("@testing-library/react") @scope("fireEvent")
external paste: Dom.element => unit = "paste"
@module("@testing-library/react") @scope("fireEvent")
external scroll: Dom.element => unit = "scroll"
@module("@testing-library/react") @scope("fireEvent")
external wheel: Dom.element => unit = "wheel"
@module("@testing-library/react") @scope("fireEvent")
external dragStart: Dom.element => unit = "dragStart"
@module("@testing-library/react") @scope("fireEvent")
external dragEnd: Dom.element => unit = "dragEnd"
@module("@testing-library/react") @scope("fireEvent")
external drop: Dom.element => unit = "drop"

@module("@testing-library/react") external waitFor: (unit => 'a) => promise<'a> = "waitFor"
@module("@testing-library/react")
external waitForWith: (unit => 'a, waitForOptions) => promise<'a> = "waitFor"
@module("@testing-library/react")
external waitForElementToBeRemoved: (unit => 'a) => promise<unit> = "waitForElementToBeRemoved"
@module("@testing-library/react")
external waitForElementToBeRemovedElement: Dom.element => promise<unit> =
  "waitForElementToBeRemoved"

type withinResult

@module("@testing-library/react") external within: Dom.element => withinResult = "within"
@send external withinGetByText: (withinResult, string) => Dom.element = "getByText"
@send external withinGetByRole: (withinResult, string) => Dom.element = "getByRole"
@send external withinGetByRoleWith: (withinResult, string, roleOptions) => Dom.element = "getByRole"
@send external withinGetByTestId: (withinResult, string) => Dom.element = "getByTestId"
@send external withinGetByLabelText: (withinResult, string) => Dom.element = "getByLabelText"
@send external withinGetAllByRole: (withinResult, string) => array<Dom.element> = "getAllByRole"
@send external _withinQueryByText: (withinResult, string) => Nullable.t<Dom.element> = "queryByText"
let withinQueryByText: (withinResult, string) => option<Dom.element>
@send external withinQueryAllByText: (withinResult, string) => array<Dom.element> =
  "queryAllByText"
@send external withinFindByText: (withinResult, string) => promise<Dom.element> = "findByText"
@send external withinFindByRole: (withinResult, string) => promise<Dom.element> = "findByRole"

@module("@testing-library/react") @scope("screen") external debug: unit => unit = "debug"
@module("@testing-library/dom") external configure: {..} => unit = "configure"
@module("@testing-library/react") external cleanup: unit => unit = "cleanup"
