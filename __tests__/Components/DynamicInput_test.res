open Jest
open JestDom

describe("DynamicInputComponent", () => {
    open ReactTestingLibrary

    let field: Kratos.inputField = {
      name: "password",
      required: true,
      \"type": "password",
      value: "",
    }

    test("when type is not hidden type then matches expected", () =>
      <DynamicInput field={field} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when type is hidden then matches snapshot", () =>
      <DynamicInput field={{...field, \"type": "hidden"}} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when type is not hidden then has visible label", () =>
      <DynamicInput field={field} />
        |> render
        |> getByTestId(~matcher=#Str("label"))
        |> expect
        |> toHaveTextContent(#Str("password"))
    )
})
