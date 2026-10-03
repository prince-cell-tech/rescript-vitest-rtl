/* Proof tests for the TestingLibrary + JestDom bindings against App. */

Vitest.afterEach(TestingLibrary.cleanup)

Vitest.describe("App", () => {
  Vitest.test("renders the heading", () => {
    TestingLibrary.render(<App />)->ignore
    let heading = TestingLibrary.getByText("ReScript + Vite + React")
    Expect.expect(heading)->Expect.toBeInTheDocument
    Expect.expect(heading)->Expect.toBeVisible
    Expect.expect(heading)->Expect.toHaveClass("title")
    Expect.expect(heading)->Expect.toHaveTextContentRegex(/Vite/)
  })

  Vitest.test("finds elements by test id, role, and placeholder", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(TestingLibrary.getByTestId("app-heading"))->Expect.toBeInTheDocument
    Expect.expect(TestingLibrary.getByRole("heading"))->Expect.toHaveTextContent(
      "ReScript + Vite + React",
    )
    Expect.expect(TestingLibrary.getByRole("textbox"))->Expect.toBeInTheDocument
    Expect.expect(TestingLibrary.getByLabelText("Name"))->Expect.toBeInTheDocument
    Expect.expect(TestingLibrary.getByPlaceholderText("Type your name"))->Expect.toBeInTheDocument
    Expect.expect(TestingLibrary.getAllByRole("button")->Array.length)->Expect.toBe(3)
  })

  Vitest.test("counter increments on click", () => {
    TestingLibrary.render(<App />)->ignore
    let button = TestingLibrary.getByText("count is 0")
    TestingLibrary.click(button)
    Expect.expect(TestingLibrary.getByText("count is 1"))->Expect.toBeInTheDocument
    TestingLibrary.click(TestingLibrary.getByText("count is 1"))
    Expect.expect(TestingLibrary.getByText("count is 2"))->Expect.toBeInTheDocument
  })

  Vitest.test("reset zeroes the counter", () => {
    TestingLibrary.render(<App />)->ignore
    TestingLibrary.click(TestingLibrary.getByText("count is 0"))
    TestingLibrary.click(TestingLibrary.getByText("Reset"))
    Expect.expect(TestingLibrary.getByText("count is 0"))->Expect.toBeInTheDocument
  })

  Vitest.test("typing in the input updates the greeting", () => {
    TestingLibrary.render(<App />)->ignore
    let input = TestingLibrary.getByLabelText("Name")
    TestingLibrary.change(input, {"target": {"value": "Ada"}})
    Expect.expect(input)->Expect.toHaveValue("Ada")
    Expect.expect(TestingLibrary.getByText("Hello, Ada"))->Expect.toBeInTheDocument
  })

  Vitest.test("submit button is disabled, counter is enabled", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(TestingLibrary.getByText("Submit"))->Expect.toBeDisabled
    Expect.expect(TestingLibrary.getByText("count is 0"))->Expect.toBeEnabled
  })

  Vitest.test("submit enables after typing", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(TestingLibrary.getByText("Submit"))->Expect.toBeVisible
    TestingLibrary.change(TestingLibrary.getByLabelText("Name"), {"target": {"value": "Ada"}})
    Expect.expect(TestingLibrary.getByText("Submit"))->Expect.toBeEnabled
  })

  Vitest.test("finds buttons by role with accessible-name options", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(
      TestingLibrary.getByRoleWith("button", {name: "Reset"}),
    )->Expect.toBeInTheDocument
    Expect.expect(
      TestingLibrary.getByRoleWithRegex("button", {name: /Reset/}),
    )->Expect.toBeInTheDocument
    Expect.expect(
      TestingLibrary.getAllByRoleWith("button", {name: "Reset"})->Array.length,
    )->Expect.toBe(1)
    Expect.expect(
      TestingLibrary.queryByRoleWith("button", {name: "no-such-button"})->Option.isNone,
    )->Expect.toBe(true)
  })

  Vitest.test("finds text by regex and exact options", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(TestingLibrary.getByTextRegex(/count is/))->Expect.toBeInTheDocument
    Expect.expect(
      TestingLibrary.getByTextWith("count is 0", {exact: true}),
    )->Expect.toBeInTheDocument
    Expect.expect(TestingLibrary.queryAllByText("count is 0")->Array.length)->Expect.toBe(1)
    Expect.expect(TestingLibrary.queryAllByRole("button")->Array.length)->Expect.toBe(3)
  })

  Vitest.test("queryBy wrappers return options", () => {
    TestingLibrary.render(<App />)->ignore
    Expect.expect(TestingLibrary.queryByText("count is 0")->Option.isSome)->Expect.toBe(true)
    Expect.expect(TestingLibrary.queryByText("nope-not-here")->Option.isNone)->Expect.toBe(true)
    Expect.expect(TestingLibrary.queryByTestId("app-heading")->Option.isSome)->Expect.toBe(true)
    Expect.expect(TestingLibrary.queryByLabelText("Name")->Option.isSome)->Expect.toBe(true)
  })

  Vitest.testAsync("findBy resolves for synchronously rendered UI", async () => {
    TestingLibrary.render(<App />)->ignore
    let button = await TestingLibrary.findByText("count is 0")
    Expect.expect(button)->Expect.toBeInTheDocument
    let buttons = await TestingLibrary.findAllByRole("button")
    Expect.expect(buttons->Array.length)->Expect.toBe(3)
    let heading = await TestingLibrary.findByRoleWith("heading", {level: 1})
    Expect.expect(heading)->Expect.toHaveTextContent("ReScript + Vite + React")
  })

  Vitest.test("focus and blur update focus state", () => {
    TestingLibrary.render(<App />)->ignore
    let input = TestingLibrary.getByLabelText("Name")
    TestingLibrary.focusElement(input)
    Expect.expect(input)->Expect.toHaveFocus
    TestingLibrary.blurElement(input)
    Expect.expect(input)->Expect.not->Expect.toHaveFocus
  })

  Vitest.test("jest-dom attribute and accessible matchers", () => {
    TestingLibrary.render(<App />)->ignore
    let input = TestingLibrary.getByLabelText("Name")
    Expect.expect(input)->Expect.toHaveAttribute("placeholder")
    Expect.expect(input)->Expect.toHaveAttributeWith("placeholder", "Type your name")
    Expect.expect(input)->Expect.toHaveAccessibleNameWith("Name")
    Expect.expect(TestingLibrary.getByTestId("app-heading"))->Expect.toHaveRole("heading")
    Expect.expect(TestingLibrary.getByRole("textbox"))->Expect.toHaveAccessibleNameWith("Name")
  })

  Vitest.test("within scopes queries and input shows display value", () => {
    let result = TestingLibrary.render(<App />)
    let container = result->TestingLibrary.container
    Expect.expect(container)->Expect.toContainElement(TestingLibrary.getByText("count is 0"))
    Expect.expect(
      TestingLibrary.within(container)->TestingLibrary.withinGetByText("Reset"),
    )->Expect.toBeInTheDocument
    Expect.expect(
      TestingLibrary.within(container)
      ->TestingLibrary.withinQueryByText("count is 0")
      ->Option.isSome,
    )->Expect.toBe(true)
    let input = TestingLibrary.getByLabelText("Name")
    TestingLibrary.change(input, {"target": {"value": "Ada"}})
    Expect.expect(input)->Expect.toHaveDisplayValue("Ada")
    Expect.expect(container)->Expect.toContainAnyByText("Hello, Ada")
  })
})
