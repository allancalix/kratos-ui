open Jest
open JestDom

describe("DynamicInputComponent", () => {
    open ReactTestingLibrary

    let attrs: Kratos.uiNodeInputAttributes = {
      name: "password",
      required: Some(true),
      \"type": "password",
      value: None,
      disabled: false,
      pattern: None,
      label: None,
    }

    test("when type is not hidden type then matches expected", () =>
      <DynamicInput attributes={attrs} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when type is hidden then matches snapshot", () =>
      <DynamicInput attributes={{...attrs, \"type": "hidden"}} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when type is not hidden then has visible label", () =>
      <DynamicInput attributes={attrs} />
        |> render
        |> getByTestId(~matcher=#Str("label"))
        |> expect
        |> toHaveTextContent(#Str("password"))
    )
})
